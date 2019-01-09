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
	#category : #'DBEvolution-Operators-Column'
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
	^ (self targetTable hasColumnNamed: self columnName) not
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

{ #category : #private }
DBEAddColumn >> impactAndRecommandations [
	"There is no impact here. So we define a filter that accept any entity of the model and provide no recommandation."
	^ DBERecommandationsGenerator filters: {}
]

{ #category : #accessing }
DBEAddColumn >> queriesTemplate [
	^ 'ALTER TABLE "{targetTableName}" ADD COLUMN "{columnName}" "{columnTypeName}";'
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
		#columnTypeName -> self columnType name.
		#targetTableName -> self targetTable name
	} asDictionary
]
