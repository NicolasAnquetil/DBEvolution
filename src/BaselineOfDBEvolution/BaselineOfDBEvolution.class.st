Class {
	#name : #BaselineOfDBEvolution,
	#superclass : #BaselineOf,
	#category : #BaselineOfDBEvolution
}

{ #category : #baselines }
BaselineOfDBEvolution >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [
			spec
    			baseline: 'Mocketry'
   				with: [ spec repository: 'github://dionisiydk/Mocketry:v4.0.x' ].
			spec
				baseline: 'FAMIXNGSQL'
				with: [ spec repository: 'github://juliendelplanque/FAMIXNGSQL/repository' ].
			"Packages"
			spec
				package: 'DBEvolution' with: [ spec requires: #('FAMIXNGSQL') ];
				package: 'DBEvolution-Operators' with: [ spec requires: #('DBEvolution') ];
				package: 'DBEvolution-Tests' with: [ spec requires: #('DBEvolution' 'DBEvolution-Operators' 'Mocketry') ];
				package: 'DBEvolution-Spec' with: [ spec requires: #('DBEvolution' 'DBEvolution-Operators') ];
				package: 'DBEvolution-ConnectionsManager' with: [ spec requires: #('DBEvolution' 'DBEvolution-Spec') ];
				package: 'DBEvolution-ScriptGeneration' with: [ spec requires: #('DBEvolution' 'DBEvolution-Operators') ] ]
]
