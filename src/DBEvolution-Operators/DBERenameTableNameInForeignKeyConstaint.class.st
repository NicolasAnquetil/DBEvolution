Class {
	#name : #DBERenameTableNameInForeignKeyConstaint,
	#superclass : #DBERenameReference,
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
DBERenameTableNameInForeignKeyConstaint >> constraint [
"
ALTER TABLE <constraint table>
ADD CONSTRAINT <constraint name> 
FOREIGN KEY (<constraint outgoingColumnReferences first column name>) 
REFERENCES <ref column columnsContainer name> (ref column name);
"
	^self reference foreignKeyConstraintSource 
]

{ #category : #testing }
DBERenameTableNameInForeignKeyConstaint >> isModify [
	^ true
]

{ #category : #accessing }
DBERenameTableNameInForeignKeyConstaint >> maximalImpactSet [
	"Returns the maximal impact set of the operator."
	^ self constraint maximalImpactSet
]

{ #category : #printing }
DBERenameTableNameInForeignKeyConstaint >> printArgumentsForSpecOn: aStream [
]

{ #category : #private }
DBERenameTableNameInForeignKeyConstaint >> recommandationsGenerator [
	
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | true ] asDBEImpactFilter -> { 
			[ :tr | DBEHumanIntervention entity: tr source ] }
	}
]
