Class {
	#name : #DBERenameReferenceInSelectClause,
	#superclass : #DBERenameReference,
	#category : #'DBEvolution-Operators-References'
}

{ #category : #accessing }
DBERenameReferenceInSelectClause >> maximalImpactSet [
	^ self selectClause belongsTo maximalImpactSet
]

{ #category : #private }
DBERenameReferenceInSelectClause >> recommandationsGenerator [
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | true ] asDBEImpactFilter -> { 
			[ :viewReference | DBEHumanIntervention entity: viewReference source ] } }
]

{ #category : #accessing }
DBERenameReferenceInSelectClause >> selectClause [
	^ self reference source belongsTo
]
