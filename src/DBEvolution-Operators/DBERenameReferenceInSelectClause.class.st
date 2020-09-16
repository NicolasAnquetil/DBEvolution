Class {
	#name : #DBERenameReferenceInSelectClause,
	#superclass : #DBERenameReference,
	#category : #'DBEvolution-Operators-References'
}

{ #category : #accessing }
DBERenameReferenceInSelectClause >> maximalImpactSet [
	| view column |
	self flag: #TOFIX. "Dirty code, needs some love."
	view := self selectClause query container ifNil: [ ^ #() ].
	column := (view columnsToColumnReferences associations
			detect: [ :assoc | assoc value sourceAnchor interval includesAll: self reference sourceAnchor interval ]) key.
	(view doesNameOfColumnComesFromAlias: column)
		ifTrue: [ ^ #() ].
	^ column maximalImpactSet
				reject: [ :columnReference |self flag: #TOFIX. "Duplication with DBERenameColumn>>#maximalImpactSet"
					(columnReference source ifNil: [ columnReference foreignKeyConstraintSource ])
						in: [ :source | source isConstraint or: [ source isAlias ] ] ]
]

{ #category : #private }
DBERenameReferenceInSelectClause >> recommandationsGenerator [
	"^ DBERecommandationsGenerator filters: { 
		[ :entity :db | true ] asDBEImpactFilter -> { 
			[ :viewReference | DBEHumanIntervention entity: viewReference source ] } }"
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | entity isColumnReference and: [ entity isWildCardReference ] ] asDBEImpactFilter
			-> { [ :ref | DBEDoNothing new ] }
		.
		[ :entity :db | entity isColumnReference and: [ entity source isAnyBelongerSourced and: [ entity source sourcedBelonger class = FmxSQLView and: [ entity source class = FmxSQLSelectClause ] ] ] ] asDBEImpactFilter
			-> { 
				[ :ref | DBERenameReferenceInSelectClause reference: ref newName: self newReferenceName ].
				[ :ref | DBEDoNothing new ] }
		.
		[ :entity :db | entity isColumnReference and: [ entity source isAnyBelongerSourced and: [ entity source sourcedBelonger class = FmxSQLView ] ] ] asDBEImpactFilter
			-> { 
				[ :ref | DBERenameReferenceInNonSelectClause reference: ref newName: self newReferenceName ].
				[ :ref | DBEDoNothing new ] }
		.
		[ :entity :db | entity isColumnReference and: [ entity source isAnyBelongerSourced and: [ entity source sourcedBelonger class = FmxSQLStoredProcedure ] ] ] asDBEImpactFilter
			-> { 
				[ :ref | DBERenameReferenceInStoredProcedure reference: ref newName: self newReferenceName ].
				[ :ref | DBEDoNothing new ] }
	}
]

{ #category : #accessing }
DBERenameReferenceInSelectClause >> selectClause [
	^ self reference from
]
