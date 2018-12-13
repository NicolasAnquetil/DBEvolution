Class {
	#name : #DBEAddNotNullConstraint,
	#superclass : #DBEAddConstraint,
	#instVars : [
		'column'
	],
	#category : #'DBEvolution-Operators-Constraints'
}

{ #category : #accessing }
DBEAddNotNullConstraint >> column [
	^ column
]

{ #category : #accessing }
DBEAddNotNullConstraint >> column: anObject [
	column := anObject
]
