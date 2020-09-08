Class {
	#name : #DBEModifyForeignKeyConstraint,
	#superclass : #DBEAtomicOperator,
	#traits : 'DBETTerminalOperator',
	#classTraits : 'DBETTerminalOperator classTrait',
	#instVars : [
		'targetColumn',
		'sourceColumn'
	],
	#category : #'DBEvolution-Operators-Constraints'
}

{ #category : #accessing }
DBEModifyForeignKeyConstraint >> sourceColumn [
	^ sourceColumn
]

{ #category : #accessing }
DBEModifyForeignKeyConstraint >> sourceColumn: anObject [
	sourceColumn := anObject
]

{ #category : #accessing }
DBEModifyForeignKeyConstraint >> targetColumn [
	^ targetColumn
]

{ #category : #accessing }
DBEModifyForeignKeyConstraint >> targetColumn: anObject [
	targetColumn := anObject
]
