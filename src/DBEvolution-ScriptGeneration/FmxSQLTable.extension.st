Extension { #name : #FmxSQLTable }

{ #category : #'*DBEvolution-ScriptGeneration' }
FmxSQLTable >> terminalOperatorToModifyReferenceFromNonTerminalOperator: nonTerminalOperator [
	^DBEModifyForeignKeyConstraint new
		reference: nonTerminalOperator reference;
		yourself
]
