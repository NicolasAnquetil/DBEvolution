Class {
	#name : #DBERenameColumn,
	#superclass : #DBEOperatorTargettingColumnInModel,
	#instVars : [
		'newColumnName'
	],
	#category : #'DBEvolution-Operators-Column'
}

{ #category : #testing }
DBERenameColumn >> canBeAppliedOnData [
	^ true
]

{ #category : #testing }
DBERenameColumn >> canBeAppliedOnModel [
	^ true
]

{ #category : #accessing }
DBERenameColumn >> maximalImpactSet [
	^ super maximalImpactSet reject: [ :columnReference |
		(columnReference source ifNil: [ columnReference foreignKeyConstraintSource ])
			in: [ :source | source isConstraint ] ]
]

{ #category : #accessing }
DBERenameColumn >> newColumnName [
	^ newColumnName
]

{ #category : #accessing }
DBERenameColumn >> newColumnName: anObject [
	newColumnName := anObject
]

{ #category : #printing }
DBERenameColumn >> printArgumentsForSpecOn: aStream [
	super printArgumentsForSpecOn: aStream.
	aStream
		nextPutAll: ' TO ';
		nextPutAll: self targetColumn columnsContainer dbeNameForUI;
		nextPut: $.;
		nextPutAll: self newColumnName
]

{ #category : #accessing }
DBERenameColumn >> queriesTemplate [
	^ 'ALTER TABLE "{tableName}" RENAME COLUMN "{columnName}" TO "{newColumnName}";'
]

{ #category : #private }
DBERenameColumn >> recommandationsGenerator [
	self flag: #TODO.
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | entity isColumnReference and: [ entity isWildCardReference ] ] asDBEImpactFilter -> { 
			[ :ref | DBEDoNothing new ] }.
		[ :entity :db | entity isColumnReference and: [ entity source isAnyBelongerSourced and: [ entity source sourcedBelonger class = FmxSQLView and: [ entity source class = FmxSQLSelectClause ] ] ] ] asDBEImpactFilter -> { 
			[ :reference | DBERenameReferenceInSelectClause reference: reference newName: self newColumnName ].
			[ :reference | DBEDoNothing new ] }.
		[ :entity :db | entity isColumnReference and: [ entity source isAnyBelongerSourced and: [ entity source sourcedBelonger class = FmxSQLView ] ] ] asDBEImpactFilter -> { 
			[ :reference | DBERenameReferenceInNonSelectClause reference: reference newName: self newColumnName ].
			[ :reference | DBEDoNothing new ] }.
		[ :entity :db | entity isColumnReference and: [ entity source isAnyBelongerSourced and: [ entity source sourcedBelonger isKindOf: FmxSQLStoredProcedure ] ] ] asDBEImpactFilter -> { 
			[ :reference | DBERenameReferenceInStoredProcedure reference: reference newName: self newColumnName ].
			[ :reference | DBEDoNothing new ] }
	}
]

{ #category : #accessing }
DBERenameColumn >> templateArgumentsDictionary [
	^ super templateArgumentsDictionary
		at: #newColumnName put: self newColumnName;
		yourself
]
