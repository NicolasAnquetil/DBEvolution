Class {
	#name : #DBEExecutionOrderOfOperators,
	#superclass : #DBEVisitor,
	#instVars : [
		'operators'
	],
	#category : #'DBEvolution-Visitors'
}

{ #category : #initialization }
DBEExecutionOrderOfOperators >> initialize [
	super initialize.
	self operators: OrderedCollection new
]

{ #category : #accessing }
DBEExecutionOrderOfOperators >> operators [
	^ operators
]

{ #category : #accessing }
DBEExecutionOrderOfOperators >> operators: anObject [
	operators := anObject
]

{ #category : #visiting }
DBEExecutionOrderOfOperators >> visitDBEOperator: aDBEOperator [
	aDBEOperator recommandations
		select: #isOperatorChosen
		thenDo: [ :recommandation | recommandation acceptVisitor: self ].
		
	self operators add: aDBEOperator.
	^ self operators
]

{ #category : #visiting }
DBEExecutionOrderOfOperators >> visitDBERecommandation: aDBERecommandation [
	aDBERecommandation operatorChosen acceptVisitor: self
]
