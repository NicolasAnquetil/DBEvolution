Class {
	#name : #DBERemoveNamedConstraint,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'constraint'
	],
	#category : #'DBEvolution-Operators-Constraints'
}

{ #category : #accessing }
DBERemoveNamedConstraint class >> constraint: anObject [
	^ self new
		constraint: anObject;
		yourself
]

{ #category : #testing }
DBERemoveNamedConstraint >> canBeAppliedOnData [
	"Since removing a constraint extends the set of data it is possible to insert in the table, there is not way data prevent to remove a constraint."
	^ true
]

{ #category : #testing }
DBERemoveNamedConstraint >> canBeAppliedOnModel [
	"It is usually always ok for the model to remove a constraint. The only case where it is not is for a primary key constraint referenced by foreign key constraints.
	 This case is handled in the subclass corresponding to the removal of a primary key."
	^ true
]

{ #category : #accessing }
DBERemoveNamedConstraint >> constraint [
	^ constraint
]

{ #category : #accessing }
DBERemoveNamedConstraint >> constraint: anObject [
	constraint := anObject
]

{ #category : #accessing }
DBERemoveNamedConstraint >> maximalImpactSet [
	self flag: #TODO.
	^ {  }
]

{ #category : #accessing }
DBERemoveNamedConstraint >> queriesTemplate [
	^ 'ALTER TABLE "{tableName}" DROP CONSTRAINT "{constraintName}";'
]

{ #category : #private }
DBERemoveNamedConstraint >> recommandationsGenerator [
	self flag: #TODO.
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | true ] asDBEImpactFilter -> { 
			[ :entity | DBEHumanIntervention entity: entity ] } }.
]

{ #category : #accessing }
DBERemoveNamedConstraint >> templateArgumentsDictionary [
	^ { 
		#tableName -> self constraint table name.
		#constraintName -> self constraint name
	 } asDictionary
]
