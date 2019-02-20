Class {
	#name : #DBEDoNothing,
	#superclass : #DBEOperator,
	#traits : 'DBETTerminalOperator',
	#classTraits : 'DBETTerminalOperator classTrait',
	#category : #'DBEvolution-Core'
}

{ #category : #testing }
DBEDoNothing >> canBeAppliedOnData [
	^ true
]

{ #category : #testing }
DBEDoNothing >> canBeAppliedOnModel [
	^ true
]
