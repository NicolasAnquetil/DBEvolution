Extension { #name : #DBEMoveTable }

{ #category : #'*DBEvolution-Spec' }
DBEMoveTable >> printArgumentsForSpecOn: aStream [
	super printArgumentsForSpecOn: aStream.
	aStream
		nextPutAll: '->' ;
		nextPutAll: self targetSchema name
]
