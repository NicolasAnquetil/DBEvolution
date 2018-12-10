"
I encapsulate a model of the database to work with.

My purpose is to provide a set of predicates that operators can use to interact with the model of the database.
"
Class {
	#name : #DBEModel,
	#superclass : #Object,
	#category : #'DBEvolution-Core'
}

{ #category : #predicates }
DBEModel >> column: columnName existsInTable: tableName [
	"Returns true if #tableName contains a column named #columnName."
	^ self subclassResponsibility
]

{ #category : #predicates }
DBEModel >> hasTableNamed: tableName [
	"Returns true if #tableName is an existing table in the database."
	^ self subclassResponsibility
]

{ #category : #predicates }
DBEModel >> hasTypeNamed: aTypeName [
	"Returns true if #aTypeName is an existing type in the DB."
	^ self subclassResponsibility
]

{ #category : #predicates }
DBEModel >> table: tableName hasColumnNamed: columnName [
	"Predicates allowing to query the model in order to determinate if a table named #tableName has a column named #columnName."
	^ self subclassResponsibility
]

{ #category : #predicates }
DBEModel >> tableExists: tableName [
	"Returns true if #tableName exists in the model."
	^ self subclassResponsibility
]
