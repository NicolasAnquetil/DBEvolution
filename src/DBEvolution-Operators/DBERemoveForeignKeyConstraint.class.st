Class {
	#name : #DBERemoveForeignKeyConstraint,
	#superclass : #DBERemoveNamedConstraint,
	#category : #'DBEvolution-Operators-Constraints'
}

{ #category : #private }
DBERemoveForeignKeyConstraint >> recommandationsGenerator [

	^ DBERecommandationsGenerator
		filters:
			{ }
]
