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
		[ :entity :db | entity isColumnReference and: [ entity source isAnyBelongerSourced ] ] asDBEImpactFilter -> { 
			[ :pkConstraint | DBEHumanIntervention entity: pkConstraint ] }
	}
]

{ #category : #accessing }
DBERenameColumn >> templateArgumentsDictionary [
	^ super templateArgumentsDictionary
		at: #newColumnName put: self newColumnName;
		yourself
]
