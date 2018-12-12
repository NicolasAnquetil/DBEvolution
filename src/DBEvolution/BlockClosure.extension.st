Extension { #name : #BlockClosure }

{ #category : #'*DBEvolution' }
BlockClosure >> asDBEImpactFilter [
	^ DBEImpactFilter filterBlock: self
]
