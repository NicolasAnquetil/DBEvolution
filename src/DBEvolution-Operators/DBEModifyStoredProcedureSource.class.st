Class {
	#name : #DBEModifyStoredProcedureSource,
	#superclass : #DBEStoredProcedureOperator,
	#traits : 'DBETTerminalOperator',
	#classTraits : 'DBETTerminalOperator classTrait',
	#instVars : [
		'newSourceCode'
	],
	#category : #'DBEvolution-Operators-StoredProcedure'
}

{ #category : #'as yet unclassified' }
DBEModifyStoredProcedureSource >> beAggregatedIn: aDBECreateStoredProcedure [
	aDBECreateStoredProcedure bodySourceCode: self newSourceCode
]

{ #category : #testing }
DBEModifyStoredProcedureSource >> concernsStoredProcedure [
	^ true
]

{ #category : #accessing }
DBEModifyStoredProcedureSource >> newSourceCode [
	^ newSourceCode
]

{ #category : #accessing }
DBEModifyStoredProcedureSource >> newSourceCode: anObject [
	newSourceCode := anObject
]

{ #category : #accessing }
DBEModifyStoredProcedureSource >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'CREATE OR REPLACE FUNCTION "{storedProcedureName}"({args}) RETURNS {returnType} AS $${sourceCode}$$ LANGUAGE plpgsql;'
]

{ #category : #accessing }
DBEModifyStoredProcedureSource >> templateArgumentsDictionary [
	"Returns a Dictionary containing the values to be substituted in the template."
	^ { 
		'storedProcedureName' -> self storedProcedure name.
		'args' -> ((self storedProcedure parameters collect: [ :p | p name , ' ' , p type name ]) joinUsing: ', ').
		'sourceCode' -> self newSourceCode.
		'returnType' -> self storedProcedure returnType name
	 } asDictionary
]
