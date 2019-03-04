Class {
	#name : #DBEViewOperator,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'view'
	],
	#category : #'DBEvolution-Operators-View'
}

{ #category : #accessing }
DBEViewOperator >> entity [
	^ self view
]

{ #category : #accessing }
DBEViewOperator >> templateArgumentsDictionary [
	"Returns a Dictionary containing the values to be substituted in the template."
	^ { 
		'viewName' -> self view name
	 } asDictionary
]

{ #category : #accessing }
DBEViewOperator >> view [
	^ view
]

{ #category : #accessing }
DBEViewOperator >> view: anObject [
	view := anObject
]
