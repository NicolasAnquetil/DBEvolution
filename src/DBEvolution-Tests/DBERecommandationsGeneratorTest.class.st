Class {
	#name : #DBERecommandationsGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'impactAndRecommandations'
	],
	#category : #'DBEvolution-Tests'
}

{ #category : #running }
DBERecommandationsGeneratorTest >> setUp [
	super setUp.
	impactAndRecommandations := DBERecommandationsGenerator filters: { 
		[ :entity :db | entity isForeignKey ] asDBEImpactFilter -> { 
			[ :fkConstraint | DBERemoveForeignKeyConstraint constraint: fkConstraint ] }.
		[ :entity :db | entity isConstraint and: [ entity isForeignKey not ] ] asDBEImpactFilter -> { 
			[ :constraint | DBEHumanIntervention entity: constraint ] }.
		[ :entity :db | entity isClauseAbleToReferenceColumn and: [ entity isWhereClause not and: [ entity isJoinClause not ] ] ] asDBEImpactFilter -> { 
			[ :clause | DBEHumanIntervention entity: clause ] }.
		[ :entity :db | entity isWhereClause or: [ entity isJoinClause ] ] asDBEImpactFilter -> { 
			[ :whereOrJoinClause | DBEHumanIntervention entity: whereOrJoinClause ] }
	}
]

{ #category : #tests }
DBERecommandationsGeneratorTest >> testGenerateRecommandationsForDatabase [
	| foreignKeyMock greaterImpactSet recommandations |
	foreignKeyMock := Mock new.
	foreignKeyMock stub
		isForeignKey willReturn: true.
	foreignKeyMock stub
		isConstraint willReturn: false.
	foreignKeyMock stub
		isClauseAbleToReferenceColumn willReturn: false.
	foreignKeyMock stub
		isWhereClause willReturn: false.
	foreignKeyMock stub
		isJoinClause willReturn: false.
	
	greaterImpactSet := { foreignKeyMock }.
	
	recommandations := impactAndRecommandations generateRecommandationsFor: greaterImpactSet database: DBEDatabase new.
	self assert: recommandations size equals: greaterImpactSet size.
	1 halt.
]

{ #category : #tests }
DBERecommandationsGeneratorTest >> testGenerateRecommandationsForEmptyImpactSet [
	self assert: (impactAndRecommandations generateRecommandationsFor: #() database: DBEDatabase new) isEmpty
]
