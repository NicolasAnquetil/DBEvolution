Class {
	#name : #DBEAtomicOperator,
	#superclass : #DBEOperator,
	#instVars : [
		'recommandationsCache'
	],
	#category : #'DBEvolution-Core'
}

{ #category : #private }
DBEAtomicOperator >> executeQueries: aString [
	"Execute the queries located in aString."
	self shouldBeImplemented
]

{ #category : #private }
DBEAtomicOperator >> generateQueries [
	^ self queriesTemplate format: self templateArgumentsDictionary
]

{ #category : #testing }
DBEAtomicOperator >> isResolved [
	"Answers true if the operators is ready to be applied.
	 How it is computed depends on the operator.
	 For composite operators it will be true if #isResolved is true for all children.
	 For atomic operators it will be true if a recommandation has been chosed by the developper for each impacted entity."
	^ self recommandations allSatisfy: [ :recommandation | recommandation isOperatorChosen ]
]

{ #category : #accessing }
DBEAtomicOperator >> maximalImpactSet [
	"Returns the maximal impact set of the operator."
	^ self subclassResponsibility
]

{ #category : #accessing }
DBEAtomicOperator >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ self subclassResponsibility
]

{ #category : #accessing }
DBEAtomicOperator >> recommandations [
	^ recommandationsCache ifNil: [ 
		recommandationsCache := self recommandationsGenerator generateRecommandationsFor: self maximalImpactSet database: self database ]
]

{ #category : #initialization }
DBEAtomicOperator >> resetRecommandationsCache [
	^ recommandationsCache := nil
]

{ #category : #accessing }
DBEAtomicOperator >> templateArgumentsDictionary [
	"Returns a Dictionary containing the values to be substituted in the template."
	^ self subclassResponsibility
]

{ #category : #private }
DBEAtomicOperator >> uncheckedApply [
	"Instantiate the query(ies) template using the operator's configuration and execute these queries."

	self executeQueries: self generateQueries
]
