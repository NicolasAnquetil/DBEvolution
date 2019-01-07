Class {
	#name : #DBESequenceCompositeOperator,
	#superclass : #DBECompositeOperator,
	#instVars : [
		'sequenceOfOperators'
	],
	#category : #'DBEvolution-Core'
}

{ #category : #accessing }
DBESequenceCompositeOperator >> sequenceOfOperators [
	^ sequenceOfOperators
]

{ #category : #accessing }
DBESequenceCompositeOperator >> sequenceOfOperators: anObject [
	sequenceOfOperators := anObject
]
