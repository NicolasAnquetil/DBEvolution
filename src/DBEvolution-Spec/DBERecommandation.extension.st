Extension { #name : #DBERecommandation }

{ #category : #'*DBEvolution-Spec' }
DBERecommandation >> asStringForSpec [
	^ String streamContents: [ :s |
		s
			nextPutAll: (self entity class asStringForSpec).
		self entity name ifNotNil: [
			s
				nextPut: Character space;
				nextPutAll: self entity name ] ]
]

{ #category : #'*DBEvolution-Spec' }
DBERecommandation >> statusIcon [
	^ self isOperatorChosen
			ifTrue: [ Smalltalk ui icons iconNamed: #glamorousAccept ]
			ifFalse: [ Smalltalk ui icons iconNamed: #configuration ]
]
