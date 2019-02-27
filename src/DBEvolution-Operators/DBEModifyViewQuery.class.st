Class {
	#name : #DBEModifyViewQuery,
	#superclass : #DBEViewOperator,
	#traits : 'DBETTerminalOperator',
	#classTraits : 'DBETTerminalOperator classTrait',
	#instVars : [
		'newQueryString'
	],
	#category : #'DBEvolution-Operators-View'
}

{ #category : #accessing }
DBEModifyViewQuery >> newQueryString [
	^ newQueryString
]

{ #category : #accessing }
DBEModifyViewQuery >> newQueryString: anObject [
	newQueryString := anObject
]

{ #category : #accessing }
DBEModifyViewQuery >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'CREATE OR REPLACE VIEW "{viewName}" AS {query};'
]

{ #category : #accessing }
DBEModifyViewQuery >> templateArgumentsDictionary [
	"Returns a Dictionary containing the values to be substituted in the template."
	^ super templateArgumentsDictionary
		at: 'query' put: self newQueryString;
		yourself
]
