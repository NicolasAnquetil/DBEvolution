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
	((self operators select: #isRenameReference) groupedBy: [ :ref |
		ref reference source sourcedBelonger ]) associationsDo: [ :assoc |
			|updatedSourceCode|
			updatedSourceCode := self applyReferenceRenamings: assoc value to: assoc key source.
			assoc key isView
				ifTrue: [ 
					aggregatedOperators 
						add: (DBEModifyViewQuery new
								view: assoc key;
								newQueryString: updatedSourceCode;
								yourself) -> assoc value ]
				ifFalse: [ 
					aggregatedOperators 
						add: (DBEModifyStoredProcedureSource new
								storedProcedure: assoc key;
								newSourceCode: updatedSourceCode;
								yourself) -> assoc value ] ].
	aggregatedOperators do: [ :assoc |
		self operators at: (self operators detectIndex: [ :op | assoc value includes: op ]) put: assoc key.
		self operators: (self operators reject: [ :op | assoc value includes: op ]) ]
]

{ #category : #private }
DBEPatchGenerator >> applyReferenceRenamings: referenceRenamings to: sourceCode [
	"To be sure the order stays the same in this method."
	| orderedReferenceRenamings lastIndex |
	orderedReferenceRenamings := referenceRenamings asOrderedCollection sorted: [ :a :b | a reference start < b reference start ].
	lastIndex := 1.
	^ String streamContents: [ :stream |
		orderedReferenceRenamings do: [ :referenceRename |
			(referenceRename reference start > lastIndex)
				ifTrue: [ 
					stream << (sourceCode copyFrom: lastIndex to: referenceRename reference start - 1).
					lastIndex := referenceRename reference start ].
			referenceRename reference start = lastIndex
				ifTrue: [ stream << referenceRename newReferenceName ].
			lastIndex := referenceRename reference end + 1 ].
		lastIndex < sourceCode size
			ifTrue: [ stream << (sourceCode copyFrom: lastIndex to: sourceCode size) ] ]
]

{ #category : #transformation }
DBEPatchGenerator >> convertModifyOperatorsToDeleteCreate [
	| modifyOperators |
	modifyOperators := self operators select: #isModify.
	modifyOperators := self sortViewsAndStoredProceduresModifications: modifyOperators.
	self operators:
		(modifyOperators reversed collect: #asRemove) ,
		(self operators reject: #isModify) ,
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

{ #category : #sorting }
DBEPatchGenerator >> sortViewsAndStoredProceduresModifications: aCollection [ 
	| dependencies orderedOperators viewsAndStoredProceduresToConsider operatorsToConsider |
	viewsAndStoredProceduresToConsider := (aCollection collect: [ :operator |
		{ operator entity . operator entity allViewsDepending , operator entity allStoredProceduresDepending } ]) flattened asSet.
	operatorsToConsider := viewsAndStoredProceduresToConsider collect: [ :viewOrStoredProcedure |
		aCollection
			detect: [ :op | op entity = viewOrStoredProcedure ]
			ifNone: [ viewOrStoredProcedure identityModifyOperator ] ].
	dependencies := OrderedCollection new.
	operatorsToConsider do: [ :operator |
		(operator entity viewsDependencies , operator entity storedProceduresDependencies) do: [ :viewOrStoredProcedureDependency |
			operatorsToConsider
				detect: [ :anyOp | anyOp entity = viewOrStoredProcedureDependency ]
			 	ifFound: [ :op | dependencies add: operator -> op ] ] ].
	orderedOperators := (MalTopologicalSorting new
					nodes: operatorsToConsider;
					edges: dependencies from: #key to: #value;
					run) collect: #model.
	^ orderedOperators
]
