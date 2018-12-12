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
	self flag: #TODO.
	^ DBEImpactAndRecommandations impacts: { 
		[ :entity :m :db | m isForeignKey: entity ] asDBEImpactFilter -> { DBEHumanIntervention }.
		[ :entity :m :db | (m isConstraint: entity) and: [ (m isForeignKey: entity) not ] ] asDBEImpactFilter -> { DBEHumanIntervention }.
		[ :entity :m :db | (m isClauseAbleToReferenceColumn: entity) and: [ (m isWhereClause: entity) not and: [ (m isJoinClause: entity) not ] ] ] asDBEImpactFilter -> { DBEHumanIntervention }.
		[ :entity :m :db | (m isWhereClause: entity) or: [ m isJoinClause: entity ] ] asDBEImpactFilter -> { DBEHumanIntervention } }
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
