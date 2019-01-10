Class {
	#name : #DBERemoveNotNullConstraint,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'column'
	],
	#category : #'DBEvolution-Operators-Constraints'
}

{ #category : #'instance creation' }
DBERemoveNotNullConstraint class >> column: column [
	^ self new
		column: column;
		yourself
]

{ #category : #testing }
DBERemoveNotNullConstraint >> canBeAppliedOnData [
	"Allowing a column to hold null values is always possible from a data point of view."
	^ true
]

{ #category : #testing }
DBERemoveNotNullConstraint >> canBeAppliedOnModel [
	"Allowing values of an existing column to be NULL is always possible from a model point of view.
	 If the column is already nulleable it's ok it will stay as it is."
	^ true
]

{ #category : #accessing }
DBERemoveNotNullConstraint >> column [
	^ column
]

{ #category : #accessing }
DBERemoveNotNullConstraint >> column: anObject [
	column := anObject
]

{ #category : #accessing }
DBERemoveNotNullConstraint >> maximalImpactSet [
	"Returns the maximal impact set of the operator."
	^ #()
]

{ #category : #accessing }
DBERemoveNotNullConstraint >> queriesTemplate [
	^ 'ALTER TABLE "{tableName}" ALTER COLUMN "{columnName}" DROP NOT NULL;'
]

{ #category : #private }
DBERemoveNotNullConstraint >> recommandationsGenerator [
	self flag: #TODO.
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | true ] asDBEImpactFilter -> { 
			[ :entity | DBEHumanIntervention entity: entity ] } }.
]

{ #category : #accessing }
DBERemoveNotNullConstraint >> templateArgumentsDictionary [
	^ { 
		#columnName -> self column name.
		#tableName -> self column table name
	} asDictionary
]
