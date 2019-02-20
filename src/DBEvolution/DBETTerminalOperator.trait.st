Trait {
	#name : #DBETTerminalOperator,
	#category : #'DBEvolution-Traits'
}

{ #category : #testing }
DBETTerminalOperator >> isResolved [
	^ true
]

{ #category : #accessing }
DBETTerminalOperator >> maximalImpactSet [
	^ self shouldNotImplement
]

{ #category : #accessing }
DBETTerminalOperator >> recommandations [
	^ #()
]

{ #category : #accessing }
DBETTerminalOperator >> recommandationsGenerator [
	^ self shouldNotImplement
]
