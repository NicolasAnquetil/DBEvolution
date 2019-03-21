Extension { #name : #DBERenameReference }

{ #category : #'*DBEvolution-Spec' }
DBERenameReference >> printArgumentsForSpecOn: aStream [
	aStream
		nextPutAll: self reference sourceText;
		nextPutAll: ' => ';
		nextPutAll: self newReferenceName
]
