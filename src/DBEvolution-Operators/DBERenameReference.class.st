Class {
	#name : #DBERenameReference,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'reference',
		'newReferenceName'
	],
	#category : #'DBEvolution-Operators-References'
}

{ #category : #'instance creation' }
DBERenameReference class >> reference: aReference newName: aString [
	^ self new
		reference: aReference;
		newReferenceName: aString;
		yourself
]

{ #category : #testing }
DBERenameReference >> canBeAppliedOnData [
	"Concrete subclasses should override this method in order that it returns true if the operator can be applied on the data stored in the database."
	^ true
]

{ #category : #testing }
DBERenameReference >> canBeAppliedOnModel [
	"Concrete subclasses should override this method in order that it returns true if the operator can be applied on the model of the database."
	^ true
]

{ #category : #testing }
DBERenameReference >> isRenameReference [
	^ true
]

{ #category : #accessing }
DBERenameReference >> newReferenceName [
	^ newReferenceName
]

{ #category : #accessing }
DBERenameReference >> newReferenceName: anObject [
	newReferenceName := anObject
]

{ #category : #accessing }
DBERenameReference >> reference [
	^ reference
]

{ #category : #accessing }
DBERenameReference >> reference: anObject [
	reference := anObject
]

{ #category : #accessing }
DBERenameReference >> sourcedBelonger [
	self flag: '#sourcedBelonger are mostly implemented by entities (ex: FmxSQLCRUDQuery) except operators that #isRenameReference. why?'.
	^ self reference from sourcedBelonger
]

{ #category : #accessing }
DBERenameReference >> start [
	^ self reference start
]

{ #category : #accessing }
DBERenameReference >> stop [
	^ self reference stop
]

{ #category : #accessing }
DBERenameReference >> stopIndexInReplacement [
	^self reference stopIndexInReplacement
]
