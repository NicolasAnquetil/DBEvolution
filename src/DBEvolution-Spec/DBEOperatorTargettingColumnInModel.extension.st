Extension { #name : #DBEOperatorTargettingColumnInModel }

{ #category : #'*DBEvolution-Spec' }
DBEOperatorTargettingColumnInModel >> printArgumentsForSpecOn: aStream [
	aStream
		nextPutAll: self targetColumn asStringForSpec
]
