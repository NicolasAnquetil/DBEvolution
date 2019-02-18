Class {
	#name : #DBETreeBasedPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'tree'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #specs }
DBETreeBasedPresenter class >> defaultSpec [

	^ SpecLayout composed
		newColumn: [ :mainColumn |
			mainColumn
				newRow: #tree ];
		yourself
]

{ #category : #initialization }
DBETreeBasedPresenter >> initializeWidgets [
	tree := self newTree.
]

{ #category : #accessing }
DBETreeBasedPresenter >> refresh [
	|selected|
	selected := self tree selectedItem.
	self tree updateTree.
	selected ifNotNil: [ 
		self tree selectedItem: selected ]
]

{ #category : #accessing }
DBETreeBasedPresenter >> tree [
	^ tree
]

{ #category : #events }
DBETreeBasedPresenter >> unselect [
	self tree selectedItems: #()
]

{ #category : #events }
DBETreeBasedPresenter >> whenSelectedItemChanged: aBlock ifUnselected: unselectedBlock [
	tree whenSelectedItemChanged: [ :item |
		item
			ifNil: [ unselectedBlock value ]
			ifNotNil: [ aBlock value: item ] ]
]
