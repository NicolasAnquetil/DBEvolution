Extension { #name : #FmxSQLClause }

{ #category : #'*DBEvolution-Operators' }
FmxSQLClause >> isClauseAbleToReferenceColumn [
	^ self class traitComposition allTraits includes: FmxSQLTWithColumnReference
]
