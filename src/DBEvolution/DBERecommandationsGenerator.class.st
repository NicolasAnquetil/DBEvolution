"
I am the object allowing to generate recommandations for an entity in a database.

I hold a collection of asDBEImpactFilters. Those are used in the computation of recommandations in the method #generateRecommandationsFor:database:.
"
Class {
	#name : #DBERecommandationsGenerator,
	#superclass : #Object,
	#instVars : [
		'impacts'
	],
	#category : #'DBEvolution-Core'
}

{ #category : #'instance creation' }
DBERecommandationsGenerator class >> filters: aCollectionOfDBEImpactFilters [
	^ self new
		filters: aCollectionOfDBEImpactFilters;
		yourself
]

{ #category : #accessing }
DBERecommandationsGenerator >> filters [
	^ impacts
]

{ #category : #accessing }
DBERecommandationsGenerator >> filters: anObject [
	impacts := anObject
]

{ #category : #recommandations }
DBERecommandationsGenerator >> generateRecommandationsFor: maximalImpactSet database: aDBEDatabase [
	"Generates the recommandations (i.e. operators to apply) for the entities in the maximalImpactSet."
	^ maximalImpactSet
		inject: OrderedCollection new
		into: [ :col :reference |
			self filters
				detect: [ :filter | filter matchesEntity: reference inDatabase: aDBEDatabase ]
				ifFound: [ :foundFilter | 
					col add: (DBERecommandation entity: reference operators: (foundFilter recommandationsFor: reference)) ]
				ifNone: [ 
					DBENoFilterMatchesEntityError signalEntity: reference ].
			col ]
]

{ #category : #testing }
DBERecommandationsGenerator >> isEmpty [
	^ self filters isEmpty
]

{ #category : #testing }
DBERecommandationsGenerator >> isNotEmpty [
	^ self isEmpty not
]
