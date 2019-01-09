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
	self assert: recommandations size equals: 1.
	self assert: recommandations first class equals: DBERecommandation.
	self assert: recommandations first entity equals: foreignKeyMock.
	self assert: recommandations first operators size equals: 1.
	self assert: recommandations first operators first class equals: DBERemoveForeignKeyConstraint.
	self assert: recommandations first operators first constraint equals: foreignKeyMock
]

{ #category : #tests }
DBERecommandationsGeneratorTest >> testGenerateRecommandationsForDatabase2 [
	| constraintMock greaterImpactSet recommandations |
	constraintMock := Mock new.
	constraintMock stub
		isForeignKey willReturn: false.
	constraintMock stub
		isConstraint willReturn: true.
	constraintMock stub
		isClauseAbleToReferenceColumn willReturn: false.
	constraintMock stub
		isWhereClause willReturn: false.
	constraintMock stub
		isJoinClause willReturn: false.
	
	greaterImpactSet := { constraintMock }.
	
	recommandations := impactAndRecommandations generateRecommandationsFor: greaterImpactSet database: DBEDatabase new.
	self assert: recommandations size equals: greaterImpactSet size.
	self assert: recommandations size equals: 1.
	self assert: recommandations first class equals: DBERecommandation.
	self assert: recommandations first entity equals: constraintMock.
	self assert: recommandations first operators size equals: 1.
	self assert: recommandations first operators first class equals: DBEHumanIntervention.
	self assert: recommandations first operators first entity equals: constraintMock
]

{ #category : #tests }
DBERecommandationsGeneratorTest >> testGenerateRecommandationsForDatabase3 [
	| constraintMock greaterImpactSet |
	constraintMock := Mock new.
	constraintMock stub
		isForeignKey willReturn: false.
	constraintMock stub
		isConstraint willReturn: false.
	constraintMock stub
		isClauseAbleToReferenceColumn willReturn: false.
	constraintMock stub
		isWhereClause willReturn: false.
	constraintMock stub
		isJoinClause willReturn: false.
	
	greaterImpactSet := { constraintMock }.
	
	self
		should: [ impactAndRecommandations generateRecommandationsFor: greaterImpactSet database: DBEDatabase new ]
		raise: DBENoFilterMatchesEntityError.
	
]

{ #category : #tests }
DBERecommandationsGeneratorTest >> testGenerateRecommandationsForEmptyImpactSet [
	self assert: (impactAndRecommandations generateRecommandationsFor: #() database: DBEDatabase new) isEmpty
]
