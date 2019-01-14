Class {
	#name : #DBEEvolutionDescriber,
	#superclass : #ComposablePresenter,
	#instVars : [
		'sequenceOperatorPresenter',
		'impactedEntitiesPresenter',
		'recommandationsPresenter',
		'operatorDescriptionPresenter'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #specs }
DBEEvolutionDescriber class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :mainColumn | 
			mainColumn
				newRow: [ :mainRow | 
					mainRow
						newColumn: #sequenceOperatorPresenter;
						newColumn: #impactedEntitiesPresenter;
						newColumn: #recommandationsPresenter ];
				newRow: #operatorDescriptionPresenter ];
		yourself
]

{ #category : #adapting }
DBEEvolutionDescriber >> adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator [
	
	self sequenceOperatorPresenter
		whenSelectedItemChanged: [ :selectedOperator |
			self impactedEntitiesPresenter
				unselect;
				adaptToCollectionOfDBERecommandations: selectedOperator recommandations.
			self operatorDescriptionPresenter adaptToDBEOperator: selectedOperator ]
		ifUnselected: [ 
			self impactedEntitiesPresenter
				unselect;
				adaptToCollectionOfDBERecommandations: #() ].
	
	self impactedEntitiesPresenter 
		whenSelectedItemChanged: [ :selectedDBERecommandation |
			self recommandationsPresenter
				unselect;
				adaptToCollectionOfDBEOperators: selectedDBERecommandation operators ]
		ifUnselected: [
			self recommandationsPresenter
				unselect;
				adaptToCollectionOfDBEOperators: #() ].
			
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
DBEEvolutionDescriber >> impactedEntitiesPresenter [
	^ impactedEntitiesPresenter
]

{ #category : #initialization }
DBEEvolutionDescriber >> initializeWidgets [
	self title: 'DB Evolution' translated.
	
	sequenceOperatorPresenter := self instantiate: DBESequenceOperatorPresenter.
	
	impactedEntitiesPresenter := self instantiate: DBEImpactedEntitiesPresenter.
	
	recommandationsPresenter := self instantiate: DBERecommandationsPresenter.
	
	operatorDescriptionPresenter := self instantiate: DBEOperatorDescriptionPresenter
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
