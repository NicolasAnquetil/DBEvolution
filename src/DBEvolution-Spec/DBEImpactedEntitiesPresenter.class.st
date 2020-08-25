"
I show the list of entities impacted by an operator.
"
Class {
	#name : #DBEImpactedEntitiesPresenter,
	#superclass : #DBETreeBasedPresenter,
	#instVars : [
		'label'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #adapting }
DBEImpactedEntitiesPresenter >> adaptToCollectionOfDBERecommandations: aCollectionOfDBERecommandations [
	| associations |
	associations := self groupByEntity: aCollectionOfDBERecommandations.
	self tree
		roots: associations;
		childrenBlock: [ :object |
			object class = Association
				ifTrue: [ object value ]
				ifFalse: [ #() ] ];
		displayBlock: [ :object |
			object class = Association
				ifTrue: [ object key asStringForSpec ]
				ifFalse: [object entity asStringForSpec ] ]
]

{ #category : #adapting }
DBEImpactedEntitiesPresenter >> groupByEntity: aCollectionOfDBERecommandations [
	| grouped |
	grouped := (aCollectionOfDBERecommandations groupedBy: [ :recommandation | 
					recommandation entity sourcedBelonger ]) associations.
	grouped sort: [ :assoc | assoc key name ] asSortFunction.
	^grouped collect: [ :assoc |
		assoc key -> (assoc value sorted: [ :reco | reco entity sourceAnchor start ] asSortFunction) ].
]

{ #category : #initialization }
DBEImpactedEntitiesPresenter >> initializeWidgets [
	| backupTreeIconBlock |
	super initializeWidgets.
	label := self newLabel.
	label
		label: 'Impact' translated.
	backupTreeIconBlock := tree iconBlock.
	tree
		iconBlock: [ :object :node | 
			object class = Association
				ifTrue: [ 
					"backupTreeIconBlock value: object value: node"
					(object value allSatisfy: #isOperatorChosen)
						ifTrue: [ (object value detect: #isOperatorChosen) statusIcon ]
						ifFalse: [ (object value detect: [ :op | op isOperatorChosen not ]) statusIcon ] ]
				ifFalse: [ object statusIcon ] ]
]

{ #category : #accessing }
DBEImpactedEntitiesPresenter >> label [
	^ label
]

{ #category : #accessing }
DBEImpactedEntitiesPresenter >> selectedRecommandation [
	^ self tree selectedItem content
]

{ #category : #events }
DBEImpactedEntitiesPresenter >> whenSelectedItemChanged: aBlock ifUnselected: unselectedBlock [
	tree whenSelectedItemChanged: [ :item |
		item class = Association
			ifFalse: [
				item
					ifNil: [ unselectedBlock value ]
					ifNotNil: [ aBlock value: item ] ] ]
]
