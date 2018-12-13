Class {
	#name : #DBERemoveNamedConstraintTest,
	#superclass : #DBEOperatorTest,
	#category : #'DBEvolution-Tests'
}

{ #category : #accessing }
DBERemoveNamedConstraintTest >> operatorInstance [
	| tableEntityMock constraintEntityMock |
	tableEntityMock := Mock new.
	tableEntityMock stub
		name willReturn: 'person'.
	constraintEntityMock := Mock new.
	constraintEntityMock stub
		name willReturn: 'my_constraint'.
	constraintEntityMock stub
		table willReturn: tableEntityMock.
	^ DBERemoveNamedConstraint constraint: constraintEntityMock
]

{ #category : #tests }
DBERemoveNamedConstraintTest >> testCanBeAppliedOnData [
	self assert: operator canBeAppliedOnData
]

{ #category : #tests }
DBERemoveNamedConstraintTest >> testCanBeAppliedOnModel [
	self assert: operator canBeAppliedOnModel
]

{ #category : #tests }
DBERemoveNamedConstraintTest >> testGenerateQueries [
	self assert: operator generateQueries equals: 'ALTER TABLE "person" DROP CONSTRAINT "my_constraint";'
]

{ #category : #tests }
DBERemoveNamedConstraintTest >> testTemplateArgumentsDictionary [
	self
		assert: operator templateArgumentsDictionary
		equals: { 
			#tableName -> 'person'.
			#constraintName -> 'my_constraint'
		} asDictionary
]
