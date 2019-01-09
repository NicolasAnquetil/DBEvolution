Class {
	#name : #DBERecommandationsGenerator,
	#superclass : #Object,
	#instVars : [
		'impacts'
	],
	#category : #'DBEvolution-Core'
}

{ #category : #'instance creation' }
DBERecommandationsGenerator class >> impacts: aCollectionOfDBEImpactFilters [
	^ self new
		impacts: aCollectionOfDBEImpactFilters;
		yourself
]

{ #category : #recommandations }
DBERecommandationsGenerator >> generateRecommandationsFor: maximalImpactSet database: aDBEDatabase [
	"Generates the recommandations (i.e. operators to apply) for the entities in the maximalImpactSet."
	^ maximalImpactSet
		inject: OrderedCollection new
		into: [ :col :entity |
			self impacts
				detect: [ :filter | filter matchesEntity: entity inDatabase: aDBEDatabase ]
				ifFound: [ :foundFilter | col add: (entity -> (foundFilter recommandationsFor: entity)) ].
			col ]
]

{ #category : #accessing }
DBERecommandationsGenerator >> impacts [
	^ impacts
]

{ #category : #accessing }
DBERecommandationsGenerator >> impacts: anObject [
	impacts := anObject
]

{ #category : #testing }
DBERecommandationsGenerator >> isEmpty [
	^ self impacts isEmpty
]

{ #category : #testing }
DBERecommandationsGenerator >> isNotEmpty [
	^ self isEmpty not
]
