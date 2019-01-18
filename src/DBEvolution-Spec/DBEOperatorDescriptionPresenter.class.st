"
I present additional data about the operator actually selected in the recommandation panel.
"
Class {
	#name : #DBEOperatorDescriptionPresenter,
	#superclass : #ComposablePresenter,
	#instVars : [
		'documentationLabel',
		'documentationText',
		'developerCommentLabel',
		'developerCommentText',
		'whenDeveloperCommentIsUpdated'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #specs }
DBEOperatorDescriptionPresenter class >> defaultSpec [

	^ SpecLayout composed
		newColumn: [ :mainColumn|
			mainColumn
				newRow: [ :row |
					row
						newColumn: #documentationLabel width: (self defaultFont widthOfString: self documentationLabelString);
						newColumn: #documentationText ] height: self labelHeight;
				newRow: #developerCommentLabel height: self labelHeight;
				newRow: #developerCommentText ];
		yourself
]

{ #category : #'as yet unclassified' }
DBEOperatorDescriptionPresenter class >> documentationLabelString [
	^ 'Documentation:'
]

{ #category : #adapting }
DBEOperatorDescriptionPresenter >> adaptToDBEOperator: aDBEOperator [
	self documentationText
		label: aDBEOperator documentation.
	
	self developerCommentText
		text: aDBEOperator developerComment.
		
	self whenDeveloperCommentIsUpdated: [ :text |
			aDBEOperator developerComment: text ].
]

{ #category : #accessing }
DBEOperatorDescriptionPresenter >> developerCommentLabel [
	^ developerCommentLabel
]

{ #category : #accessing }
DBEOperatorDescriptionPresenter >> developerCommentText [
	^ developerCommentText
]

{ #category : #accessing }
DBEOperatorDescriptionPresenter >> documentationLabel [
	^ documentationLabel
]

{ #category : #accessing }
DBEOperatorDescriptionPresenter >> documentationText [
	^ documentationText
]

{ #category : #initialization }
DBEOperatorDescriptionPresenter >> initializeWidgets [
	documentationLabel := self newLabel.
	documentationLabel label: self class documentationLabelString translated.
	
	documentationText := self newLabel.
	
	developerCommentLabel := self newLabel.
	developerCommentLabel label: 'Comment:'.
	
	self whenDeveloperCommentIsUpdated: [ :text | ].
	
	developerCommentText := self newText.
	developerCommentText
		whenTextIsAccepted: [ :text |
			self updateDeveloperComment: text ]
]

{ #category : #adapting }
DBEOperatorDescriptionPresenter >> updateDeveloperComment: text [
	whenDeveloperCommentIsUpdated value: text
]

{ #category : #accessing }
DBEOperatorDescriptionPresenter >> whenDeveloperCommentIsUpdated [
	^ whenDeveloperCommentIsUpdated
]

{ #category : #accessing }
DBEOperatorDescriptionPresenter >> whenDeveloperCommentIsUpdated: anObject [
	whenDeveloperCommentIsUpdated := anObject
]
