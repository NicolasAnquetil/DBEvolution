Class {
	#name : #DBEAddView,
	#superclass : #DBEAtomicOperator,
	#traits : 'DBETTerminalOperator',
	#classTraits : 'DBETTerminalOperator classTrait',
	#instVars : [
		'viewName',
		'query'
	],
	#category : #'DBEvolution-Operators-View'
}

{ #category : #'instance creation' }
DBEAddView class >> named: aString query: queryString [
	^ self new
		viewName: aString;
		query: queryString;
		yourself
]

{ #category : #accessing }
DBEAddView >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'CREATE VIEW "{viewName}" AS {query};'
]

{ #category : #accessing }
DBEAddView >> query [
	^ query
]

{ #category : #accessing }
DBEAddView >> query: anObject [
	query := anObject
]

{ #category : #accessing }
DBEAddView >> templateArgumentsDictionary [
	"Returns a Dictionary containing the values to be substituted in the template."
	^ { 
		'viewName' -> self viewName.
		'query' -> self query
	 } asDictionary
]

{ #category : #accessing }
DBEAddView >> viewName [
	^ viewName
]

{ #category : #accessing }
DBEAddView >> viewName: anObject [
	viewName := anObject
]
