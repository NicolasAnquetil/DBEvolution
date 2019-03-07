Extension { #name : #FmxSQLStoredProcedure }

{ #category : #'*DBEvolution-Operators' }
FmxSQLStoredProcedure >> maximalImpactSet [
	^ self incomingInvocations
]
