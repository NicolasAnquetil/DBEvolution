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

{ #category : #testing }
DBEHumanIntervention >> isResolved [
	"Answers true if the operators is ready to be applied.
	 How it is computed depends on the operator.
	 For composite operators it will be true if #isResolved is true for all children.
	 For atomic operators it will be true if a recommandation has been chosed by the developper for each impacted entity."
	self flag: #TODO.
	^ false
]
