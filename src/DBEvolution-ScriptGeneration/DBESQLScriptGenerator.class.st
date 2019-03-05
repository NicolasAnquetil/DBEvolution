Class {
	#name : #DBESQLScriptGenerator,
	#superclass : #Object,
	#instVars : [
		'writeStream',
		'operators'
	],
	#category : #'DBEvolution-ScriptGeneration'
}

{ #category : #accessing }
DBESQLScriptGenerator >> operators [
	^ operators
]

{ #category : #accessing }
DBESQLScriptGenerator >> operators: anObject [
	operators := anObject
]

{ #category : #accessing }
DBESQLScriptGenerator >> writeStream [
	^ writeStream
]

{ #category : #accessing }
DBESQLScriptGenerator >> writeStream: anObject [
	writeStream := anObject
]
