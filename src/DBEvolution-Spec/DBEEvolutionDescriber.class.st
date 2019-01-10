Class {
	#name : #DBEEvolutionDescriber,
	#superclass : #ComposablePresenter,
	#instVars : [
		'sequenceOperatorPresenter',
		'impactedEntitiesPresenter',
		'recommandationsPresenter'
	],
	#category : #'DBEvolution-Spec'
}

{ #category : #specs }
DBEEvolutionDescriber class >> defaultSpec [

	^ SpecLayout composed
		newRow: [ :mainRow |
			mainRow
				newRow: #sequenceOperatorPresenter;
				newRow: #impactedEntitiesPresenter;
				newRow: #recommandationsPresenter ];
		yourself
]

{ #category : #adapting }
DBEEvolutionDescriber >> adaptToDBESequenceCompositeOperator: aDBESequenceCompositeOperator [
	
	self sequenceOperatorPresenter
		whenSelectedItemChanged: [ :selectedOperator |
			self impactedEntitiesPresenter
				unselect;
				adaptToCollectionOfDBERecommandations: selectedOperator recommandations ]
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
			self impactedEntitiesPresenter refresh ].
	
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
	
	recommandationsPresenter := self instantiate: DBERecommandationsPresenter
]

{ #category : #accessing }
DBEEvolutionDescriber >> recommandationsPresenter [
	^ recommandationsPresenter
]

{ #category : #accessing }
DBEEvolutionDescriber >> sequenceOperatorPresenter [
	^ sequenceOperatorPresenter
]
