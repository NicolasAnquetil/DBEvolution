Class {
	#name : #DBEAddConstraint,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'targetTable',
		'constraintName'
	],
	#category : #'DBEvolution-Operators-Constraints'
}

{ #category : #accessing }
DBEAddConstraint >> constraintName [
	^ constraintName
]

{ #category : #accessing }
DBEAddConstraint >> constraintName: anObject [
	constraintName := anObject
]

{ #category : #accessing }
DBEAddConstraint >> maximalImpactSet [
	self flag: #TODO.
	^ {  }
]

{ #category : #private }
DBEAddConstraint >> recommandationsGenerator [
	self flag: #TODO.
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | true ] asDBEImpactFilter -> { 
			[ :entity | DBEHumanIntervention entity: entity ] } }.
]

{ #category : #accessing }
DBEAddConstraint >> targetTable [
	^ targetTable
]

{ #category : #accessing }
DBEAddConstraint >> targetTable: anObject [
	targetTable := anObject
]

{ #category : #accessing }
DBEAddConstraint >> templateArgumentsDictionary [
	^ { 
		#tableName -> self targetTable name.
		#constraintName -> self constraintName.
	} asDictionary
]
