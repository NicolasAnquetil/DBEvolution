Class {
	#name : #DBEImpactAndRecommandations,
	#superclass : #Object,
	#instVars : [
		'impacts'
	],
	#category : #'DBEvolution-Core'
}

{ #category : #'instance creation' }
DBEImpactAndRecommandations class >> impacts: aCollectionOfDBEImpactFilters [
	^ self new
		impacts: aCollectionOfDBEImpactFilters;
		yourself
]

{ #category : #accessing }
DBEImpactAndRecommandations >> impacts [
	^ impacts
]

{ #category : #accessing }
DBEImpactAndRecommandations >> impacts: anObject [
	impacts := anObject
]

{ #category : #testing }
DBEImpactAndRecommandations >> isEmpty [
	^ self impacts isEmpty
]

{ #category : #testing }
DBEImpactAndRecommandations >> isNotEmpty [
	^ self isEmpty not
]
