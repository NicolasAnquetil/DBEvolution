Class {
	#name : #DBERemovePrimaryKeyConstraint,
	#superclass : #DBERemoveNamedConstraint,
	#category : #'DBEvolution-Operators-Constraints'
}

{ #category : #testing }
DBERemovePrimaryKeyConstraint >> canBeAppliedOnModel [
	^ super canBeAppliedOnModel
		and: [ self constraint columnsAreReferencedByForeignKeyConstraints not ]
]
