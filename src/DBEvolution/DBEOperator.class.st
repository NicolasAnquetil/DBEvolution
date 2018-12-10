Class {
	#name : #DBEOperator,
	#superclass : #Object,
	#instVars : [
		'model',
		'database'
	],
	#category : #'DBEvolution-Core'
}

{ #category : #accessing }
DBEOperator >> apply [
	self canBeAppliedOnModel
		ifFalse: [ DBEInvalidModel model: self model ].
		
	self canBeAppliedOnData
		ifFalse: [ DBEInvalidData database: self database ].
		
	self uncheckedApply
]

{ #category : #testing }
DBEOperator >> canBeAppliedOnData [
	"Concrete subclasses should override this method in order that it returns true if the operator can be applied on the data stored in the database."
	^ self subclassResponsibility
]

{ #category : #testing }
DBEOperator >> canBeAppliedOnModel [
	"Concrete subclasses should override this method in order that it returns true if the operator can be applied on the model of the database."
	^ self subclassResponsibility
]

{ #category : #accessing }
DBEOperator >> database [
	^ database
]

{ #category : #accessing }
DBEOperator >> database: anObject [
	database := anObject
]

{ #category : #accessing }
DBEOperator >> model [
	^ model
]

{ #category : #accessing }
DBEOperator >> model: anObject [
	model := anObject
]

{ #category : #private }
DBEOperator >> uncheckedApply [
	"Apply the operator without checking the model nor the data.
	 This method should not be used by clients.
	"
	self subclassResponsibility
]
