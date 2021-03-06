Class {
	#name : #DBEOperator,
	#superclass : #Object,
	#instVars : [
		'model',
		'database',
		'developerComment'
	],
	#category : #'DBEvolution-Core'
}

{ #category : #visiting }
DBEOperator >> acceptVisitor: aDBEVisitor [
	^ aDBEVisitor visitDBEOperator: self
]

{ #category : #accessing }
DBEOperator >> allOperators [
	"Recursively visit the operators tree and return a flattened array containing all the operators."

	^ self acceptVisitor: DBEExecutionOrderOfOperators new
]

{ #category : #'public - application' }
DBEOperator >> apply [
	self canBeAppliedOnModel
		ifFalse: [ DBEInvalidModel model: self model ].
		
	self canBeAppliedOnData
		ifFalse: [ DBEInvalidData database: self database ].
		
	self uncheckedApply
]

{ #category : #converting }
DBEOperator >> asCreate [
	^nil
]

{ #category : #converting }
DBEOperator >> asRemove [
	^nil
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

{ #category : #testing }
DBEOperator >> concernsStoredProcedure [
	^ false
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
DBEOperator >> developerComment [
	^ developerComment ifNil: [ ^ '' ]
]

{ #category : #accessing }
DBEOperator >> developerComment: anObject [
	developerComment := anObject
]

{ #category : #accessing }
DBEOperator >> documentation [
	"Documentation for the user of the operator.
	 This method should return a small text explaining the purpose of the operator and how it should be used."
	^ 'No documentation available.'
]

{ #category : #accessing }
DBEOperator >> inducedOperators [
	^ self recommandations
		select: #isOperatorChosen
		thenCollect: [ :recommandation | recommandation operatorChosen ]
]

{ #category : #testing }
DBEOperator >> isRenameReference [
	^ false
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

{ #category : #testing }
DBEOperator >> needRemoveRecreate [
	^ false
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
