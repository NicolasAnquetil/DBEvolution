Class {
	#name : #DBEBasicRemoveStoredProcedure,
	#superclass : #DBEStoredProcedureOperator,
	#category : #'DBEvolution-Operators-StoredProcedure'
}

{ #category : #accessing }
DBEBasicRemoveStoredProcedure >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'DROP FUNCTION "{storedProcedureName}"({args}) RESTRICT;'
]

{ #category : #accessing }
DBEBasicRemoveStoredProcedure >> templateArgumentsDictionary [
	"Returns a Dictionary containing the values to be substituted in the template."
	^ { 
		'storedProcedureName' -> self storedProcedure name.
		'args' -> ((self storedProcedure parameters collect: [ :p | p name , ' ' , p type name ]) joinUsing: ', ')
	 } asDictionary
]
