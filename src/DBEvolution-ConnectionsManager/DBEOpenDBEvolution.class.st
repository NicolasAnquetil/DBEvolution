Class {
	#name : #DBEOpenDBEvolution,
	#superclass : #DBConnectionsManagerWidgetCommand,
	#category : #'DBEvolution-ConnectionsManager'
}

{ #category : #accessing }
DBEOpenDBEvolution class >> commandName [
	^ 'Open DB Evolution'
]

{ #category : #accessing }
DBEOpenDBEvolution class >> isForSingleConnection [
	^ true
]

{ #category : #accessing }
DBEOpenDBEvolution class >> menuCategory [
	^ #'DB Evolution'
]

{ #category : #accessing }
DBEOpenDBEvolution class >> weight [
	^ 0
]

{ #category : #execute }
DBEOpenDBEvolution >> execute [
	self flag: #TODO."Configure it with the model and DBEConnection corresponding to selected connection in connection manager."
	DBEEvolutionDescriber new
		openWithSpec
]
