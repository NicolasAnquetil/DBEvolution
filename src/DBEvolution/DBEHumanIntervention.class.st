"
This is a special operator involving human's decision.
"
Class {
	#name : #DBEHumanIntervention,
	#superclass : #DBEOperator,
	#instVars : [
		'entity',
		'newSourceCode'
	],
	#category : #'DBEvolution-Core'
}

{ #category : #'instance creation' }
DBEHumanIntervention class >> entity: anEntity [
	^ self new
		entity: anEntity;
		yourself
]

{ #category : #testing }
DBEHumanIntervention >> canBeAppliedOnData [
	"Always true, we consider the DBA knows what he does here."
	^ true
]

{ #category : #testing }
DBEHumanIntervention >> canBeAppliedOnModel [
	"Always true, we consider the DBA knows what he does here."
	^ true
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
	^ self newSourceCode isNotNil
]

{ #category : #accessing }
DBEHumanIntervention >> newSourceCode [
	^ newSourceCode
]

{ #category : #accessing }
DBEHumanIntervention >> newSourceCode: anObject [
	newSourceCode := anObject
]

{ #category : #accessing }
DBEHumanIntervention >> recommandations [
	"No recommandations here, it just needs to be fixed by the DBA."
	^ #()
]

{ #category : #private }
DBEHumanIntervention >> recommandationsGenerator [
	"Makes no sense here."
	self shouldNotImplement
]
