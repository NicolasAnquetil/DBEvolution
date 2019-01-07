Class {
	#name : #DBERemoveColumn,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'targetColumn'
	],
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

{ #category : #private }
DBERemoveColumn >> impactAndRecommandations [
	^ DBEImpactAndRecommandations impacts: { 
		[ :entity :m :db | entity isForeignKey ] asDBEImpactFilter -> { 
			[ :fkConstraint | DBERemoveForeignKeyConstraint constraint: fkConstraint ] }.
		[ :entity :m :db | entity isConstraint and: [ entity isForeignKey not ] ] asDBEImpactFilter -> { 
			[ :constraint | DBEHumanIntervention entity: constraint ] }.
		[ :entity :m :db | entity isClauseAbleToReferenceColumn and: [ entity isWhereClause not and: [ entity isJoinClause not ] ] ] asDBEImpactFilter -> { 
			[ :clause | DBEHumanIntervention entity: clause ] }.
		[ :entity :m :db | entity isWhereClause or: [ entity isJoinClause ] ] asDBEImpactFilter -> { 
			[ :whereOrJoinClause | DBEHumanIntervention entity: whereOrJoinClause ] }
	}
]

{ #category : #accessing }
DBERemoveColumn >> queriesTemplate [
	^ 'ALTER TABLE "{tableName}" DROP COLUMN "{columnName}";'
]

{ #category : #accessing }
DBERemoveColumn >> targetColumn [
	^ targetColumn
]

{ #category : #accessing }
DBERemoveColumn >> targetColumn: anObject [
	targetColumn := anObject
]

{ #category : #accessing }
DBERemoveColumn >> templateArgumentsDictionary [
	^ { 
		#columnName -> self targetColumn name.
		#tableName -> self targetColumn table name
	} asDictionary
]
