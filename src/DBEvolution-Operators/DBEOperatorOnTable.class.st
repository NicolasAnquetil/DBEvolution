Class {
	#name : #DBEOperatorOnTable,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'targetTable'
	],
	#category : #'DBEvolution-Operators-Table'
}

{ #category : #private }
DBEOperatorOnTable >> isColumnReferenceConstraint: entity [
	entity isColumnReference ifFalse: [ ^false ].
	^entity source isConstraint
]

{ #category : #private }
DBEOperatorOnTable >> isColumnReferenceForeignKeyTarget: entity [
	^entity isColumnReference and: [
		entity foreignKeyConstraintSource isNotNil
	]
]

{ #category : #private }
DBEOperatorOnTable >> isColumnReferenceNotConstraint: entity [
	entity isColumnReference ifFalse: [ ^false ].
	^entity source isConstraint not
]

{ #category : #private }
DBEOperatorOnTable >> isTableReferenceNotQualifyingAColumn: entity [
	entity isTableReference ifFalse: [ ^ false ].
	entity qualifiedReference ifNil: [ ^true ].
	^entity qualifiedReference references noneSatisfy: [ :ref | ref isColumnReference ]

]

{ #category : #private }
DBEOperatorOnTable >> isTableReferenceQualifyingAColumn: entity [ 
	entity isTableReference ifFalse: [ ^false ].
	entity qualifiedReference ifNil: [ ^ false ].
	^entity qualifiedReference references anySatisfy: [ :ref | ref isColumnReference ]
]

{ #category : #accessing }
DBEOperatorOnTable >> maximalImpactSet [
	"Returns the maximal impact set of the operator."
	^ self targetTable maximalImpactSet
]

{ #category : #printing }
DBEOperatorOnTable >> printArgumentsForSpecOn: aStream [
	super printArgumentsForSpecOn: aStream.
	aStream
		nextPutAll: self targetTable name
]

{ #category : #accessing }
DBEOperatorOnTable >> targetTable [
	^ targetTable
]

{ #category : #accessing }
DBEOperatorOnTable >> targetTable: anObject [
	targetTable := anObject
]

{ #category : #accessing }
DBEOperatorOnTable >> templateArgumentsDictionary [
	^ { 
		#tableName -> self targetTable name
	} asDictionary
]
