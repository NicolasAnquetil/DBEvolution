Class {
	#name : #DBEModifyTrigger,
	#superclass : #DBETriggerOperator,
	#instVars : [
		'name',
		'when',
		'table',
		'storedProcedure',
		'firingAction'
	],
	#category : #'DBEvolution-Operators-Trigger'
}

{ #category : #converting }
DBEModifyTrigger >> asCreate [
	^ DBECreateTrigger new
		triggerName: self name;
		when: self when;
		storedProcedure: self storedProcedure;
		table: self table;
		firingAction: self firingAction;
		yourself
]

{ #category : #converting }
DBEModifyTrigger >> asRemove [
	^ DBEBasicRemoveTrigger trigger: self trigger
]

{ #category : #accessing }
DBEModifyTrigger >> firingAction [
	^ firingAction ifNil: [ firingAction := self trigger firingAction ]
]

{ #category : #accessing }
DBEModifyTrigger >> firingAction: anObject [
	firingAction := anObject
]

{ #category : #accessing }
DBEModifyTrigger >> name [
	^ name ifNil: [ name := self trigger name ]
]

{ #category : #accessing }
DBEModifyTrigger >> name: anObject [
	name := anObject
]

{ #category : #testing }
DBEModifyTrigger >> needRemoveRecreate [
	^ true
]

{ #category : #accessing }
DBEModifyTrigger >> storedProcedure [
	^ storedProcedure ifNil: [ storedProcedure := self trigger storedProcedure ]
]

{ #category : #accessing }
DBEModifyTrigger >> storedProcedure: anObject [
	storedProcedure := anObject
]

{ #category : #accessing }
DBEModifyTrigger >> table [
	^ table ifNil: [ table := self trigger table ]
]

{ #category : #accessing }
DBEModifyTrigger >> table: anObject [
	table := anObject
]

{ #category : #accessing }
DBEModifyTrigger >> when [
	^ when ifNil: [ when := self trigger when ]
]

{ #category : #accessing }
DBEModifyTrigger >> when: anObject [
	when := anObject
]
