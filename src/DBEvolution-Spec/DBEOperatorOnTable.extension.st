Extension { #name : #DBEOperatorOnTable }

{ #category : #'*DBEvolution-Spec' }
DBEOperatorOnTable >> printArgumentsForSpecOn: aStream [
	super printArgumentsForSpecOn: aStream.
	aStream
		nextPutAll: self targetTable name
]
