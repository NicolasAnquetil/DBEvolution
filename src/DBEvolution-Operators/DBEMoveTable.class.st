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

{ #category : #printing }
DBEMoveTable >> printArgumentsForSpecOn: aStream [
	super printArgumentsForSpecOn: aStream.
	aStream
		nextPutAll: ' to ' ;
		nextPutAll: self targetSchema name
]

{ #category : #accessing }
DBEMoveTable >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'ALTER TABLE "{tableName}"
    SET SCHEMA "{schemaName}"'
]

{ #category : #private }
DBEMoveTable >> recommandationsGenerator [

	^ DBERecommandationsGenerator
		filters:
			{
			([ :entity :db | entity isTableReference ] asDBEImpactFilter
				-> {[ :tr | DBEHumanIntervention entity:  tr source ]})
			.

			([ :entity :db | self isColumnReferenceForeignKeyTarget: entity] asDBEImpactFilter
				-> {[ :cr | DBERenameTableNameInForeignKeyConstaint reference: cr newName: self targetTable qualifiedName ]})
			.
			([ :entity :db | entity isColumnReference ] asDBEImpactFilter
				-> {[ :tr | DBEHumanIntervention entity:  tr source ]})

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
DBEMoveTable >> templateArgumentsDictionary [
	^ super templateArgumentsDictionary
		at: #schemaName put: (self targetSchema name) ;
		yourself

]
