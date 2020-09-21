Extension { #name : #FmxSQLView }

{ #category : #'*DBEvolution-ScriptGeneration' }
FmxSQLView >> identityModifyOperator [
	"Returns a Modify operator that will allow to recreate the view identically."
	^ DBEModifyViewQuery new
		view: self;
		newQueryString: self source;
		yourself
]

{ #category : #'*DBEvolution-ScriptGeneration' }
FmxSQLView >> terminalOperatorToModifyReferenceFromNonTerminalOperator: nonTerminalOperator [
	^DBEModifyViewQuery new
		view: self ;
		newQueryString: (self applyReferenceRenamings: nonTerminalOperator) ;
		yourself
]
