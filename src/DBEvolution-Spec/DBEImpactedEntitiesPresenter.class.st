Class {
	#name : #DBEImpactedEntitiesPresenter,
	#superclass : #DBEListBasedPresenter,
	#category : #'DBEvolution-Spec'
}

{ #category : #adapting }
DBEImpactedEntitiesPresenter >> adaptToCollectionOfDBERecommandations: aCollectionOfDBERecommandations [
	self list
		items: aCollectionOfDBERecommandations
]

{ #category : #initialization }
DBEImpactedEntitiesPresenter >> initializeWidgets [
	super initializeWidgets.
	label
		label: 'Impacted entities:' translated.
		
	list := self newIconList.
	list
		icons: [ :operator | operator statusIcon ]
]
