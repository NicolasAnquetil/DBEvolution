Extension { #name : #DBERemoveColumn }

{ #category : #'*DBEvolution-Spec' }
DBERemoveColumn >> printArgumentsForSpecOn: aStream [
	aStream
		nextPutAll: self targetColumn name
]
