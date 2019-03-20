Extension { #name : #FmxSQLTrigger }

{ #category : #'*DBEvolution-Operators' }
FmxSQLTrigger >> identityModifyOperator [
	"Returns a Modify operator that will allow to recreate the trigger identically."
	^ DBEModifyTrigger new
		trigger: self;
		yourself
]
