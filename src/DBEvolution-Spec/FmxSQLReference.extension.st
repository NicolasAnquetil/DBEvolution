Extension { #name : #FmxSQLReference }

{ #category : #'*DBEvolution-Spec' }
FmxSQLReference >> asStringForSpec [
	^self class asStringForSpec , '(' , self to anyOne asStringForSpec , ')'
]
