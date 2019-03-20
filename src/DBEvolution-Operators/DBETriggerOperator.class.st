Class {
	#name : #DBETriggerOperator,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'trigger'
	],
	#category : #'DBEvolution-Operators-Trigger'
}

{ #category : #accessing }
DBETriggerOperator >> entity [
	^ self trigger
]

{ #category : #accessing }
DBETriggerOperator >> entity: aFmxNGSQLTrigger [
	self trigger: aFmxNGSQLTrigger
]

{ #category : #accessing }
DBETriggerOperator >> trigger [
	^ trigger
]

{ #category : #accessing }
DBETriggerOperator >> trigger: anObject [
	trigger := anObject
]
