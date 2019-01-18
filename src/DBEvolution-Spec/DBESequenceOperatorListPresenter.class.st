"
I present a DBESequenceCompositeOperator as a list.

The first element is the first operator to be applied chronologically.

Two fake items are added to be clear on what is the first operator to be run and what is the last.
"
Class {
	#name : #DBESequenceOperatorListPresenter,
	#superclass : #DBEListBasedPresenter,
	#category : #'DBEvolution-Spec'
}

{ #category : #specs }
DBESequenceOperatorListPresenter class >> defaultSpec [

	^ SpecLayout composed
		newColumn: [ :mainColumn |
			mainColumn
				newRow: #list ];
		yourself
]

{ #category : #adapting }
DBESequenceOperatorListPresenter >> adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator [
	self operators: aDBESequenceCompositeOperator sequenceOfOperatorsForSpecPresenter.
		
	self list backgroundColorBlock: [ :operator :index |
		(self list selectedItem isNotNil and: [ 
			self list selectedItem inducedOperators includes: operator ])
				ifTrue: [ Smalltalk ui theme backgroundColor lighter lighter ]
				ifFalse: [ Smalltalk ui theme backgroundColor ] ].
]

{ #category : #initialization }
DBESequenceOperatorListPresenter >> buildContextualMenu: builder [
	list selectedItem ifNil: [ ^ self ].
	list selectedItem supportsResolutionFromOperatorPresenter
		ifFalse: [ ^ self ].
	builder
		add: 'Resolve' target: list selectedItem selector: #resolveFromSequenceOperatorPresenter
]

{ #category : #api }
DBESequenceOperatorListPresenter >> incrementIndexSelected [
	"Useful when an operator is added before the operator selected in the list of operators to resolve."
	self list setSelectedIndex: ((self list selectedIndex + 1) min: self list listItems size)
]

{ #category : #initialization }
DBESequenceOperatorListPresenter >> initializeContextualMenu [
	list menu: [ :builder |
		self buildContextualMenu: builder.
		builder ]
]

{ #category : #initialization }
DBESequenceOperatorListPresenter >> initializeWidgets [
	super initializeWidgets.
	label
		label: 'Changes (chronological order)' translated;
		help: 'TODO'.

	list
		icons: [ :operator | operator statusIcon ].
		
	self initializeContextualMenu.
]

{ #category : #accessing }
DBESequenceOperatorListPresenter >> operators: aCollectionOfOperators [
	self list
		items: (Array streamContents: [ :s |
			s nextPut: DBEFakeOperator start.
			s nextPutAll: aCollectionOfOperators.
			s nextPut: DBEFakeOperator stop. ]).
]
