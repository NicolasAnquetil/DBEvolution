Class {
	#name : #DBERemovePrimaryKeyConstraintTest,
	#superclass : #DBERemoveNamedConstraintTest,
	#instVars : [
		'constraintEntityMock'
	],
	#category : #'DBEvolution-Tests'
}

{ #category : #accessing }
DBERemovePrimaryKeyConstraintTest >> operatorInstance [
	| tableEntityMock |
	tableEntityMock := Mock new.
	tableEntityMock stub
		name willReturn: 'person'.
	constraintEntityMock := Mock new.
	constraintEntityMock stub
		name willReturn: 'pk_constraint'.
	constraintEntityMock stub
		table willReturn: tableEntityMock.
	^ DBERemovePrimaryKeyConstraint constraint: constraintEntityMock
]

{ #category : #tests }
DBERemovePrimaryKeyConstraintTest >> testCanBeAppliedOnModel [
	(constraintEntityMock stub
		columnsAreReferencedByForeignKeyConstraints) willReturn: false.
		
	self assert: operator canBeAppliedOnModel.
	
	(constraintEntityMock stub
		columnsAreReferencedByForeignKeyConstraints) willReturn: true.
		
	self deny: operator canBeAppliedOnModel
]
