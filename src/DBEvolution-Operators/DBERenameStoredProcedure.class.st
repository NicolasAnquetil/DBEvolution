Class {
	#name : #DBERenameStoredProcedure,
	#superclass : #DBEStoredProcedureOperator,
	#instVars : [
		'newName'
	],
	#category : #'DBEvolution-Operators-StoredProcedure'
}

{ #category : #'as yet unclassified' }
DBERenameStoredProcedure >> beAggregatedIn: aDBECreateStoredProcedure [
	aDBECreateStoredProcedure storedProcedureName: self newName
]

{ #category : #testing }
DBERenameStoredProcedure >> concernsStoredProcedure [
	^ true
]

{ #category : #accessing }
DBERenameStoredProcedure >> maximalImpactSet [
	^ self storedProcedure maximalImpactSet
]

{ #category : #accessing }
DBERenameStoredProcedure >> newName [
	^ newName
]

{ #category : #accessing }
DBERenameStoredProcedure >> newName: anObject [
	newName := anObject
]

{ #category : #private }
DBERenameStoredProcedure >> recommandationsGenerator [
	self flag: #TOFIX."Add test methods for 'predicate' using #class message..."
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | entity isStoredProcedureCall and: [ entity from isAnyBelongerSourced and: [ entity from sourcedBelonger isStoredProcedure ] ] ] asDBEImpactFilter -> { 
			[ :ref | DBERenameReferenceInStoredProcedure reference: ref newName: self newName ] }.
		[ :entity :db | entity isStoredProcedureCall and: [ entity from isAnyBelongerSourced and: [ entity from sourcedBelonger class = FmxSQLView and: [ entity from class = FmxSQLSelectClause ] ] ] ] asDBEImpactFilter -> { 
			[ :ref | DBERenameReferenceInSelectClause reference: ref newName: self newName ] }.
		[ :entity :db | entity isStoredProcedureCall and: [ entity from isAnyBelongerSourced and: [ entity from sourcedBelonger class = FmxSQLView ] ] ] asDBEImpactFilter -> { 
			[ :ref | DBERenameReferenceInNonSelectClause reference: ref newName: self newName ] }.
	}
]
