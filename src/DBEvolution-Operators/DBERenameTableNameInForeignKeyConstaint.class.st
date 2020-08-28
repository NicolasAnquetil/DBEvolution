Class {
	#name : #DBERenameTableNameInForeignKeyConstaint,
	#superclass : #Object,
	#instVars : [
		'constraint'
	],
	#category : #'DBEvolution-Operators-References'
}

{ #category : #accessing }
DBERenameTableNameInForeignKeyConstaint class >> constraint: c [
	^self new
		constraint: c ;
		yourself
]

{ #category : #testing }
DBERenameTableNameInForeignKeyConstaint >> asCreate [
	^DBEAddForeignKeyConstraint new
		sourceColumn: self sourceColumn ;
		targetColumn: self targetColumn ;
		yourself
]

{ #category : #testing }
DBERenameTableNameInForeignKeyConstaint >> asRemove [
	^ DBERemoveForeignKeyConstraint constraint: self reference
]

{ #category : #accessing }
DBERenameTableNameInForeignKeyConstaint >> constraint: aConstraint [
	constraint := aConstraint 
]

{ #category : #testing }
DBERenameTableNameInForeignKeyConstaint >> isModify [
	^ true
]

{ #category : #testing }
DBERenameTableNameInForeignKeyConstaint >> sourceColumn [
	^constraint outgoingColumnReferences first column
]

{ #category : #testing }
DBERenameTableNameInForeignKeyConstaint >> targetColumn [
	^constraint outgoingForeignKeyColumnReferences first column
]
