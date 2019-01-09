Extension { #name : #DBEAtomicOperator }

{ #category : #'*DBEvolution-Spec' }
DBEAtomicOperator >> bePresentedBy: aDBEOperatorPresenter [
	aDBEOperatorPresenter adaptToDBEAtomicOperator: self
]
