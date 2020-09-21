Class {
	#name : #DBEMoveStoredProcedure,
	#superclass : #DBEStoredProcedureOperator,
	#instVars : [
		'targetSchema'
	],
	#category : #'DBEvolution-Operators-StoredProcedure'
}

{ #category : #testing }
DBEMoveStoredProcedure >> canBeAppliedOnData [
	"Concrete subclasses should override this method in order that it returns true if the operator can be applied on the data stored in the database."
	^ false
]

{ #category : #testing }
DBEMoveStoredProcedure >> canBeAppliedOnModel [
	"Concrete subclasses should override this method in order that it returns true if the operator can be applied on the model of the database."
	^ true
]

{ #category : #accessing }
DBEMoveStoredProcedure >> formatArgument: arguments [
	| str |
	str := String streamContents: [ :st |
	].
	^'(' ,
	str ,
	')'
]

{ #category : #accessing }
DBEMoveStoredProcedure >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'ALTER FUNCTION "{storedProcedureName}"
    SET SCHEMA "{schemaName}";'
]

{ #category : #private }
DBEMoveStoredProcedure >> recommandationsGenerator [
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db |
			entity isStoredProcedureCall and:
			[ entity from isAnyBelongerSourced and:
			[ entity from sourcedBelonger isStoredProcedure ] ] ] asDBEImpactFilter
			-> { 
				[ :ref | DBERenameReferenceInStoredProcedure reference: ref newName: self targetStoredProcedureCall ]
			}
			.
			[ :entity :db | entity isStoredProcedureCall and:
			[ entity from isAnyBelongerSourced and:
			[ entity from sourcedBelonger isView ] ] ]
			asDBEImpactFilter
			-> { 
				"select and nonSelect clauses are treated the same"
				[ :ref | DBERenameReferenceInNonSelectClause reference: ref newName: self targetStoredProcedureCall ]
			}
	}
]

{ #category : #accessing }
DBEMoveStoredProcedure >> targetSchema [
	^targetSchema
]

{ #category : #accessing }
DBEMoveStoredProcedure >> targetSchema: schema [
	targetSchema := schema
]

{ #category : #accessing }
DBEMoveStoredProcedure >> targetStoredProcedureCall [

	^self
		targetSchema name ,
		'.' ,
		self storedProcedure name
]

{ #category : #accessing }
DBEMoveStoredProcedure >> templateArgumentsDictionary [
	^ super templateArgumentsDictionary
		at: #schemaName put: (self targetSchema name) ;
		yourself

]
