Class {
	#name : #DBESequenceOperatorPresenter,
	#superclass : #DBEListBasedPresenter,
	#category : #'DBEvolution-Spec'
}

{ #category : #adapting }
DBESequenceOperatorPresenter >> adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator [
	self list
		items: aDBESequenceCompositeOperator sequenceOfOperators
]

{ #category : #initialization }
DBESequenceOperatorPresenter >> initializeWidgets [
	super initializeWidgets.
	label
		label: 'Changes:' translated.

	list := self newIconList.
	list
		icons: [ :operator | operator statusIcon ]
]
