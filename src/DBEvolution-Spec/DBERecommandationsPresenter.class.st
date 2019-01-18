"
I show the list of recommanded operators to solve the impact induced by an operator.
"
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
		items: aCollectionOfDBEOperators.
		
	aCollectionOfDBEOperators ifNotEmpty: [ 
		self list setSelectedIndex: 1 ]
]

{ #category : #initialization }
DBERecommandationsPresenter >> initializeWidgets [
	super initializeWidgets.
	label
		label: 'Recommandations' translated.
		
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
DBERecommandationsPresenter >> selectedOperator [
	^ self list selectedItem
]

{ #category : #accessing }
DBERecommandationsPresenter >> useOperatorButton [
	^ useOperatorButton
]

{ #category : #'as yet unclassified' }
DBERecommandationsPresenter >> useOperatorButtonAction: aBlock [
	self useOperatorButton
		action: [ aBlock value: self selectedOperator ]
]
