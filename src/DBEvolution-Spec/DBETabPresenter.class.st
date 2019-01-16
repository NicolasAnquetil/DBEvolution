Class {
	#name : #DBETabPresenter,
	#superclass : #TabPresenter,
	#category : #'DBEvolution-Spec'
}

{ #category : #api }
DBETabPresenter >> presenter: aComposablePresenter [
	aComposablePresenter owner: self.
	self retrievingBlock: [ 
		aComposablePresenter buildWithSpec
			color: Smalltalk ui theme backgroundColor;
			yourself ]
]
