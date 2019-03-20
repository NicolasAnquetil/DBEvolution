Class {
	#name : #DBECreateTrigger,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'triggerName',
		'when',
		'table',
		'storedProcedure',
		'firingAction'
	],
	#category : #'DBEvolution-Operators-Trigger'
}

{ #category : #testing }
DBECreateTrigger >> canBeAppliedOnData [
	^ true
]

{ #category : #testing }
DBECreateTrigger >> canBeAppliedOnModel [
	^ true
]

{ #category : #accessing }
DBECreateTrigger >> firingAction [
	^ firingAction
]

{ #category : #accessing }
DBECreateTrigger >> firingAction: anObject [
	firingAction := anObject
]

{ #category : #accessing }
DBECreateTrigger >> queriesTemplate [
	self flag: #TODO. "PROCEDURE should not be hard-coded."
	^ 'CREATE TRIGGER "{triggerName}" {when} {firingAction} ON "{tableName}" EXECUTE PROCEDURE "{storedProcedureName}"();'
]

{ #category : #accessing }
DBECreateTrigger >> storedProcedure [
	^ storedProcedure
]

{ #category : #accessing }
DBECreateTrigger >> storedProcedure: anObject [
	storedProcedure := anObject
]

{ #category : #accessing }
DBECreateTrigger >> table [
	^ table
]

{ #category : #accessing }
DBECreateTrigger >> table: anObject [
	table := anObject
]

{ #category : #accessing }
DBECreateTrigger >> templateArgumentsDictionary [
	"Returns a Dictionary containing the values to be substituted in the template."
	^ { 
		'triggerName' -> self triggerName.
		'tableName' -> self table name.
		'storedProcedureName' -> self storedProcedure name.
		'when' -> self when.
		'firingAction' -> self firingAction
	 } asDictionary
]

{ #category : #accessing }
DBECreateTrigger >> triggerName [
	^ triggerName
]

{ #category : #accessing }
DBECreateTrigger >> triggerName: anObject [
	triggerName := anObject
]

{ #category : #accessing }
DBECreateTrigger >> when [
	^ when
]

{ #category : #accessing }
DBECreateTrigger >> when: anObject [
	when := anObject
]
