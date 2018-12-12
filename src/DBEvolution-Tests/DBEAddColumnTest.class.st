Class {
	#name : #DBEAddColumnTest,
	#superclass : #DBEOperatorTest,
	#category : #'DBEvolution-Tests'
}

{ #category : #accessing }
DBEAddColumnTest >> operatorInstance [
	| tableEntityMock typeEntityMock |
	tableEntityMock := Mock new.
	tableEntityMock stub
		name willReturn: 'person'.
	typeEntityMock := Mock new.
	typeEntityMock stub
		name willReturn: 'text'.
		
	^ DBEAddColumn table: tableEntityMock column: 'name' type: typeEntityMock
]

{ #category : #tests }
DBEAddColumnTest >> testCanBeAppliedOnData [
	self assert: operator canBeAppliedOnData
]

{ #category : #tests }
DBEAddColumnTest >> testCanBeAppliedOnModel [
	(operator targetTable stub
		hasColumnNamed: 'name') willReturn: false.
	
	self assert: operator canBeAppliedOnModel
]

{ #category : #tests }
DBEAddColumnTest >> testCanBeAppliedOnModel2 [
	(operator targetTable stub
		hasColumnNamed: 'name') willReturn: true.
		
	self deny: operator canBeAppliedOnModel.
]

{ #category : #tests }
DBEAddColumnTest >> testGenerateQueries [
	self assert: operator generateQueries equals: 'ALTER TABLE "person" ADD COLUMN "name" "text";'
]

{ #category : #tests }
DBEAddColumnTest >> testTemplateArgumentsDictionary [
	self
		assert: operator templateArgumentsDictionary
		equals: { 
			#columnName -> 'name'.
			#columnTypeName -> 'text'.
			#targetTableName -> 'person'
		} asDictionary
]
