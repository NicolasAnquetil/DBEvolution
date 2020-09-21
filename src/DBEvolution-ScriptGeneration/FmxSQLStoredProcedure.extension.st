Extension { #name : #FmxSQLStoredProcedure }

{ #category : #'*DBEvolution-ScriptGeneration' }
FmxSQLStoredProcedure >> identityModifyOperator [
	"Returns a Modify operator that will allow to recreate the view identically."
	^ DBEModifyStoredProcedure new
		storedProcedure: self;
		bodySourceCode: self source;
		yourself
]

{ #category : #'*DBEvolution-ScriptGeneration' }
FmxSQLStoredProcedure >> terminalOperatorToModifyReferenceFromNonTerminalOperator: nonTerminalOperator [
	^DBEModifyStoredProcedureSource new
		storedProcedure: self ;
		newSourceCode: (self applyReferenceRenamings: nonTerminalOperator) ;
		yourself
]
