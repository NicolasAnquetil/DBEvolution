Class {
	#name : #DBEModifyViewQuery,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'view',
		'newQueryString'
	],
	#category : #'DBEvolution-Operators-View'
}

{ #category : #accessing }
DBEModifyViewQuery >> newQueryString [
	^ newQueryString
]

{ #category : #accessing }
DBEModifyViewQuery >> newQueryString: anObject [
	newQueryString := anObject
]

{ #category : #accessing }
DBEModifyViewQuery >> view [
	^ view
]

{ #category : #accessing }
DBEModifyViewQuery >> view: anObject [
	view := anObject
]
