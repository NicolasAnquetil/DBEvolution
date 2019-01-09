Extension { #name : #DBECompositeOperator }

{ #category : #'*DBEvolution-Spec' }
DBECompositeOperator >> bePresentedBy: aDBEOperatorPresenter [
	aDBEOperatorPresenter adaptToDBECompositeOperator: self
]
