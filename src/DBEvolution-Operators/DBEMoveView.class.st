Class {
	#name : #DBEMoveView,
	#superclass : #DBEViewOperator,
	#instVars : [
		'targetSchema'
	],
	#category : #'DBEvolution-Operators-View'
}

{ #category : #testing }
DBEMoveView >> canBeAppliedOnData [
	"Concrete subclasses should override this method in order that it returns true if the operator can be applied on the data stored in the database."
	^ false
]

{ #category : #testing }
DBEMoveView >> canBeAppliedOnModel [
	"Concrete subclasses should override this method in order that it returns true if the operator can be applied on the model of the database."
	^ true
]

{ #category : #accessing }
DBEMoveView >> maximalImpactSet [
	^ super maximalImpactSet
		reject: [ :impact |
			impact isColumnReference
		or: 
		[ impact isViewReference and: [impact sourcedBelonger isView] ]
		]
]

{ #category : #testing }
DBEMoveView >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'ALTER VIEW "{viewName}"
    SET SCHEMA "{schemaName}";'
]

{ #category : #private }
DBEMoveView >> recommandationsGenerator [

	^ DBERecommandationsGenerator
		filters:
			{
			([ :entity :db | entity isViewReference ] asDBEImpactFilter
				-> {[ :vref |
						DBERenameReferenceInStoredProcedure
							reference: vref
							newName: self targetViewName ]})
			}
]

{ #category : #testing }
DBEMoveView >> targetSchema [
	^targetSchema
]

{ #category : #testing }
DBEMoveView >> targetSchema: schema [
	targetSchema := schema
]

{ #category : #testing }
DBEMoveView >> targetViewName [
	^self targetSchema name , '.' , self view name 
]

{ #category : #testing }
DBEMoveView >> templateArgumentsDictionary [
	^ super templateArgumentsDictionary
		at: #schemaName put: (self targetSchema name) ;
		yourself

]
