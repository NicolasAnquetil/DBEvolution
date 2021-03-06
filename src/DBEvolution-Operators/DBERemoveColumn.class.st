Class {
	#name : #DBERemoveColumn,
	#superclass : #DBEOperatorTargettingColumnInModel,
	#category : #'DBEvolution-Operators-Column'
}

{ #category : #'instance creation' }
DBERemoveColumn class >> column: column [ 
	^ self new
		targetColumn: column;
		yourself
]

{ #category : #testing }
DBERemoveColumn >> canBeAppliedOnData [
	"Removing a column is always possible, there is no data configuration that avoid it."
	^ true
]

{ #category : #testing }
DBERemoveColumn >> canBeAppliedOnModel [
	"Since we consider that the column held by the operator exist in the model, there is no reason for this operator not to be applicable."
	^ true
]

{ #category : #accessing }
DBERemoveColumn >> documentation [
	^ 'Removes a column from a table.'
]

{ #category : #accessing }
DBERemoveColumn >> queriesTemplate [
	^ 'ALTER TABLE "{tableName}" DROP COLUMN "{columnName}";'
]

{ #category : #private }
DBERemoveColumn >> recommandationsGenerator [
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | entity isPrimaryKey ] asDBEImpactFilter -> { 
			[ :pkConstraint | DBERemovePrimaryKeyConstraint constraint: pkConstraint ] }.
		[ :entity :db | entity isForeignKey ] asDBEImpactFilter -> { 
			[ :fkConstraint | DBERemoveForeignKeyConstraint constraint: fkConstraint ] }.
		[ :entity :db | entity isNotNullConstraint ] asDBEImpactFilter -> { 
			[ :notNullConstraint | DBERemoveNotNullConstraint column: notNullConstraint outgoingColumnReferences first column ] }.
		[ :entity :db | entity isUniqueConstraint ] asDBEImpactFilter -> { 
			[ :uniqueConstraint | DBERemoveUniqueConstraint constraint: uniqueConstraint ] }.
		[ :entity :db | entity isCheckConstraint ] asDBEImpactFilter -> { 
			[ :checkConstraint | DBERemoveCheckConstraint constraint: checkConstraint ] }.
		[ :entity :db | entity isClauseAbleToReferenceColumn and: [ entity isWhereClause not and: [ entity isJoinClause not ] ] ] asDBEImpactFilter -> { 
			[ :clause | DBEHumanIntervention entity: clause ] }.
		[ :entity :db | entity isColumnAlias ] asDBEImpactFilter -> { 
			[ :alias | DBEHumanIntervention entity: alias ] }.
		[ :entity :db | entity isWhereClause or: [ entity isJoinClause ] ] asDBEImpactFilter -> { 
			[ :whereOrJoinClause | DBEHumanIntervention entity: whereOrJoinClause ] }
	}
]
