Extension { #name : #FmxSQLStoredProcedureCall }

{ #category : #'*DBEvolution' }
FmxSQLStoredProcedureCall >> stopIndexInReplacement [
	^(self sourcedBelonger source indexOf: $( startingAt: self start) - 1 
]
