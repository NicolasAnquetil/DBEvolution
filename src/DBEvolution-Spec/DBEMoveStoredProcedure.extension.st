Extension { #name : #DBEMoveStoredProcedure }

{ #category : #'*DBEvolution-Spec' }
DBEMoveStoredProcedure >> printArgumentsForSpecOn: aStream [
	super printArgumentsForSpecOn: aStream.
	aStream
		nextPutAll: '->' ;
		nextPutAll: self targetSchema name
]
