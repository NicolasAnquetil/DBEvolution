"
This is a special operator involving human's decision.
"
Class {
	#name : #DBEHumanIntervention,
	#superclass : #DBEOperator,
	#instVars : [
		'entity'
	],
	#category : #'DBEvolution-Core'
}

{ #category : #'instance creation' }
DBEHumanIntervention class >> entity: anEntity [
	^ self new
		entity: anEntity;
		yourself
]

{ #category : #accessing }
DBEHumanIntervention >> entity [
	^ entity
]

{ #category : #accessing }
DBEHumanIntervention >> entity: anObject [
	entity := anObject
]
