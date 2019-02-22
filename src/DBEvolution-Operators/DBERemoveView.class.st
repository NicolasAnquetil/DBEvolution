Class {
	#name : #DBERemoveView,
	#superclass : #DBEViewOperator,
	#traits : 'DBETTerminalOperator',
	#classTraits : 'DBETTerminalOperator classTrait',
	#category : #'DBEvolution-Operators-View'
}

{ #category : #'instance creation' }
DBERemoveView class >> view: aView [
	^ self new
		view: aView;
		yourself
]

{ #category : #printing }
DBERemoveView >> printArgumentsForSpecOn: aStream [
	aStream
		nextPutAll: self view dbeNameForUI
]

{ #category : #accessing }
DBERemoveView >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'DROP VIEW {viewName} RESTRICT;'
]
