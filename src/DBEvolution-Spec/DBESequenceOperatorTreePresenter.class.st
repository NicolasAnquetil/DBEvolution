"
I present a DBESequenceCompositeOperator as a tree.

Children of each node of the tree are the operators induced by the operator modeled by the node.
"
Class {
	#name : #DBESequenceOperatorTreePresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'tree'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #specs }
DBESequenceOperatorTreePresenter class >> defaultSpec [

	^ SpecLayout composed
		newColumn: [ :mainColumn |
			mainColumn
				newRow: #tree ];
		yourself
]

{ #category : #adapting }
DBESequenceOperatorTreePresenter >> adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator [
	self operators: aDBESequenceCompositeOperator sequenceOfOperators.
	
	self tree expandAll
]

{ #category : #events }
DBESequenceOperatorTreePresenter >> incrementIndexSelected [
	self flag: #TODO
]

{ #category : #initialization }
DBESequenceOperatorTreePresenter >> initializeWidgets [
	tree := self newTree.
	
	tree
		childrenBlock: [ :operator |
			operator recommandations
				select: #isOperatorChosen
				thenCollect: #operatorChosen ];
		displayBlock: [ :operator | operator asStringForSpec ]
]

{ #category : #accessing }
DBESequenceOperatorTreePresenter >> operators: aCollectionOfOperators [
	self tree
		roots: aCollectionOfOperators
]

{ #category : #accessing }
DBESequenceOperatorTreePresenter >> tree [
	^ tree
]

{ #category : #events }
DBESequenceOperatorTreePresenter >> whenSelectedItemChanged: aBlock ifUnselected: unselectedBlock [
	tree whenSelectedItemChanged: [ :item |
		item
			ifNil: [ unselectedBlock value ]
			ifNotNil: [ aBlock value: item ] ]
]
