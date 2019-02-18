Extension { #name : #DBEHumanIntervention }

{ #category : #'*DBEvolution-Spec' }
DBEHumanIntervention >> printArgumentsForSpecOn: aStream [
	aStream
		nextPutAll: self entity dbeNameForUI
]

{ #category : #'*DBEvolution-Spec' }
DBEHumanIntervention >> resolveFromSequenceOperatorPresenter [
	self flag: #TODO.
	self inspect
]

{ #category : #'*DBEvolution-Spec' }
DBEHumanIntervention >> supportsResolutionFromOperatorPresenter [
	^ true
]
