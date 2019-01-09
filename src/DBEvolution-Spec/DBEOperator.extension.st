Extension { #name : #DBEOperator }

{ #category : #'*DBEvolution-Spec' }
DBEOperator >> bePresentedBy: aDBEOperatorPresenter [
	self subclassResponsibility
]

{ #category : #'*DBEvolution-Spec' }
DBEOperator >> statusIcon [
	^ self isResolved
			ifTrue: [ Smalltalk ui icons iconNamed: #glamorousAccept ]
			ifFalse: [ Smalltalk ui icons iconNamed: #configuration ]
]
