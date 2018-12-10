Class {
	#name : #DBERemoveColumn,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'targetTable',
		'columnName'
	],
	#category : #'DBEvolution-Operators'
}

{ #category : #'instance creation' }
DBERemoveColumn class >> table: table column: column [ 
	^ self new
		targetTable: table;
		columnName: column;
		yourself
]

{ #category : #testing }
DBERemoveColumn >> canBeAppliedOnData [
	"Removing a column is always possible, there is no data configuration that avoid it."
	^ true
]

{ #category : #testing }
DBERemoveColumn >> canBeAppliedOnModel [
	"The only two cases when a column can not be removed from a table are:
		- when the table does not exists; or
		- when the column does not exists in the table
	"
	^ (self model hasTableNamed: self targetTable)
		and: [ self model table: self targetTable hasColumnNamed: self columnName ]
]

{ #category : #accessing }
DBERemoveColumn >> columnName [
	^ columnName
]

{ #category : #accessing }
DBERemoveColumn >> columnName: anObject [
	columnName := anObject
]

{ #category : #accessing }
DBERemoveColumn >> queriesTemplate [
	^ 'ALTER TABLE "{targetTable}" DROP COLUMN "{columnName}";'
]

{ #category : #accessing }
DBERemoveColumn >> targetTable [
	^ targetTable
]

{ #category : #accessing }
DBERemoveColumn >> targetTable: anObject [
	targetTable := anObject
]

{ #category : #accessing }
DBERemoveColumn >> templateArgumentsDictionary [
	^ { 
		#columnName -> self columnName.
		#targetTable -> self targetTable
	} asDictionary
]
