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

{ #category : #accessing }
DBEImpactFilter >> recommandations [
	^ recommandations
]

{ #category : #accessing }
DBEImpactFilter >> recommandations: anObject [
	recommandations := anObject
]
