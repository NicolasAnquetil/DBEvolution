Class {
	#name : #DBEInvalidData,
	#superclass : #DBEError,
	#instVars : [
		'database'
	],
	#category : #'DBEvolution-Errors'
}

{ #category : #'instance creation' }
DBEInvalidData class >> database: anObject [
	^ self new
		database: anObject;
		yourself
]

{ #category : #accessing }
DBEInvalidData >> database [
	^ database
]

{ #category : #accessing }
DBEInvalidData >> database: anObject [
	database := anObject
]
