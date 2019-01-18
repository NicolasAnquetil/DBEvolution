"
I present a DBESequenceCompositeOperator under various aspects.

Concretely, each aspects is a tab of the widget. If the tab is clicked it shows view on the widget.

By default, the operator is shown as a chronological list and a tree.
"
Class {
	#name : #DBESequenceOperatorPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'tabsManager',
		'operatorPresenters'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #specs }
DBESequenceOperatorPresenter class >> defaultSpec [

	^ SpecLayout composed
		newColumn: [ :mainColumn |
			mainColumn
				newRow: #tabsManager ];
		yourself
]

{ #category : #adapting }
DBESequenceOperatorPresenter >> adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator [
	operatorPresenters do: [ :presenter |
		presenter adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator ]
]

{ #category : #adding }
DBESequenceOperatorPresenter >> addOperatorPresenter: aComposablePresenter labelled: aString [
	operatorPresenters add: aComposablePresenter.
	self tabsManager
		addTab: (DBETabPresenter new
						presenter: aComposablePresenter;
						label: aString;
						closeable: false;
						yourself)
]

{ #category : #events }
DBESequenceOperatorPresenter >> incrementIndexSelected [
	operatorPresenters do: [ :presenter |
		presenter incrementIndexSelected ]
]

{ #category : #initialization }
DBESequenceOperatorPresenter >> initializeWidgets [
	
	tabsManager := self newTabManager.
	operatorPresenters := OrderedCollection new.
	self
		addOperatorPresenter: DBESequenceOperatorListPresenter new labelled: 'Patch';
		addOperatorPresenter: DBESequenceOperatorTreePresenter new labelled: 'Impact Tree'
]

{ #category : #accessing }
DBESequenceOperatorPresenter >> tabsManager [
	^ tabsManager
]

{ #category : #events }
DBESequenceOperatorPresenter >> whenSelectedItemChanged: aBlock ifUnselected: unselectedBlock [
	operatorPresenters do: [ :presenter |
		presenter whenSelectedItemChanged: aBlock ifUnselected: unselectedBlock ]
]
