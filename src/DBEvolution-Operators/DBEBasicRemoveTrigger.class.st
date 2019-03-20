Class {
	#name : #DBEBasicRemoveTrigger,
	#superclass : #DBETriggerOperator,
	#category : #'DBEvolution-Operators-Trigger'
}

{ #category : #'instance creation' }
DBEBasicRemoveTrigger class >> trigger: aFmxNGSQLTrigger [
	^ self new
		trigger: aFmxNGSQLTrigger;
		yourself
]

{ #category : #accessing }
DBEBasicRemoveTrigger >> queriesTemplate [
	"Returns a string which is a template to generate SQL queries implementing the operator."
	^ 'DROP TRIGGER "{triggerName}" ON "{tableName}" RESTRICT;'
]

{ #category : #accessing }
DBEBasicRemoveTrigger >> templateArgumentsDictionary [
	"Returns a Dictionary containing the values to be substituted in the template."
	^ { 
		'triggerName' -> self trigger name.
		'tableName' -> self trigger table name
	 } asDictionary
]
