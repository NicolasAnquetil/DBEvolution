Extension { #name : #DBERemoveNotNullConstraint }

{ #category : #'*DBEvolution-Spec' }
DBERemoveNotNullConstraint >> printArgumentsForSpecOn: aStream [
	aStream
		nextPutAll: self column name
]
