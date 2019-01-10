Extension { #name : #DBEHumanIntervention }

{ #category : #'*DBEvolution-Spec' }
DBEHumanIntervention >> resolveFromSequenceOperatorPresenter [
	self flag: #TODO.
	self inspect
]

{ #category : #'*DBEvolution-Spec' }
DBEHumanIntervention >> supportsResolutionFromOperatorPresenter [
	^ true
]
