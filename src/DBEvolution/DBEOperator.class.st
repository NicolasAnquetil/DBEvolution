Class {
	#name : #DBEOperator,
	#superclass : #Object,
	#instVars : [
		'model',
		'database'
	],
	#category : #'DBEvolution-Core'
}

{ #category : #'public - application' }
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

{ #category : #testing }
DBEOperator >> isResolved [
	"Answers true if the operators is ready to be applied.
	 How it is computed depends on the operator.
	 For composite operators it will be true if #isResolved is true for all children.
	 For atomic operators it will be true if a recommandation has been chosed by the developper for each impacted entity."
	^ self subclassResponsibility
]

{ #category : #accessing }
DBEOperator >> model [
	^ model
]

{ #category : #accessing }
DBEOperator >> model: anObject [
	model := anObject
]

{ #category : #accessing }
DBEOperator >> recommandations [
	"Returns the recommandations to apply the operator or an empty collection if not applicable."
	^ self subclassResponsibility
]

{ #category : #private }
DBEOperator >> recommandationsGenerator [
	"Returns an instance of DBERecommandationsGenerator which models the impact of the operator and the recommandations allowing to try to reconciliate the database with the change provided by the operator."
	^ self subclassResponsibility
]

{ #category : #private }
DBEOperator >> uncheckedApply [
	"Apply the operator without checking the model nor the data.
	 This method should not be used by clients.
	"
	self subclassResponsibility
]
