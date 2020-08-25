Extension { #name : #FmxSQLColumn }

{ #category : #'*DBEvolution-Spec' }
FmxSQLColumn >> asStringForSpec [
	^ String streamContents: [ :stream |
		stream << self columnsContainer asStringForSpec.
		stream << $..
		stream << self name ]
]
