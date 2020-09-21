Extension { #name : #DBEMoveStoredProcedure }

{ #category : #'*DBEvolution-Spec' }
DBEMoveStoredProcedure >> printArgumentsForSpecOn: aStream [
	super printArgumentsForSpecOn: aStream.
	aStream
		nextPutAll: (self storedProcedure name) ;
		nextPutAll: '->' ;
		nextPutAll: self targetSchema name
]
