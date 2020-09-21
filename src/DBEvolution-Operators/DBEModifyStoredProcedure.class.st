Class {
	#name : #DBEModifyStoredProcedure,
	#superclass : #DBEStoredProcedureOperator,
	#instVars : [
		'bodySourceCode',
		'parameters',
		'parametersTypes',
		'returnType',
		'storedProcedureName'
	],
	#category : #'DBEvolution-Operators-StoredProcedure'
}

{ #category : #converting }
DBEModifyStoredProcedure >> asCreate [
	^ DBECreateStoredProcedure new
		storedProcedureName: self storedProcedureName;
		parameters: self parameters;
		parametersTypes: self parametersTypes;
		returnType: self returnType;
		bodySourceCode: self bodySourceCode;
		yourself
]

{ #category : #converting }
DBEModifyStoredProcedure >> asRemove [
	^ DBEBasicRemoveStoredProcedure storedProcedure: self storedProcedure
]

{ #category : #accessing }
DBEModifyStoredProcedure >> bodySourceCode [
	^ bodySourceCode ifNil: [ bodySourceCode := self storedProcedure source ]
]

{ #category : #accessing }
DBEModifyStoredProcedure >> bodySourceCode: anObject [
	bodySourceCode := anObject
]

{ #category : #testing }
DBEModifyStoredProcedure >> needRemoveRecreate [
	^ true
]

{ #category : #accessing }
DBEModifyStoredProcedure >> parameters [
	^ parameters ifNil: [ parameters := self storedProcedure parameters collect: #name ]
]

{ #category : #accessing }
DBEModifyStoredProcedure >> parameters: anObject [
	parameters := anObject
]

{ #category : #accessing }
DBEModifyStoredProcedure >> parametersTypes [
	^ parametersTypes ifNil: [ parametersTypes := self storedProcedure parameters collect: [ :p | p type name ] ]
]

{ #category : #accessing }
DBEModifyStoredProcedure >> parametersTypes: anObject [
	parametersTypes := anObject
]

{ #category : #accessing }
DBEModifyStoredProcedure >> returnType [
	^ returnType ifNil: [ returnType := self storedProcedure returnType name ]
]

{ #category : #accessing }
DBEModifyStoredProcedure >> returnType: anObject [
	returnType := anObject
]

{ #category : #accessing }
DBEModifyStoredProcedure >> storedProcedureName [
	^ storedProcedureName ifNil: [ storedProcedureName := self storedProcedure name ]
]

{ #category : #accessing }
DBEModifyStoredProcedure >> storedProcedureName: anObject [
	storedProcedureName := anObject
]
