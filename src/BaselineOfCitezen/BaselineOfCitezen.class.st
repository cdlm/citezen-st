Class {
	#name : #BaselineOfCitezen,
	#superclass : #BaselineOf,
	#category : #BaselineOfCitezen
}

{ #category : #baselines }
BaselineOfCitezen >> baseline: spec [
	<baseline>
	
	spec for: #common do: [
		spec baseline: 'SmaCC' with: [ spec repository: 'github://ThierryGoubier/SmaCC' ].
				
		spec
			package: 'Citezen-Model';
			package: 'Citezen-Parsers' with: [ spec requires: #('Citezen-Model' 'SmaCC')];
			package: 'Citezen-Rendering' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Query' with: [ spec requires: 'Citezen-Model'];
			package: 'Citezen-Checking' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Tests' with: [ spec requires: #('Core') ].
			
		spec
			group: 'default' with: #('development');
			group: 'development' with: #('core' 'tests');
			group: 'core' with: #(
				'Citezen-Model'
				'Citezen-Parsers'
				'Citezen-Rendering'
				'Citezen-Query'
				'Citezen-Checking'
			);
			group: 'tests' with: #('Citezen-Tests')
	]
]
