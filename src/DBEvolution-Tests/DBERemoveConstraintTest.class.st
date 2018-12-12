Class {
	#name : #DBERemoveConstraintTest,
	#superclass : #DBEOperatorTest,
	#category : #'DBEvolution-Tests'
}

{ #category : #accessing }
DBERemoveConstraintTest >> operatorInstance [
	| tableEntityMock constraintEntityMock |
	tableEntityMock := Mock new.
	tableEntityMock stub
		name willReturn: 'person'.
	constraintEntityMock := Mock new.
	constraintEntityMock stub
		name willReturn: 'my_constraint'.
	constraintEntityMock stub
		table willReturn: tableEntityMock.
	^ DBERemoveConstraint constraint: constraintEntityMock
]

{ #category : #tests }
DBERemoveConstraintTest >> testCanBeAppliedOnData [
	self assert: operator canBeAppliedOnData
]

{ #category : #tests }
DBERemoveConstraintTest >> testCanBeAppliedOnModel [
	self assert: operator canBeAppliedOnModel
]

{ #category : #tests }
DBERemoveConstraintTest >> testGenerateQueries [
	self assert: operator generateQueries equals: 'ALTER TABLE "person" DROP CONSTRAINT "my_constraint";'
]

{ #category : #tests }
DBERemoveConstraintTest >> testTemplateArgumentsDictionary [
	self
		assert: operator templateArgumentsDictionary
		equals: { 
			#tableName -> 'person'.
			#constraintName -> 'my_constraint'
		} asDictionary
]
