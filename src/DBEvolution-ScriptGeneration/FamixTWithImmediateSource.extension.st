Extension { #name : #FamixTWithImmediateSource }

{ #category : #'*DBEvolution-ScriptGeneration' }
FamixTWithImmediateSource >> applyReferenceRenamings: referenceRenamings [
	"Called when generating DBEvolution patch to rename a reference in the source code of an entity"
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
			lastIndex := referenceRename stopIndexInReplacement + 1 ].
		lastIndex < self source size
			ifTrue: [ stream << (self source copyFrom: lastIndex to: self source size) ] ]
]
