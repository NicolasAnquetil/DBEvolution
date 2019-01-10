Extension { #name : #DBESequenceCompositeOperator }

{ #category : #'*DBEvolution-Spec' }
DBESequenceCompositeOperator >> sequenceOfOperatorsForSpecPresenter [
	"Provide sequence of operators to which is added the induced operators flattened."
	^ self allOperators
]
