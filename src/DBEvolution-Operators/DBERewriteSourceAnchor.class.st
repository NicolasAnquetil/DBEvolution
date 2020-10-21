Class {
	#name : #DBERewriteSourceAnchor,
	#superclass : #DBEAtomicOperator,
	#traits : 'DBETTerminalOperator',
	#classTraits : 'DBETTerminalOperator classTrait',
	#instVars : [
		'sourceAnchor',
		'newContent'
	],
	#category : #'DBEvolution-Operators-References'
}

{ #category : #'as yet unclassified' }
DBERewriteSourceAnchor class >> sourceAnchor: sourceAnchor newContent: aString [
	^ self new
		sourceAnchor: sourceAnchor;
		newContent: aString;
		yourself
]

{ #category : #testing }
DBERewriteSourceAnchor >> isRenameReference [
	^ true
]

{ #category : #accessing }
DBERewriteSourceAnchor >> newContent [
	^ newContent
]

{ #category : #accessing }
DBERewriteSourceAnchor >> newContent: anObject [
	newContent := anObject
]

{ #category : #accessing }
DBERewriteSourceAnchor >> newReferenceName [
	"To be polymorphic with DBERenameReference."
	^ self newContent
]

{ #category : #accessing }
DBERewriteSourceAnchor >> sourceAnchor [
	^ sourceAnchor
]

{ #category : #accessing }
DBERewriteSourceAnchor >> sourceAnchor: anObject [
	sourceAnchor := anObject
]

{ #category : #accessing }
DBERewriteSourceAnchor >> sourcedBelonger [
	self flag: '#sourcedBelonger are mostly implemented by entities (ex: FmxSQLCRUDQuery) except operators that #isRenameReference. why?'.
	^ self sourceAnchor entity
]

{ #category : #accessing }
DBERewriteSourceAnchor >> start [
	^ self sourceAnchor start
]

{ #category : #accessing }
DBERewriteSourceAnchor >> stop [
	^ self sourceAnchor end
]
