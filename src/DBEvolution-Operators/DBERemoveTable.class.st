Class {
	#name : #DBERemoveTable,
	#superclass : #DBEOperatorOnTable,
	#category : #'DBEvolution-Operators-Table'
}

{ #category : #testing }
DBERemoveTable >> canBeAppliedOnData [
	"Removing a column is always possible, there is no data configuration that avoid it."
	^ true
]

{ #category : #testing }
DBERemoveTable >> canBeAppliedOnModel [
	"Since we consider that the column held by the operator exist in the model, there is no reason for this operator not to be applicable."
	^ true
]

{ #category : #accessing }
DBERemoveTable >> documentation [
	^ 'Removes a table.'
]

{ #category : #accessing }
DBERemoveTable >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'DROP TABLE "{tableName}" RESTRICT;'
]

{ #category : #private }
DBERemoveTable >> recommandationsGenerator [
	^ DBERecommandationsGenerator
		filters:
			{
			([ :entity :db | entity isTableReference. ] asDBEImpactFilter
				-> {[ :tr | DBEHumanIntervention entity: tr source ]}).
			([ :entity :db | entity isColumnReference and: [entity foreignKeyConstraintSource isNotNil]] asDBEImpactFilter
				-> {[ :cr | DBERemoveForeignKeyConstraint constraint: cr foreignKeyConstraintSource ]}).
			([ :entity :db | entity isColumnReference and: [entity foreignKeyConstraintSource isNil  ]] asDBEImpactFilter
				-> {[ :cr | DBEDoNothing new ]}).
}
]
