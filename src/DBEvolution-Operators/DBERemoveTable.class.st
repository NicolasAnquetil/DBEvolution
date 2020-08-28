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

{ #category : #private }
DBERemoveTable >> isColumnReferenceConstraint: entity [
	entity isColumnReference ifFalse: [ ^false ].
	^entity source isConstraint
]

{ #category : #private }
DBERemoveTable >> isColumnReferenceForeignKeyTarget: entity [
	^entity isColumnReference and: [
		entity foreignKeyConstraintSource isNotNil
	]
]

{ #category : #private }
DBERemoveTable >> isColumnReferenceNotConstraint: entity [
	entity isColumnReference ifFalse: [ ^false ].
	^entity source isConstraint not
]

{ #category : #private }
DBERemoveTable >> isTableReferenceNotQualifyingAColumn: entity [
	entity isTableReference ifFalse: [ ^ false ].
	entity qualifiedReference ifNil: [ ^true ].
	^entity qualifiedReference references noneSatisfy: [ :ref | ref isColumnReference ]

]

{ #category : #private }
DBERemoveTable >> isTableReferenceQualifyingAColumn: entity [ 
	entity isTableReference ifFalse: [ ^false ].
	entity qualifiedReference ifNil: [ ^ false ].
	^entity qualifiedReference references anySatisfy: [ :ref | ref isColumnReference ]
]

{ #category : #accessing }
DBERemoveTable >> maximalImpactSet [
	self flag: 'Redefine to filter out the constraint not foreignkeys and column reference when in a group'.
	^ self targetTable maximalImpactSet
]

{ #category : #printing }
DBERemoveTable >> printArgumentsForSpecOn: aStream [
	super printArgumentsForSpecOn: aStream.
	aStream
		nextPutAll: self targetTable name
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
