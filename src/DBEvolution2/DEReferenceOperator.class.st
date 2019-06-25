Class {
	#name : #DEReferenceOperator,
	#superclass : #DEOperator,
	#instVars : [
		'reference'
	],
	#category : #DBEvolution2
}

{ #category : #accessing }
DEReferenceOperator >> reference [
	^ reference
]

{ #category : #accessing }
DEReferenceOperator >> reference: anObject [
	reference := anObject
]
