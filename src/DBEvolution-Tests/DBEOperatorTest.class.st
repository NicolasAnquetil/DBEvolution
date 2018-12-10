Class {
	#name : #DBEOperatorTest,
	#superclass : #TestCase,
	#instVars : [
		'operator',
		'modelMock',
		'databaseMock'
	],
	#category : #'DBEvolution-Tests'
}

{ #category : #testing }
DBEOperatorTest class >> isAbtract [
	^ self name = #DBEOperatorTest
]

{ #category : #accessing }
DBEOperatorTest >> operatorClass [
	"Returns the class of the operator to be tested."
	^ self subclassResponsibility
]

{ #category : #running }
DBEOperatorTest >> setUp [
	operator := self operatorClass table: 'person' column: 'name' type: 'text'.
	operator
		model: DBEDatabase new;
		database: DBEDatabase new.
	modelMock := operator model stub.
	databaseMock := operator database stub.
]