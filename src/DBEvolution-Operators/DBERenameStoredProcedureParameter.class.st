Class {
	#name : #DBERenameStoredProcedureParameter,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'parameter',
		'newParameterName'
	],
	#category : #'DBEvolution-Operators-StoredProcedure'
}

{ #category : #testing }
DBERenameStoredProcedureParameter >> canBeAppliedOnData [
	"Can always be applied whatever the data contained by the DB."
	^ true
]

{ #category : #testing }
DBERenameStoredProcedureParameter >> canBeAppliedOnModel [
	"Can always be applied."
	^ true
]

{ #category : #accessing }
DBERenameStoredProcedureParameter >> maximalImpactSet [
	^ self parameter maximalImpactSet
]

{ #category : #accessing }
DBERenameStoredProcedureParameter >> newParameterName [
	^ newParameterName
]

{ #category : #accessing }
DBERenameStoredProcedureParameter >> newParameterName: anObject [
	newParameterName := anObject
]

{ #category : #accessing }
DBERenameStoredProcedureParameter >> parameter [
	^ parameter
]

{ #category : #accessing }
DBERenameStoredProcedureParameter >> parameter: anObject [
	parameter := anObject
]

{ #category : #private }
DBERenameStoredProcedureParameter >> recommandationsGenerator [
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | entity isParameterAccess ] asDBEImpactFilter -> { 
			[ :aliasAccess | DBERenameReferenceInStoredProcedure reference: aliasAccess newName: self newParameterName ] }.
	}
]
