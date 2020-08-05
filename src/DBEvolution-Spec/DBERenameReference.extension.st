Extension { #name : #DBERenameReference }

{ #category : #'*DBEvolution-Spec' }
DBERenameReference >> printArgumentsForSpecOn: aStream [
	aStream
		nextPutAll: self reference sourceAnchor entity sourceCodeAsText;
		nextPutAll: ' => ';
		nextPutAll: self newReferenceName
]
