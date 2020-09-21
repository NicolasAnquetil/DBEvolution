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
	| aggregatedOperators |
	aggregatedOperators := OrderedCollection new.
	((self operators select: #isRenameReference) groupedBy: #sourcedBelonger) associationsDo: [ :assoc |
		aggregatedOperators 
			add: (assoc key terminalOperatorToModifyReferenceFromNonTerminalOperator: assoc value) -> assoc value ].
	aggregatedOperators do: [ :assoc |
		self operators at: (self operators detectIndex: [ :op | assoc value includes: op ]) put: assoc key.
		self operators: (self operators reject: [ :op | assoc value includes: op ]) ]
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
	| storedProceduresRelatedOperators aggregatedOperators |
	storedProceduresRelatedOperators := self operators select: #concernsStoredProcedure.
	aggregatedOperators := OrderedCollection new.
	(storedProceduresRelatedOperators groupedBy: #storedProcedure)
		keysAndValuesDo: [ :storedProcedure :operatorsToAggregate |
			|aggregatedOperator|
			aggregatedOperator := DBEModifyStoredProcedure storedProcedure: storedProcedure.
			operatorsToAggregate do: [ :operatorToAggregate |
				operatorToAggregate beAggregatedIn: aggregatedOperator ].
			aggregatedOperators add: aggregatedOperator ].
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

	"entities impacted recursively"
	viewsAndStoredProceduresToConsider :=
		(aCollection collect: [ :operator |
			{ operator entity . operator entity allDepending } ]) flattened asSet.
	"create an 'identityOperator' on the entities added recursively (so that they will be dropped and recreated identically)"
	operatorsToConsider := viewsAndStoredProceduresToConsider collect: [ :viewOrStoredProcedure |
		aCollection
			detect: [ :op | op entity = viewOrStoredProcedure ]
			ifNone: [ viewOrStoredProcedure identityModifyOperator ] ].
	"lists in 'dependencies' dependences between operators: for each operator, search in its dependencies if there is an entity used in another operator"
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
