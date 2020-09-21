"
I am the main widget to let a developer describe the evolution of a DB.
"
Class {
	#name : #DBEEvolutionDescriber,
	#superclass : #ComposablePresenter,
	#instVars : [
		'sequenceOperatorPresenter',
		'impactedEntitiesPresenter',
		'recommandationsPresenter',
		'entitySourceCodePresenter',
		'operatorDescriptionPresenter',
		'menu',
		'operator'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #specs }
DBEEvolutionDescriber class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :mainColumn | 
			mainColumn
				newRow: #menu height: self toolbarHeight;
				newRow: [ :mainRow | 
					mainRow
						newColumn: #sequenceOperatorPresenter;
						newColumn: #impactedEntitiesPresenter;
						newColumn: #recommandationsPresenter ];
				addSplitter;
				newRow: [ :bottomRow |
					bottomRow
						newColumn: #entitySourceCodePresenter";
						newColumn: #operatorDescriptionPresenter" ] ];
		yourself
]

{ #category : #adapting }
DBEEvolutionDescriber >> adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator [
	operator := aDBESequenceCompositeOperator.
	self sequenceOperatorPresenter
		whenSelectedItemChanged: [ :operatorSelected|
			self impactedEntitiesPresenter
				unselect;
				adaptToCollectionOfDBERecommandations: operatorSelected recommandations ]
		ifUnselected: [ 
			self impactedEntitiesPresenter
				unselect;
				adaptToCollectionOfDBERecommandations: #() ].
	
	self impactedEntitiesPresenter 
		whenSelectedItemChanged: [ :selectedDBERecommandation |
			self recommandationsPresenter
				unselect;
				adaptToCollectionOfDBEOperators: selectedDBERecommandation operators.
			self entitySourceCodePresenter
				adaptToFmxSQLReference: selectedDBERecommandation entity ]
		ifUnselected: [
			self recommandationsPresenter
				unselect;
				adaptToCollectionOfDBEOperators: #() ].
	
	self recommandationsPresenter
		whenSelectedItemChanged: [ :operatorSelected |
			self operatorDescriptionPresenter adaptToDBEOperator: operatorSelected ]
		ifUnselected: [ 
			self operatorDescriptionPresenter reset ].
			
	self recommandationsPresenter
		useOperatorButtonAction: [ :operatorSelected |
			self impactedEntitiesPresenter selectedRecommandation
				operatorChosen: operatorSelected.
			self sequenceOperatorPresenter
				adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator.
			self impactedEntitiesPresenter refresh.
			self sequenceOperatorPresenter incrementIndexSelected ].
	
	self sequenceOperatorPresenter
		adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator
]

{ #category : #accessing }
DBEEvolutionDescriber >> entitySourceCodePresenter [
	^ entitySourceCodePresenter
]

{ #category : #api }
DBEEvolutionDescriber >> extent [
	^ 1200 @ 800
]

{ #category : #action }
DBEEvolutionDescriber >> generatePatchAndInspect [
	| operators |
	operators := DBEPatchGenerator new
		operators: (operator sequenceOfOperators flatCollect: #allOperators);
		run;
		operators.
	(#('BEGIN;'),(operators collect: #generateQueries),#('ROLLBACK;') joinUsing: String lf, String lf) inspect
]

{ #category : #accessing }
DBEEvolutionDescriber >> impactedEntitiesPresenter [
	^ impactedEntitiesPresenter
]

{ #category : #initialization }
DBEEvolutionDescriber >> initializeMenu [
	menu := MenuPresenter new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: 'Generate patch';
						action: [ self generatePatchAndInspect ] ] ].
	menu applyTo: self.
]

{ #category : #initialization }
DBEEvolutionDescriber >> initializeWidgets [
	self title: 'DB Evolution' translated.
	
	self initializeMenu.
	
	sequenceOperatorPresenter := self instantiate: DBESequenceOperatorPresenter.
	
	impactedEntitiesPresenter := self instantiate: DBEImpactedEntitiesPresenter.
	
	recommandationsPresenter := self instantiate: DBERecommandationsPresenter.
	
	operatorDescriptionPresenter := self instantiate: DBEOperatorDescriptionPresenter.
	
	entitySourceCodePresenter := self instantiate: DBEEntitySourceCodePresenter
]

{ #category : #accessing }
DBEEvolutionDescriber >> menu [
	^ menu
]

{ #category : #accessing }
DBEEvolutionDescriber >> operatorDescriptionPresenter [
	^ operatorDescriptionPresenter
]

{ #category : #accessing }
DBEEvolutionDescriber >> recommandationsPresenter [
	^ recommandationsPresenter
]

{ #category : #accessing }
DBEEvolutionDescriber >> sequenceOperatorPresenter [
	^ sequenceOperatorPresenter
]
