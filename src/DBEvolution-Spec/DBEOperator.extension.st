Extension { #name : #DBEOperator }

{ #category : #'*DBEvolution-Spec' }
DBEOperator >> asStringForSpec [
	^ String streamContents: [ :s |
		s
			nextPutAll: self nameForSpec;
			nextPut: $(.
		self printArgumentsForSpecOn: s.
		s
			nextPut: $). ]
]

{ #category : #'*DBEvolution-Spec' }
DBEOperator >> nameForSpec [
	"Just remove the prefix, might be overriden in subclasses."
	^ self className allButFirst: 'DBE' size
]

{ #category : #'*DBEvolution-Spec' }
DBEOperator >> printArgumentsForSpecOn: aStream [
	"To be overriden by subclasses to print a proper String representation of the operator arguments."
]

{ #category : #'*DBEvolution-Spec' }
DBEOperator >> recommandationIcon [
	"Icon displayed in the recommandation list of the UI when the operator is presented as a potential solution to make the DB evolve."
	^ Smalltalk ui icons iconNamed: #blank
]

{ #category : #'*DBEvolution-Spec' }
DBEOperator >> resolveFromSequenceOperatorPresenter [
	self subclassResponsibility
]

{ #category : #'*DBEvolution-Spec' }
DBEOperator >> statusIcon [
	"Icon displayed in the UI to show the status of the operator application."
	^ self isResolved
			ifTrue: [ Smalltalk ui icons iconNamed: #glamorousAccept ]
			ifFalse: [ Smalltalk ui icons iconNamed: #configuration ]
]

{ #category : #'*DBEvolution-Spec' }
DBEOperator >> supportsResolutionFromOperatorPresenter [
	^ false
]
