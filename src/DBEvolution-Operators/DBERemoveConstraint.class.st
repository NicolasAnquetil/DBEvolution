Class {
	#name : #DBERemoveConstraint,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'constraint'
	],
	#category : #'DBEvolution-Operators-Constraints'
}

{ #category : #accessing }
DBERemoveConstraint class >> constraint: anObject [
	^ self new
		constraint: anObject;
		yourself
]

{ #category : #testing }
DBERemoveConstraint >> canBeAppliedOnData [
	^ true
]

{ #category : #testing }
DBERemoveConstraint >> canBeAppliedOnModel [
	^ true
]

{ #category : #accessing }
DBERemoveConstraint >> constraint [
	^ constraint
]

{ #category : #accessing }
DBERemoveConstraint >> constraint: anObject [
	constraint := anObject
]

{ #category : #accessing }
DBERemoveConstraint >> queriesTemplate [
	^ 'ALTER TABLE "{tableName}" DROP CONSTRAINT "{constraintName}";'
]

{ #category : #accessing }
DBERemoveConstraint >> templateArgumentsDictionary [
	^ { 
		#tableName -> self constraint table name.
		#constraintName -> self constraint name
	 } asDictionary
]
