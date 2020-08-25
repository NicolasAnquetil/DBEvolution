Extension { #name : #FmxSQLTable }

{ #category : #'*DBEvolution-Spec' }
FmxSQLTable >> asStringForSpec [
	^ String streamContents: [ :stream |
		stream << self class asStringForSpec.
		stream << ': '.
		stream << self parentNamespace asStringForSpec.
		stream << $..
		stream << self name ]
]
