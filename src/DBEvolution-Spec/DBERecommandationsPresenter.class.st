Class {
	#name : #DBERecommandationsPresenter,
	#superclass : #DBEListBasedPresenter,
	#instVars : [
		'useOperatorButton'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #specs }
DBERecommandationsPresenter class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :mainColumn |
			mainColumn
				newRow: #label height: self labelHeight;
				newRow: #list;
				newRow: #useOperatorButton height: self buttonHeight ];
		yourself
]

{ #category : #adapting }
DBERecommandationsPresenter >> adaptToCollectionOfDBEOperators: aCollectionOfDBEOperators [
	self list
		items: aCollectionOfDBEOperators
]

{ #category : #initialization }
DBERecommandationsPresenter >> initializeWidgets [
	super initializeWidgets.
	label
		label: 'Recommandations:' translated.
		
	list
		icons: [ :recommandation | recommandation recommandationIcon ].
		
	useOperatorButton := self newButton.
	useOperatorButton
		label: 'Use this operator' translated;
		enabled: false.
		
	self
		whenSelectedItemChanged: [ :operatorSelected |
			self useOperatorButton enabled: true ]
		ifUnselected: [ self useOperatorButton enabled: false ]
]

{ #category : #accessing }
DBERecommandationsPresenter >> useOperatorButton [
	^ useOperatorButton
]
