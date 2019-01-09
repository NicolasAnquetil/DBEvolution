"
I am a filter for the maximal impact set of an entity.

I use my #filterBlock to select entities for which I can provide recommandations.

If an entity matches my filter block, one can call my #recommandationsFor: message with then entity as argument to get recommandations for it.
"
Class {
	#name : #DBEImpactFilter,
	#superclass : #Object,
	#instVars : [
		'filterBlock',
		'recommandations'
	],
	#category : #'DBEvolution-Core'
}

{ #category : #'instance creation' }
DBEImpactFilter class >> any [
	^ self filterBlock: [ :entity :model :database | true ]
]

{ #category : #'instance creation' }
DBEImpactFilter class >> filterBlock: aBlockClosure [
	^ self new
		filterBlock: aBlockClosure;
		yourself
]

{ #category : #associating }
DBEImpactFilter >> -> aCollectionOfDBEOperators [
	"Syntax sugar for #recommandations.
	In combination with #asDBEImpactFilter, it allows to write this kind of code:
		[ :entity :model :database | model isColumn: entity ] asDBEImpactFilter -> { DBERemoveColumn }"
	self recommandations: aCollectionOfDBEOperators
]

{ #category : #accessing }
DBEImpactFilter >> filterBlock [
	^ filterBlock
]

{ #category : #accessing }
DBEImpactFilter >> filterBlock: anObject [
	filterBlock := anObject
]

{ #category : #initialization }
DBEImpactFilter >> initialize [
	super initialize.
	self recommandations: { }
]

{ #category : #testing }
DBEImpactFilter >> matchesEntity: anEntity inDatabase: aDBEDatabase [
	^ self filterBlock value: anEntity value: aDBEDatabase
]

{ #category : #accessing }
DBEImpactFilter >> recommandations [
	^ recommandations
]

{ #category : #accessing }
DBEImpactFilter >> recommandations: anObject [
	recommandations := anObject
]

{ #category : #'as yet unclassified' }
DBEImpactFilter >> recommandationsFor: anEntity [
	^ self recommandations collect: [ :block |
		block value: anEntity ]
]
