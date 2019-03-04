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
DBEStoredProcedureOperator >> storedProcedure [
	^ storedProcedure
]

{ #category : #accessing }
DBEStoredProcedureOperator >> storedProcedure: anObject [
	storedProcedure := anObject
]
