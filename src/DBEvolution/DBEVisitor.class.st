Class {
	#name : #DBEVisitor,
	#superclass : #Object,
	#category : #'DBEvolution-Visitors'
}

{ #category : #visiting }
DBEVisitor >> visitDBEOperator: aDBEOperator [
	^ self subclassResponsibility
]

{ #category : #visiting }
DBEVisitor >> visitDBERecommandation: aDBERecommandation [
	^ self subclassResponsibility
]
