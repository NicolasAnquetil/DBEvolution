Class {
	#name : #DEChangeTarget,
	#superclass : #DEReferenceOperator,
	#instVars : [
		'newTarget'
	],
	#category : #DBEvolution2
}

{ #category : #accessing }
DEChangeTarget >> newTarget [
	^ newTarget
]

{ #category : #accessing }
DEChangeTarget >> newTarget: anObject [
	newTarget := anObject
]
