Class {
	#name : #DBEAddColumnTest,
	#superclass : #DBEOperatorTest,
	#category : #'DBEvolution-Tests'
}

{ #category : #accessing }
DBEAddColumnTest >> operatorClass [
	^ DBEAddColumn
]

{ #category : #tests }
DBEAddColumnTest >> testCanBeAppliedOnData [
	self assert: operator canBeAppliedOnData
]

{ #category : #tests }
DBEAddColumnTest >> testCanBeAppliedOnModel [
	(modelMock table: 'person' hasColumnNamed: 'name') willReturn: false.
	(modelMock hasTypeNamed: 'text') willReturn: true.
	
	self assert: operator canBeAppliedOnModel
]

{ #category : #tests }
DBEAddColumnTest >> testCanBeAppliedOnModel2 [
	(modelMock table: 'person' hasColumnNamed: 'name') willReturn: true.
	(modelMock hasTypeNamed: 'text') willReturn: true.
		
	self deny: operator canBeAppliedOnModel.
	
	(modelMock table: 'person' hasColumnNamed: 'name') willReturn: true.
	(modelMock hasTypeNamed: 'text') willReturn: false.
		
	self deny: operator canBeAppliedOnModel.
	
	(modelMock table: 'person' hasColumnNamed: 'name') willReturn: false.
	(modelMock hasTypeNamed: 'text') willReturn: false.
		
	self deny: operator canBeAppliedOnModel.
]

{ #category : #tests }
DBEAddColumnTest >> testCanBeAppliedOnModel3 [
	(modelMock table: 'person' hasColumnNamed: 'name') willReturn: true.
	(modelMock hasTypeNamed: 'text') willReturn: false.
		
	self deny: operator canBeAppliedOnModel
]

{ #category : #tests }
DBEAddColumnTest >> testCanBeAppliedOnModel4 [
	(modelMock table: 'person' hasColumnNamed: 'name') willReturn: false.
	(modelMock hasTypeNamed: 'text') willReturn: false.
		
	self deny: operator canBeAppliedOnModel.
]

{ #category : #tests }
DBEAddColumnTest >> testGenerateQueries [
	self assert: operator generateQueries equals: 'ALTER TABLE "person" ADD COLUMN "name" "text";'
]
