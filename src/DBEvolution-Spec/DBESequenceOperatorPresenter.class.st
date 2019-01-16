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
						label: aString
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
