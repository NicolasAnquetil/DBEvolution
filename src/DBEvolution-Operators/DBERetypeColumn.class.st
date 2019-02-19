Class {
	#name : #DBERetypeColumn,
	#superclass : #DBEOperatorTargettingColumnInModel,
	#category : #'DBEvolution-Operators-Column'
}

{ #category : #accessing }
DBERetypeColumn >> templateArgumentsDictionary [
	"Returns a Dictionary containing the values to be substituted in the template."
	^ self subclassResponsibility
]
