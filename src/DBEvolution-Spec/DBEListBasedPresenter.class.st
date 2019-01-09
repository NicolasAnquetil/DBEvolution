Class {
	#name : #DBEListBasedPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'list',
		'label'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #specs }
DBEListBasedPresenter class >> defaultSpec [

	^ SpecLayout composed
		newColumn: [ :mainColumn |
			mainColumn
				newRow: #label height: self labelHeight;
				newRow: #list ];
		yourself
]

{ #category : #initialization }
DBEListBasedPresenter >> initializeWidgets [
	label := self newLabel.
	list := self newIconList.
	list
		displayBlock: [ :operator | operator asStringForSpec ]
]

{ #category : #accessing }
DBEListBasedPresenter >> label [
	^ label
]

{ #category : #private }
DBEListBasedPresenter >> list [
	^ list
]

{ #category : #api }
DBEListBasedPresenter >> unselect [
	self list resetSelection
]

{ #category : #events }
DBEListBasedPresenter >> whenSelectedItemChanged: aBlock ifUnselected: unselectedBlock [
	"Wrap the api of the ListPresenter but manage correctly when nil is given as argument (nil is passed as argument by the API normally)."
	self list whenSelectedItemChanged: [ :selected |
		selected
			ifNotNil: [ aBlock value: selected ]
			ifNil: [ unselectedBlock value ] ]
]
