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
	associations := (aCollectionOfDBERecommandations groupedBy: [ :recommandation | 
					recommandation entity sourceAnchorOrReferenceGroupSourceAnchor
						ifNotNil: #entity
						ifNil: [ recommandation entity ] ]) associations.
	associations sort: [ :assoc | assoc key name ] asSortFunction.
	associations := associations collect: [ :assoc |
		assoc key -> (assoc value sorted: [ :reco | reco entity sourceAnchor start ] asSortFunction) ].
	self tree
		roots: associations;
		childrenBlock: [ :object |
			object class = Association
				ifTrue: [ object value ]
				ifFalse: [ #() ] ];
		displayBlock: [ :object |
			object class = Association
				ifTrue: [ object key className ,' ', object key name ]
				ifFalse: [ object asStringForSpec ] ]
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
				ifTrue: [ backupTreeIconBlock value: object value: node ]
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
