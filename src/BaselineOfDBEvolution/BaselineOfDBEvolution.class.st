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
			"Packages"
			spec
				package: 'DBEvolution';
				package: 'DBEvolution-Operators' with: [ spec requires: #('DBEvolution') ];
				package: 'DBEvolution-Tests' with: [ spec requires: #('DBEvolution' 'DBEvolution-Operators' 'Mocketry') ] ]
]
