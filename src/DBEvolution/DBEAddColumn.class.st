"
Adds a column in a table.
"
Class {
	#name : #DBEAddColumn,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'targetTable',
		'columnName',
		'columnType'
	],
	#category : #'DBEvolution-Operators'
}

{ #category : #'instance creation' }
DBEAddColumn class >> table: table column: column type: type [
	^ self new
		targetTable: table;
		columnName: column;
		columnType: type;
		yourself
]

{ #category : #testing }
DBEAddColumn >> canBeAppliedOnData [
	"Adding a column is always possible, there is no data configuration that avoid it."
	^ true
]

{ #category : #testing }
DBEAddColumn >> canBeAppliedOnModel [
	"The only two cases when a column can not be added into a table are:
		- when the table already has a column with the same name; or
		- when the type of the new column does not exist in the database
	"
	^ (self model table: self targetTable hasColumnNamed: self columnName) not
		and: [ self model hasTypeNamed: self columnType ]
]

{ #category : #accessing }
DBEAddColumn >> columnName [
	^ columnName
]

{ #category : #accessing }
DBEAddColumn >> columnName: anObject [
	columnName := anObject
]

{ #category : #accessing }
DBEAddColumn >> columnType [
	^ columnType
]

{ #category : #accessing }
DBEAddColumn >> columnType: anObject [
	columnType := anObject
]

{ #category : #accessing }
DBEAddColumn >> queriesTemplate [
	^ 'ALTER TABLE "{targetTable}" ADD COLUMN "{columnName}" "{columnType}";'
]

{ #category : #accessing }
DBEAddColumn >> targetTable [
	^ targetTable
]

{ #category : #accessing }
DBEAddColumn >> targetTable: anObject [
	targetTable := anObject
]

{ #category : #accessing }
DBEAddColumn >> templateArgumentsDictionary [
	^ { 
		#columnName -> self columnName.
		#columnType -> self columnType.
		#targetTable -> self targetTable
	} asDictionary
]
