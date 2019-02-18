Extension { #name : #FmxSQLEntity }

{ #category : #'*DBEvolution-Operators' }
FmxSQLEntity >> isClauseAbleToReferenceColumn [
	^ false
]

{ #category : #'*DBEvolution-Operators' }
FmxSQLEntity >> isColumnAlias [
	^ false
]

{ #category : #'*DBEvolution-Operators' }
FmxSQLEntity >> maximalImpactSet [
	^ self queryAllIncoming
]
