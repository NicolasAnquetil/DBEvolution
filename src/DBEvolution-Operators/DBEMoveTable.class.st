Class {
	#name : #DBEMoveTable,
	#superclass : #DBEOperatorOnTable,
	#instVars : [
		'targetSchema'
	],
	#category : #'DBEvolution-Operators-Table'
}

{ #category : #testing }
DBEMoveTable >> canBeAppliedOnData [
	"Concrete subclasses should override this method in order that it returns true if the operator can be applied on the data stored in the database."
	^ false
]

{ #category : #testing }
DBEMoveTable >> canBeAppliedOnModel [
	"Concrete subclasses should override this method in order that it returns true if the operator can be applied on the model of the database."
	^ true
]

{ #category : #accessing }
DBEMoveTable >> maximalImpactSet [
	self flag: 'Could also be a foreignkey constaint ?'.
	^ super maximalImpactSet
		reject: [ :impact |
			impact isColumnReference "and:
			[ impact sourcedBelonger == targetTable ]"
		or: 
		[ impact isTableReference and: [impact sourcedBelonger isView] ]
		]
]

{ #category : #accessing }
DBEMoveTable >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'ALTER TABLE "{tableName}"
    SET SCHEMA "{schemaName}";'
]

{ #category : #private }
DBEMoveTable >> recommandationsGenerator [

	^ DBERecommandationsGenerator
		filters:
			{
			([ :entity :db | entity isTableReference ] asDBEImpactFilter
				-> {[ :tr | DBERenameReferenceInStoredProcedure
						reference: tr
						newName: self targetTableName ]})
			}
]

{ #category : #accessing }
DBEMoveTable >> targetSchema [
	^targetSchema
]

{ #category : #accessing }
DBEMoveTable >> targetSchema: schema [
	targetSchema := schema
]

{ #category : #accessing }
DBEMoveTable >> targetTableName [
	^self targetSchema name , '.' , self targetTable name 
]

{ #category : #accessing }
DBEMoveTable >> templateArgumentsDictionary [
	^ super templateArgumentsDictionary
		at: #schemaName put: (self targetSchema name) ;
		yourself

]
