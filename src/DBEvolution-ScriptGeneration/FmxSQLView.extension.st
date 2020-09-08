Extension { #name : #FmxSQLView }

{ #category : #'*DBEvolution-ScriptGeneration' }
FmxSQLView >> applyReferenceRenamings: referenceRenamings [
	"To be sure the order stays the same in this method."
	| orderedReferenceRenamings lastIndex |
	
	orderedReferenceRenamings := referenceRenamings asOrderedCollection sorted: [ :a :b | a start < b start ].
	lastIndex := 1.
	^ String streamContents: [ :stream |
		orderedReferenceRenamings do: [ :referenceRename |
			(referenceRename start > lastIndex)
				ifTrue: [ 
					stream << (self source copyFrom: lastIndex to: referenceRename start - 1).
					lastIndex := referenceRename start ].
			referenceRename start = lastIndex
				ifTrue: [ stream << referenceRename newReferenceName ].
			lastIndex := referenceRename stop + 1 ].
		lastIndex < self source size
			ifTrue: [ stream << (self source copyFrom: lastIndex to: self source size) ] ]
]

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
