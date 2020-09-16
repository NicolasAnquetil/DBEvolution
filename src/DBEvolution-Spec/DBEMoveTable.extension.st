Extension { #name : #DBEMoveTable }

{ #category : #'*DBEvolution-Spec' }
DBEMoveTable >> printArgumentsForSpecOn: aStream [
	super printArgumentsForSpecOn: aStream.
	aStream
		nextPutAll: ' to ' ;
		nextPutAll: self targetSchema name
]
