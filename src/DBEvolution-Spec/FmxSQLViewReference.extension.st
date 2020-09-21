Extension { #name : #FmxSQLViewReference }

{ #category : #'*DBEvolution-Spec' }
FmxSQLViewReference >> asStringForSpec [
	^self class asStringForSpec , '(' , self to asStringForSpec , ')'
]
