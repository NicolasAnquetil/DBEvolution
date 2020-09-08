Extension { #name : #FmxSQLPrimaryKeyConstraint }

{ #category : #'*DBEvolution-Operators' }
FmxSQLPrimaryKeyConstraint >> maximalImpactSet [
	"for now we assume there is only one column referenced to simplify"
	^self outgoingColumnReferences first column references select: [ :ref |
		ref isForeignKeyConstraint ]
]
