Extension { #name : #DBERemoveNamedConstraint }

{ #category : #'*DBEvolution-Spec' }
DBERemoveNamedConstraint >> printArgumentsForSpecOn: aStream [
	aStream
		nextPutAll: self constraint name
]
