"
A DBERenameColumnTest is a test class for testing the behavior of DBERenameColumn
"
Class {
	#name : #DBERenameColumnTest,
	#superclass : #DBEOperatorTest,
	#instVars : [
		'columnEntityMock'
	],
	#category : #'DBEvolution-Tests'
}

{ #category : #accessing }
DBERenameColumnTest >> operatorInstance [
	"Returns the class of the operator to be tested."
	| tableEntityMock |
	tableEntityMock := Mock new.
	tableEntityMock stub
		name willReturn: 'person'.
	columnEntityMock := Mock new.
	columnEntityMock stub
		name willReturn: 'name'.
	columnEntityMock stub
		table willReturn: tableEntityMock.
	^ DBERenameColumn new
		targetColumn: columnEntityMock;
		newColumnName: 'surname';
		yourself
]

{ #category : #tests }
DBERenameColumnTest >> testGenerateQueries [
	self assert: operator generateQueries equals: 'ALTER TABLE "person" RENAME COLUMN "name" TO "surname";'
]

{ #category : #tests }
DBERenameColumnTest >> testTemplateArgumentsDictionary [
	self
		assert: operator templateArgumentsDictionary
		equals: { 
			#columnName -> 'name'.
			#tableName -> 'person'.
			#newColumnName -> 'surname'
		} asDictionary
]
