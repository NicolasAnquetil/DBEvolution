Class {
	#name : #DBERemoveStoredProcedure,
	#superclass : #DBEBasicRemoveStoredProcedure,
	#category : #'DBEvolution-Operators-StoredProcedure'
}

{ #category : #accessing }
DBERemoveStoredProcedure >> maximalImpactSet [
	^ self storedProcedure queryLocalIncoming: FmxSQLStoredProcedureCall
]

{ #category : #private }
DBERemoveStoredProcedure >> recommandationsGenerator [
	^ DBERecommandationsGenerator filters: { 
		[ :entity :db | entity isStoredProcedureCall ] asDBEImpactFilter -> { 
			[ :storedProcedureCall | DBEHumanIntervention entity: storedProcedureCall source sourcedBelonger ] }.
	}
]
