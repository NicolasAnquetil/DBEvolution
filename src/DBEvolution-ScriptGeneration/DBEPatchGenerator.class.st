Class {
	#name : #DBEPatchGenerator,
	#superclass : #Object,
	#instVars : [
		'operators'
	],
	#category : #'DBEvolution-ScriptGeneration'
}

{ #category : #transformation }
DBEPatchGenerator >> aggregateReferencesRenamingOperators [
	"does more than aggregating Renaming operators,
	also convert them to (and replace them by) entity-oriented operators"
	| aggregatedOperators |
	aggregatedOperators := OrderedCollection new.
	((self operators select: #isRenameReference) groupedBy: #sourcedBelonger) associationsDo: [ :assoc |
		"create entity-oriented operator (ex: DBEModifyStoredProcedureSource) for each
		 sourcedBelonger
		 + associates it with old reference-oriented operators (for next step)
		 Could put the old  reference-oriented operators inside the new entity-oriented operator"
		aggregatedOperators 
			add: (assoc key referenceOperatorToEntityOperator: assoc value) -> assoc value ].
	aggregatedOperators do: [ :assoc |
	   "replaces in 'self operators' one old renaming operator by the associated new entity-oriented operator ..."
		self operators at: (self operators detectIndex: [ :op | assoc value includes: op ]) put: assoc key.
	   "... removes all other old renaming operators associated to this new entity-oriented operator"
		self operators: (self operators reject: [ :op | assoc value includes: op ]) ].
	self flag: 'seems to me that this would be equivalent (and more purpose revealing):
	self operators: (
		(self operators reject: #isRenameReference)
		,
		aggregatedOperators keys
	)'
]

{ #category : #transformation }
DBEPatchGenerator >> convertModifyOperatorsToDeleteCreate [
	| modifyOperators |
	modifyOperators := self operators select: #needRemoveRecreate.
	modifyOperators := self sortViewsAndStoredProceduresModifications: modifyOperators.
	self operators:
		(modifyOperators reversed collect: #asRemove) ,
		(self operators reject: #needRemoveRecreate) ,
		(modifyOperators collect: #asCreate)
]

{ #category : #transformation }
DBEPatchGenerator >> convertStoredProcedureRelatedOperatorsToModify [
	"this one works on (entity-oriented) storedProcedure operators
	 There are more kinds of them (e.g. DBERenameStoredProcedureParameter) and they
	 are all grouped in a DBEModifyStoredProcedure operator that can record all
	 changes to be done: body, local variables, parameters"
	| storedProceduresRelatedOperators aggregatedOperators |
	storedProceduresRelatedOperators := self operators select: #concernsStoredProcedure.
	aggregatedOperators := OrderedCollection new.
	"preceeding method #aggregateReferencesRenamingOperators already aggregated operators on #sourcedBelonger
	 But here we are considering more than just #referenceRenaming operators"
	(storedProceduresRelatedOperators groupedBy: #storedProcedure)
		keysAndValuesDo: [ :storedProcedure :operatorsToAggregate |
			|aggregatedOperator|
			"for each storedProcedure, create a DBEModifyStoredProcedure that gathers all
			changes to be done on that procedure"
			aggregatedOperator := DBEModifyStoredProcedure storedProcedure: storedProcedure.
			operatorsToAggregate do: [ :operatorToAggregate |
				operatorToAggregate beAggregatedIn: aggregatedOperator ].
			aggregatedOperators add: aggregatedOperator ].
	 "remove all old storedProcedure operators and add instead new DBEModifyStoredProcedure ones"
	self operators: aggregatedOperators , (self operators reject: #concernsStoredProcedure)
]

{ #category : #accessing }
DBEPatchGenerator >> operators [
	^ operators
]

{ #category : #accessing }
DBEPatchGenerator >> operators: anObject [
	operators := anObject
]

{ #category : #transformation }
DBEPatchGenerator >> removeDoNothingOperators [
	self flag: #TOFIX. "Should have two kind of operators: those able to generate queries and those only there for semantic durng decision process. For now this methods filter the operators in a hard-coded way."
	^ self operators: (self operators reject: [ :op | {DBEDoNothing } includes: op class ])
]

{ #category : #running }
DBEPatchGenerator >> run [
	self
		removeDoNothingOperators;
		aggregateReferencesRenamingOperators;
		convertStoredProcedureRelatedOperatorsToModify;
		convertModifyOperatorsToDeleteCreate
]

{ #category : #sorting }
DBEPatchGenerator >> sortViewsAndStoredProceduresModifications: aCollection [ 
	| dependencies orderedOperators viewsAndStoredProceduresToConsider operatorsToConsider |

	"all entities impacted (recursively)"
	viewsAndStoredProceduresToConsider :=
		(aCollection collect: [ :operator |
			{ operator entity . operator entity allDepending } ]) flattened asSet.
	"keep existing operators on impacted entities that have one
	 add an 'identityModifyOperator' for the others
	 this 'identityModifyOperator' is a specific (to each entity, eg DBEModifyStoredProcedure) modify operator that actually does not modify anything in this case"
	operatorsToConsider := viewsAndStoredProceduresToConsider collect: [ :viewOrStoredProcedure |
		aCollection
			detect: [ :op | op entity = viewOrStoredProcedure ]
			ifNone: [ viewOrStoredProcedure identityModifyOperator ] ].
	"computes dependencies between operators:
		for each operator, search in its dependencies if there is an entity used in another operator"
	dependencies := OrderedCollection new.
	operatorsToConsider do: [ :operator |
		(operator entity allDependencies) do: [ :viewOrStoredProcedureDependency |
			operatorsToConsider
				detect: [ :anyOp | anyOp entity = viewOrStoredProcedureDependency ]
			 	ifFound: [ :op | dependencies add: operator -> op ] ] ].
	"and finally sorts the operators according to dependencies"
	orderedOperators := (MalTopologicalSorting new
					nodes: operatorsToConsider;
					edges: dependencies from: #key to: #value;
					run) collect: #model.
	^ orderedOperators
]
