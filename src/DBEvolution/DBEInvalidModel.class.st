Class {
	#name : #DBEInvalidModel,
	#superclass : #DBEError,
	#instVars : [
		'model'
	],
	#category : #'DBEvolution-Errors'
}

{ #category : #'instance creation' }
DBEInvalidModel class >> model: anObject [
	^ self new
		model: anObject;
		yourself
]

{ #category : #accessing }
DBEInvalidModel >> model [
	^ model
]

{ #category : #accessing }
DBEInvalidModel >> model: anObject [
	model := anObject
]
