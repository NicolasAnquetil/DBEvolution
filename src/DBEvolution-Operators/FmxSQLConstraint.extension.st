Extension { #name : #FmxSQLConstraint }

{ #category : #'*DBEvolution-Operators' }
FmxSQLConstraint >> maximalImpactSet [
	^ self outgoingColumnReferences collect: [ :ref | 
		ref column maximalImpactSet ]
]
