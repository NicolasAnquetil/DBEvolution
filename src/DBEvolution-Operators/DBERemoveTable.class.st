Class {
	#name : #DBERemoveTable,
	#superclass : #DBEOperatorOnTable,
	#category : #'DBEvolution-Operators-Table'
}

{ #category : #testing }
DBERemoveTable >> canBeAppliedOnData [
	"Removing a column is always possible, there is no data configuration that avoid it."
	^ false
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
DBERemoveTable >> maximalImpactSet [
	self flag: 'Redefine to filter out the constraint not foreignkeys and column reference when in a group'.
	^ self targetTable maximalImpactSet
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
			([ :entity :db | self isTableReferenceQualifyingAColumn: entity ] asDBEImpactFilter
				-> {[ :tr | DBEDoNothing new ]}).
				
			([ :entity :db | self isTableReferenceNotQualifyingAColumn: entity ] asDBEImpactFilter
				-> {[ :tr | DBEHumanIntervention entity: tr source ]}).

			([ :entity :db | self isColumnReferenceForeignKeyTarget: entity] asDBEImpactFilter
				-> {[ :cr | DBERemoveForeignKeyConstraint constraint: cr foreignKeyConstraintSource ]}).
				
			([ :entity :db | self isColumnReferenceConstraint: entity] asDBEImpactFilter
				-> {[ :cr | DBEDoNothing new ]}).
				
			([ :entity :db | self isColumnReferenceNotConstraint: entity ] asDBEImpactFilter
				-> {[ :cr | DBEHumanIntervention entity: cr source ]}).
}
]
