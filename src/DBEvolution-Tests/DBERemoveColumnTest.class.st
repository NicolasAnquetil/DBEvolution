Class {
	#name : #DBERemoveColumnTest,
	#superclass : #DBEOperatorTest,
	#category : #'DBEvolution-Tests'
}

{ #category : #accessing }
DBERemoveColumnTest >> operatorInstance [
	| tableEntityMock columnEntityMock |
	tableEntityMock := Mock new.
	tableEntityMock stub
		name willReturn: 'person'.
	columnEntityMock := Mock new.
	columnEntityMock stub
		name willReturn: 'name'.
	columnEntityMock stub
		table willReturn: tableEntityMock.
	^ DBERemoveColumn column: columnEntityMock
]

{ #category : #tests }
DBERemoveColumnTest >> testCanBeAppliedOnData [
	self assert: operator canBeAppliedOnData
]

{ #category : #tests }
DBERemoveColumnTest >> testCanBeAppliedOnModel [
	self assert: operator canBeAppliedOnModel
]

{ #category : #tests }
DBERemoveColumnTest >> testGenerateQueries [
	self assert: operator generateQueries equals: 'ALTER TABLE "person" DROP COLUMN "name";'
]

{ #category : #tests }
DBERemoveColumnTest >> testTemplateArgumentsDictionary [
	self
		assert: operator templateArgumentsDictionary
		equals: { 
			#columnName -> 'name'.
			#tableName -> 'person'
		} asDictionary
]
