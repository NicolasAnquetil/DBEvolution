Extension { #name : #FmxSQLTable }

{ #category : #'*DBEvolution-ScriptGeneration' }
FmxSQLTable >> referenceOperatorToEntityOperator: nonTerminalOperatorCollection [
	^DBEModifyForeignKeyConstraint new
		reference: nonTerminalOperatorCollection reference;
		yourself
]
