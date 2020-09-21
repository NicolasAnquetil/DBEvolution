Class {
	#name : #DBEStoredProcedureOperator,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'storedProcedure'
	],
	#category : #'DBEvolution-Operators-StoredProcedure'
}

{ #category : #'instance creation' }
DBEStoredProcedureOperator class >> storedProcedure: storedProcedure [
	^ self new
		storedProcedure: storedProcedure;
		yourself
]

{ #category : #accessing }
DBEStoredProcedureOperator >> entity [
	^ self storedProcedure
]

{ #category : #accessing }
DBEStoredProcedureOperator >> maximalImpactSet [
	^ self storedProcedure maximalImpactSet
]

{ #category : #accessing }
DBEStoredProcedureOperator >> storedProcedure [
	^ storedProcedure
]

{ #category : #accessing }
DBEStoredProcedureOperator >> storedProcedure: anObject [
	storedProcedure := anObject
]

{ #category : #accessing }
DBEStoredProcedureOperator >> templateArgumentsDictionary [
	"Returns a Dictionary containing the values to be substituted in the template."
	^ { 
		'storedProcedureName' -> self storedProcedure name
	 } asDictionary
]
