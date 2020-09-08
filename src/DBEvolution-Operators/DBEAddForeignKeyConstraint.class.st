Class {
	#name : #DBEAddForeignKeyConstraint,
	#superclass : #DBEAddConstraint,
	#instVars : [
		'sourceColumn',
		'targetColumn'
	],
	#category : #'DBEvolution-Operators-Constraints'
}

{ #category : #testing }
DBEAddForeignKeyConstraint >> canBeAppliedOnData [
	"Concrete subclasses should override this method in order that it returns true if the operator can be applied on the data stored in the database."
	^ false
]

{ #category : #testing }
DBEAddForeignKeyConstraint >> canBeAppliedOnModel [
	"Concrete subclasses should override this method in order that it returns true if the operator can be applied on the model of the database."
	^ true
]

{ #category : #accessing }
DBEAddForeignKeyConstraint >> constraintName [
	^'fk_' , self targetTable name , '_' , self targetColumn name
]

{ #category : #accessing }
DBEAddForeignKeyConstraint >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'ALTER TABLE "{sourceTableName}"
	ADD CONSTRAINT "{constraintName}"
	FOREIGN KEY ("{sourceColumnName}")
	REFERENCES "{tableName}" ("{targetColumnName}");'
]

{ #category : #private }
DBEAddForeignKeyConstraint >> recommandationsGenerator [

	^ DBERecommandationsGenerator
		filters:
			{ }
]

{ #category : #accessing }
DBEAddForeignKeyConstraint >> sourceColumn [
	^ sourceColumn
]

{ #category : #accessing }
DBEAddForeignKeyConstraint >> sourceColumn: anObject [
	sourceColumn := anObject
]

{ #category : #accessing }
DBEAddForeignKeyConstraint >> sourceTableName [
	^ self sourceColumn columnsContainer name
]

{ #category : #accessing }
DBEAddForeignKeyConstraint >> targetColumn [
	^ targetColumn
]

{ #category : #accessing }
DBEAddForeignKeyConstraint >> targetColumn: anObject [
	targetColumn := anObject
]

{ #category : #accessing }
DBEAddForeignKeyConstraint >> targetTable [
	^self targetColumn columnsContainer
]

{ #category : #accessing }
DBEAddForeignKeyConstraint >> templateArgumentsDictionary [
	^ super templateArgumentsDictionary
		at: #sourceTableName put: self sourceTableName ;
		at: #sourceColumnName put: self sourceColumn name ;
		at: #targetColumnName put: self targetColumn name ;
		yourself
]
