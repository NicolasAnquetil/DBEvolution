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
		label: 'Impact' translated.
		
	list
		icons: [ :operator | operator statusIcon ]
]

{ #category : #accessing }
DBEImpactedEntitiesPresenter >> selectedRecommandation [
	^ self list selectedItem
]
