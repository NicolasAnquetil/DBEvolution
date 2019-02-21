Class {
	#name : #DBEModifyStoredProcedureSource,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'storedProcedure',
		'newSourceCode'
	],
	#category : #'DBEvolution-Operators-StoredProcedure'
}

{ #category : #accessing }
DBEModifyStoredProcedureSource >> newSourceCode [
	^ newSourceCode
]

{ #category : #accessing }
DBEModifyStoredProcedureSource >> newSourceCode: anObject [
	newSourceCode := anObject
]

{ #category : #accessing }
DBEModifyStoredProcedureSource >> storedProcedure [
	^ storedProcedure
]

{ #category : #accessing }
DBEModifyStoredProcedureSource >> storedProcedure: anObject [
	storedProcedure := anObject
]
