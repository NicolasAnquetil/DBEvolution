Class {
	#name : #DBECreateStoredProcedure,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'bodySourceCode',
		'parameters',
		'parametersTypes',
		'returnType',
		'storedProcedureName'
	],
	#category : #'DBEvolution-Operators-StoredProcedure'
}

{ #category : #accessing }
DBECreateStoredProcedure >> bodySourceCode [
	^ bodySourceCode
]

{ #category : #accessing }
DBECreateStoredProcedure >> bodySourceCode: anObject [
	bodySourceCode := anObject
]

{ #category : #accessing }
DBECreateStoredProcedure >> parameters [
	^ parameters
]

{ #category : #accessing }
DBECreateStoredProcedure >> parameters: anObject [
	parameters := anObject
]

{ #category : #accessing }
DBECreateStoredProcedure >> parametersTypes [
	^ parametersTypes
]

{ #category : #accessing }
DBECreateStoredProcedure >> parametersTypes: anObject [
	parametersTypes := anObject
]

{ #category : #accessing }
DBECreateStoredProcedure >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'CREATE FUNCTION "{storedProcedureName}"({args}) RETURNS {returnType} AS $${sourceCode}$$ LANGUAGE plpgsql;'
]

{ #category : #accessing }
DBECreateStoredProcedure >> returnType [
	^ returnType
]

{ #category : #accessing }
DBECreateStoredProcedure >> returnType: anObject [
	returnType := anObject
]

{ #category : #accessing }
DBECreateStoredProcedure >> storedProcedureName [
	^ storedProcedureName
]

{ #category : #accessing }
DBECreateStoredProcedure >> storedProcedureName: anObject [
	storedProcedureName := anObject
]

{ #category : #accessing }
DBECreateStoredProcedure >> templateArgumentsDictionary [
	"Returns a Dictionary containing the values to be substituted in the template."
	^ { 
		'storedProcedureName' -> self storedProcedureName.
		'args' -> ((self parameters with: self parametersTypes collect: [ :name :typeName | name , ' ' , typeName ]) joinUsing: ', ').
		'sourceCode' -> self bodySourceCode.
		'returnType' -> self returnType
	 } asDictionary
]
