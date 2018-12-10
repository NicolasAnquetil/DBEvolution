Class {
	#name : #DBERemoveColumnTest,
	#superclass : #DBEOperatorTest,
	#category : #'DBEvolution-Tests'
}

{ #category : #accessing }
DBERemoveColumnTest >> operatorInstance [
	^ DBERemoveColumn table: 'person' column: 'name'
]

{ #category : #tests }
DBERemoveColumnTest >> testCanBeAppliedOnData [
	self assert: operator canBeAppliedOnData
]

{ #category : #tests }
DBERemoveColumnTest >> testCanBeAppliedOnModel [
	(modelMock hasTableNamed: 'person') willReturn: true.
	(modelMock table: 'person' hasColumnNamed: 'name') willReturn: true.
	
	self assert: operator canBeAppliedOnModel
]

{ #category : #tests }
DBERemoveColumnTest >> testCanBeAppliedOnModel2 [
	(modelMock hasTableNamed: 'person') willReturn: false.
	(modelMock table: 'person' hasColumnNamed: 'name') willReturn: true.
	
	self deny: operator canBeAppliedOnModel
]

{ #category : #tests }
DBERemoveColumnTest >> testCanBeAppliedOnModel3 [
	(modelMock hasTableNamed: 'person') willReturn: true.
	(modelMock table: 'person' hasColumnNamed: 'name') willReturn: false.
	
	self deny: operator canBeAppliedOnModel
]

{ #category : #tests }
DBERemoveColumnTest >> testCanBeAppliedOnModel4 [
	(modelMock hasTableNamed: 'person') willReturn: false.
	(modelMock table: 'person' hasColumnNamed: 'name') willReturn: false.
	
	self deny: operator canBeAppliedOnModel
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
			#targetTable -> 'person'
		} asDictionary
]
