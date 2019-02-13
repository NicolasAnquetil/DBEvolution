Extension { #name : #FmxSQLTable }

{ #category : #'*DBEvolution-Spec' }
FmxSQLTable >> dbeNameForUI [
	^ String streamContents: [ :stream |
		stream << self parentNamespace dbeNameForUI.
		stream << $..
		stream << self name ]
]
