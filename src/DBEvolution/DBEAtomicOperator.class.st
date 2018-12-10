Class {
	#name : #DBEAtomicOperator,
	#superclass : #DBEOperator,
	#category : #'DBEvolution-Core'
}

{ #category : #private }
DBEAtomicOperator >> executeQueries: aString [
	"Execute the queries located in aString."
	self shouldBeImplemented
]

{ #category : #private }
DBEAtomicOperator >> generateQueries [
	^ self queriesTemplate format: self templateArgumentsDictionary
]

{ #category : #accessing }
DBEAtomicOperator >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ self subclassResponsibility
]

{ #category : #accessing }
DBEAtomicOperator >> templateArgumentsDictionary [
	"Returns a Dictionary containing the values to be substituted in the template."
	^ self subclassResponsibility
]

{ #category : #private }
DBEAtomicOperator >> uncheckedApply [
	"Instantiate the query(ies) template using the operator's configuration and execute these queries."

	self executeQueries: self generateQueries
]
