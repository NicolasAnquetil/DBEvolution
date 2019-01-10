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

{ #category : #accessing }
DBERemovePrimaryKeyConstraint >> maximalImpactSet [
	^ (self constraint columns collect: #foreignKeyConstraintsReferencing) flattened asSet asArray
]

{ #category : #private }
DBERemovePrimaryKeyConstraint >> recommandationsGenerator [
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | entity isForeignKey ] asDBEImpactFilter -> { 
			[ :fkConstraint | DBERemoveForeignKeyConstraint constraint: fkConstraint ] } }.
]
