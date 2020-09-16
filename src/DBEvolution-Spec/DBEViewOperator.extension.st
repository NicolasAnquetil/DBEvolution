Extension { #name : #DBEViewOperator }

{ #category : #'*DBEvolution-Spec' }
DBEViewOperator >> printArgumentsForSpecOn: aStream [
	super printArgumentsForSpecOn: aStream.
	aStream
		nextPutAll: self view name
]
