Extension { #name : #FmxSQLColumn }

{ #category : #'*DBEvolution-Operators' }
FmxSQLColumn >> maximalImpactSet [
	^ self references
]
