Class {
	#name : #DBESequenceOperatorPresenter,
	#superclass : #DBEListBasedPresenter,
	#category : #'DBEvolution-Spec'
}

{ #category : #adapting }
DBESequenceOperatorPresenter >> adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator [
	self list
		items: aDBESequenceCompositeOperator sequenceOfOperatorsForSpecPresenter
]

{ #category : #initialization }
DBESequenceOperatorPresenter >> buildContextualMenu: builder [
	list selectedItem ifNil: [ ^ self ].
	list selectedItem supportsResolutionFromOperatorPresenter
		ifFalse: [ ^ self ].
	builder
		add: 'Resolve' target: list selectedItem selector: #resolveFromSequenceOperatorPresenter
]

{ #category : #initialization }
DBESequenceOperatorPresenter >> initializeContextualMenu [
	list menu: [ :builder |
		self buildContextualMenu: builder.
		builder ]
]

{ #category : #initialization }
DBESequenceOperatorPresenter >> initializeWidgets [
	super initializeWidgets.
	label
		label: 'Changes (chronological order)' translated;
		help: 'TODO'.

	list
		icons: [ :operator | operator statusIcon ].
		
	self initializeContextualMenu.
]
