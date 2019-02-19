Class {
	#name : #DBEOperatorTargettingColumnInModel,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'targetColumn'
	],
	#category : #'DBEvolution-Operators-Column'
}

{ #category : #accessing }
DBEOperatorTargettingColumnInModel >> maximalImpactSet [
	"Returns the maximal impact set of the operator."
	^ self targetColumn maximalImpactSet
]

{ #category : #accessing }
DBEOperatorTargettingColumnInModel >> targetColumn [
	^ targetColumn
]

{ #category : #accessing }
DBEOperatorTargettingColumnInModel >> targetColumn: anObject [
	targetColumn := anObject
]

{ #category : #accessing }
DBEOperatorTargettingColumnInModel >> templateArgumentsDictionary [
	^ { 
		#columnName -> self targetColumn name.
		#tableName -> self targetColumn table name
	} asDictionary
]
