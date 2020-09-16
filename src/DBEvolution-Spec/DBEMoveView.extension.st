Extension { #name : #DBEMoveView }

{ #category : #'*DBEvolution-Spec' }
DBEMoveView >> printArgumentsForSpecOn: aStream [
	super printArgumentsForSpecOn: aStream.
	aStream
		nextPutAll: self view name ;
		nextPutAll: '->' ;
		nextPutAll: self targetSchema name
]
