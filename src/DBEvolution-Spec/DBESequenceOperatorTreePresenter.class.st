"
I present a DBESequenceCompositeOperator as a tree.

Children of each node of the tree are the operators induced by the operator modeled by the node.
"
Class {
	#name : #DBESequenceOperatorTreePresenter,
	#superclass : #DBETreeBasedPresenter,
	#category : #'DBEvolution-Spec'
}

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
	super initializeWidgets.
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
