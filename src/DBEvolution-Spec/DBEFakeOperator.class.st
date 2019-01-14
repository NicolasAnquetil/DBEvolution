Class {
	#name : #DBEFakeOperator,
	#superclass : #DBEOperator,
	#instVars : [
		'icon',
		'name'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #accessing }
DBEFakeOperator class >> start [
	^ self new
		name: 'Start';
		icon: (Smalltalk ui icons iconNamed: #glamorousGo);
		yourself
]

{ #category : #accessing }
DBEFakeOperator class >> stop [
	^ self new
		name: 'Stop';
		icon: (Smalltalk ui icons iconNamed: #protocolPrivate);
		yourself
]

{ #category : #converting }
DBEFakeOperator >> asStringForSpec [
	^ String streamContents: [ :s |
		s
			nextPutAll: self nameForSpec ]
]

{ #category : #testing }
DBEFakeOperator >> canBeAppliedOnData [
	^ false
]

{ #category : #testing }
DBEFakeOperator >> canBeAppliedOnModel [
	^ false
]

{ #category : #accessing }
DBEFakeOperator >> icon [
	^ icon
]

{ #category : #accessing }
DBEFakeOperator >> icon: anObject [
	icon := anObject
]

{ #category : #testing }
DBEFakeOperator >> isResolved [
	^ false
]

{ #category : #accessing }
DBEFakeOperator >> name [
	^ name
]

{ #category : #accessing }
DBEFakeOperator >> name: anObject [
	name := anObject
]

{ #category : #accessing }
DBEFakeOperator >> nameForSpec [
	^ self name
]

{ #category : #accessing }
DBEFakeOperator >> recommandations [
	^ #()
]

{ #category : #private }
DBEFakeOperator >> recommandationsGenerator [
	"Returns an instance of DBERecommandationsGenerator which models the impact of the operator and the recommandations allowing to try to reconciliate the database with the change provided by the operator."
	^ self shouldNotImplement
]

{ #category : #'*DBEvolution-Spec' }
DBEFakeOperator >> resolveFromSequenceOperatorPresenter [
	self shouldNotImplement
]

{ #category : #'as yet unclassified' }
DBEFakeOperator >> statusIcon [
	"Icon displayed in the UI to show the status of the operator application."
	^ self icon
]

{ #category : #private }
DBEFakeOperator >> uncheckedApply [
	"Does nothing on purpose."
]
