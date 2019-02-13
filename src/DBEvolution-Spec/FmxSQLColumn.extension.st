Extension { #name : #FmxSQLColumn }

{ #category : #'*DBEvolution-Spec' }
FmxSQLColumn >> dbeNameForUI [
	^ String streamContents: [ :stream |
		stream << self columnsContainer dbeNameForUI.
		stream << $..
		stream << self name ]
]
