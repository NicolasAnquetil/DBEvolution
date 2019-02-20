Extension { #name : #FmxSQLView }

{ #category : #'*DBEvolution-Operators' }
FmxSQLView >> maximalImpactSet [
	^ self queryLocalIncoming: FmxSQLViewReference
]
