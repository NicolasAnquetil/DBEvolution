Class {
	#name : #DBEAddForeignKeyConstraint,
	#superclass : #DBEAddConstraint,
	#instVars : [
		'sourceColumn',
		'targetColumn'
	],
	#category : #'DBEvolution-Operators-Constraints'
}

{ #category : #accessing }
DBEAddForeignKeyConstraint >> sourceColumn [
	^ sourceColumn
]

{ #category : #accessing }
DBEAddForeignKeyConstraint >> sourceColumn: anObject [
	sourceColumn := anObject
]

{ #category : #accessing }
DBEAddForeignKeyConstraint >> targetColumn [
	^ targetColumn
]

{ #category : #accessing }
DBEAddForeignKeyConstraint >> targetColumn: anObject [
	targetColumn := anObject
]
