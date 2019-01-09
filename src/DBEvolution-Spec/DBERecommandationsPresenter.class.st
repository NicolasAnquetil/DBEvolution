Class {
	#name : #DBERecommandationsPresenter,
	#superclass : #DBEListBasedPresenter,
	#category : #'DBEvolution-Spec'
}

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
		
	list := self newIconList.
	list
		icons: [ :operator | operator statusIcon ]
]
