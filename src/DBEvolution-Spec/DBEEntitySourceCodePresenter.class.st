"
I present the source code of the entity currently selected in the list of entities impacted by the operator being resolved.
"
Class {
	#name : #DBEEntitySourceCodePresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'label',
		'text'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #specs }
DBEEntitySourceCodePresenter class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :mainColumn | 
			mainColumn
				newRow: #label height: self labelHeight;
				newRow: #text ];
		yourself
]

{ #category : #adapting }
DBEEntitySourceCodePresenter >> adaptToFmxSQLReference: aFmxSQLReference [
	aFmxSQLReference sourceAnchor
		ifNotNil: [ :anchor |
			self text
				text: anchor entity sourceCodeAsText;
				setSelection: (anchor start to: anchor end)
		]
		ifNil: [
			self text
				text: (self generateCodeForEntity: aFmxSQLReference sourcedBelonger)
		].

]

{ #category : #adapting }
DBEEntitySourceCodePresenter >> generateCodeForEntity: aTable [
	^String streamContents: [ :stream |
		stream
			<< (aTable name) ;
			<< '('.
		aTable columns do: [ :c | stream << c name ] separatedBy: [ stream << ', ' ]. 
		stream
			<< ')' ;
			cr
	]

]

{ #category : #initialization }
DBEEntitySourceCodePresenter >> initializeWidgets [
	label := self newLabel.
	label
		label: 'Source code:'.
	text := self newText.
	text
		enabled: false
]

{ #category : #accessing }
DBEEntitySourceCodePresenter >> label [
	^ label
]

{ #category : #resetting }
DBEEntitySourceCodePresenter >> reset [
	text text: ''
]

{ #category : #accessing }
DBEEntitySourceCodePresenter >> text [
	^ text
]
