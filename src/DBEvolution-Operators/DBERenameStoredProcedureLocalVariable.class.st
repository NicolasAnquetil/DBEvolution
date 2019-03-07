Class {
	#name : #DBERenameStoredProcedureLocalVariable,
	#superclass : #DBEAtomicOperator,
	#instVars : [
		'localVariable',
		'newLocalVariableName'
	],
	#category : #'DBEvolution-Operators-StoredProcedure'
}

{ #category : #'as yet unclassified' }
DBERenameStoredProcedureLocalVariable >> beAggregatedIn: aDBEModifyStoredProcedure [ 
	"Does nothing on purpose."
	self flag: #TODO. "Check if should do something or not?"
]

{ #category : #testing }
DBERenameStoredProcedureLocalVariable >> canBeAppliedOnData [
	"Can always be applied whatever the data contained by the DB."
	^ true
]

{ #category : #testing }
DBERenameStoredProcedureLocalVariable >> canBeAppliedOnModel [
	"Can always be applied."
	^ true
]

{ #category : #testing }
DBERenameStoredProcedureLocalVariable >> concernsStoredProcedure [
	^ true
]

{ #category : #accessing }
DBERenameStoredProcedureLocalVariable >> localVariable [
	^ localVariable
]

{ #category : #accessing }
DBERenameStoredProcedureLocalVariable >> localVariable: anObject [
	localVariable := anObject
]

{ #category : #accessing }
DBERenameStoredProcedureLocalVariable >> maximalImpactSet [
	^ self localVariable maximalImpactSet , { self localVariable sourceAnchor }
]

{ #category : #accessing }
DBERenameStoredProcedureLocalVariable >> newLocalVariableName [
	^ newLocalVariableName
]

{ #category : #accessing }
DBERenameStoredProcedureLocalVariable >> newLocalVariableName: anObject [
	newLocalVariableName := anObject
]

{ #category : #accessing }
DBERenameStoredProcedureLocalVariable >> recommandationsGenerator [
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | entity isLocalVariableAccess ] asDBEImpactFilter -> { 
			[ :localVariableAccess | DBERenameReferenceInStoredProcedure reference: localVariableAccess newName: self newLocalVariableName ] }.
		[ :entity :db | entity isEntitySourceAnchor ] asDBEImpactFilter -> { 
			[ :sourceAnchor | DBERewriteSourceAnchor sourceAnchor: sourceAnchor newContent: self newLocalVariableName ] } 
	}
]

{ #category : #accessing }
DBERenameStoredProcedureLocalVariable >> storedProcedure [
	^ self localVariable parentBehaviouralEntity
]
