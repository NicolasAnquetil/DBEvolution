Class {
	#name : #DBEOperatorOnTable,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'targetTable'
	],
	#category : #'DBEvolution-Operators-Table'
}

{ #category : #accessing }
DBEOperatorOnTable >> maximalImpactSet [
	"Returns the maximal impact set of the operator."
	^ self targetTable maximalImpactSet
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
