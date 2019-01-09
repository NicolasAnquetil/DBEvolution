"
I report the fact that no filter was able to match an entity during the recommandations generation.
"
Class {
	#name : #DBENoFilterMatchesEntityError,
	#superclass : #DBEError,
	#instVars : [
		'entity'
	],
	#category : #'DBEvolution-Errors'
}

{ #category : #signalling }
DBENoFilterMatchesEntityError class >> signalEntity: entity [
	self new
		entity: entity;
		signal
]

{ #category : #accessing }
DBENoFilterMatchesEntityError >> entity [
	^ entity
]

{ #category : #accessing }
DBENoFilterMatchesEntityError >> entity: anObject [
	entity := anObject
]

{ #category : #accessing }
DBENoFilterMatchesEntityError >> messageText [
	^ String streamContents: [ :s |
		s 
			nextPutAll: 'No filter was found for '.
		self entity printOn: s.
		s
			nextPutAll: ' entity.' ]
]
