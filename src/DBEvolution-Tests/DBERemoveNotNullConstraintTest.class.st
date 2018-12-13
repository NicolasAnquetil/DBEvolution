Class {
	#name : #DBERemoveNotNullConstraintTest,
	#superclass : #DBEOperatorTest,
	#instVars : [
		'columnEntityMock'
	],
	#category : #'DBEvolution-Tests'
}

{ #category : #accessing }
DBERemoveNotNullConstraintTest >> operatorInstance [
	| tableEntityMock |
	tableEntityMock := Mock new.
	tableEntityMock stub
		name willReturn: 'person'.
	columnEntityMock := Mock new.
	columnEntityMock stub
		name willReturn: 'name'.
	columnEntityMock stub
		table willReturn: tableEntityMock.
	^ DBERemoveNotNullConstraint column: columnEntityMock
]

{ #category : #tests }
DBERemoveNotNullConstraintTest >> testCanBeAppliedOnData [
	self assert: operator canBeAppliedOnData
]

{ #category : #tests }
DBERemoveNotNullConstraintTest >> testCanBeAppliedOnModel [
	self assert: operator canBeAppliedOnModel
]

{ #category : #tests }
DBERemoveNotNullConstraintTest >> testGenerateQueries [
	self assert: operator generateQueries equals: 'ALTER TABLE "person" ALTER COLUMN "name" DROP NOT NULL;'
]

{ #category : #tests }
DBERemoveNotNullConstraintTest >> testTemplateArgumentsDictionary [
	self
		assert: operator templateArgumentsDictionary
		equals: { 
			#tableName -> 'person'.
			#columnName -> 'name'
		} asDictionary
]
