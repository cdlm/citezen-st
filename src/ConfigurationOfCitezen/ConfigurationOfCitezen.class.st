"
There are no released versions yet, so this is needed to load anything:

	(ConfigurationOfCitezen project latestVersion: #development) load

This configuration depends on the SmaCC runtime only; to work on the parsers this is needed:

	ConfigurationOfSmacc project latestVersion load: 'Tools'
"
Class {
	#name : #ConfigurationOfCitezen,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfCitezen
}

{ #category : #private }
ConfigurationOfCitezen class >> bootstrapPackage: aString from: aPath [ 
	| repository version |
	repository := MCHttpRepository
				location: aPath
				user: ''
				password: ''.
	repository
		versionReaderForFileNamed: aString , '.mcz'
		do: [:reader | 
			version := reader version.
			version load.
			version workingCopy repositoryGroup addRepository: repository]
]

{ #category : #private }
ConfigurationOfCitezen class >> ensureMetacello [
	"Bootstrap Gofer (if necessary), bootstrap ConfigurationOfMetacello (using old Gofer API), then load the latest 
	version of Metacello itself."

	Smalltalk at: #MetacelloProject ifAbsent: [
		Smalltalk at: #Gofer ifAbsent: [
			"Current version of Gofer from which to bootstrap - as of 1.0-beta.21"
			self bootstrapPackage: 'Gofer-Core-lr.115' from: 'http://seaside.gemstone.com/ss/metacello' ].
		Smalltalk at: #Gofer ifPresent: [:goferClass | | gofer |
			gofer := goferClass new
				url: 'http://seaside.gemstone.com/ss/metacello';
				yourself.
			[ gofer addPackage: 'ConfigurationOfMetacello' ] on: Warning do: [:ex | ex resume ].
			gofer load ].
		"load 'default' group of Metacello"
		(Smalltalk at: #ConfigurationOfMetacello) perform: #load ]
]

{ #category : #'metacello tool support' }
ConfigurationOfCitezen class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #'metacello tool support' }
ConfigurationOfCitezen class >> lastMetacelloVersionLoad [
	"Answer the last version loaded and the list of packages loaded for that version."

	LastVersionLoad == nil ifTrue: [ LastVersionLoad := nil -> 'default' ].
	^LastVersionLoad
]

{ #category : #loading }
ConfigurationOfCitezen class >> load [
	"self load"

	^self project latestVersion load
]

{ #category : #'metacello tool support' }
ConfigurationOfCitezen class >> metacelloVersion: versionString loads: anArrayOrString [
	"Stash the last version loaded and the list of packages loaded for that version. The list
	 of packages will be used by the tools when doing 'Load Package Version'"

	LastVersionLoad := versionString -> anArrayOrString
]

{ #category : #accessing }
ConfigurationOfCitezen class >> project [

	^self new project
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline01: spec [
	<version: '0.1-baseline'>
	"Citezen: obsolete umbrella package
	 Citezen-All: less obsolete umbrella package
	 Citezen-Rendering2: unfinished alternative to the phrases system
	 Citezen-Seaside: mostly Pier stuff
	 Citezen-Magritte: Magritte extensions, but actually mostly goes with -Pier
	 Citezen-Pier: should group everything Pier-specific
	 Citezen-Scripts: for standalone use"
	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'A set of tools to work with BibTeX bibliographies.'.
		spec author: 'DamienPollet'.
		spec repository: 'http://www.squeaksource.com/Citezen'.
		
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside28';
					file: 'ConfigurationOfSeaside28';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'Magritte' with: [
				spec
					className: 'ConfigurationOfMagritte';
					file: 'ConfigurationOfMagritte';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'Pier' with: [
				spec
					className: 'ConfigurationOfPier';
					file: 'ConfigurationOfPier';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].

		spec
			package: 'Citezen-Model';
			package: 'Citezen-Parsers' with: [ spec requires: #('Citezen-Model' "smacc")];
			package: 'Citezen-Rendering' with: [ spec requires: 'Citezen-Model' ];
			"package: 'Citezen-Scripts' with: [ spec requires: 'Core' ];"
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside') ];
			package:  'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Tests' with: [ spec requires: 'Core' ].
			
		spec
			group: 'Core' with: #('Citezen-Model' 'Citezen-Parsers' 'Citezen-Rendering');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'A set of tools to work with BibTeX bibliographies.'.
		spec author: 'DamienPollet'.
		spec repository: 'http://www.squeaksource.com/Citezen'.
		
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside28';
					file: 'ConfigurationOfSeaside28';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'Magritte' with: [
				spec
					className: 'ConfigurationOfMagritte';
					file: 'ConfigurationOfMagritte';
					repository: 'http://www.squeaksource.com/MetacelloRepository'];
			project: 'Magritte-Seaside' 
				copyFrom: 'Magritte' 
				with: [ spec loads: #('Magritte-Seaside') ];
			project: 'Pier' with: [
				spec
					className: 'ConfigurationOfPier';
					file: 'ConfigurationOfPier';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'SmaCC' with: [
				spec
					className: 'ConfigurationOfSmaCC';
					file: 'ConfigurationOfSmaCC';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].

		spec
			package: 'Citezen-Model';
			package: 'Citezen-Parsers' with: [ spec requires: #('Citezen-Model' 'SmaCC')];
			package: 'Citezen-Rendering' with: [ spec requires: 'Citezen-Model' ];
			"package: 'Citezen-Scripts' with: [ spec requires: 'Core' ];"
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside') ];
			package:  'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte' 'Magritte-Seaside') ];
			package: 'Citezen-Tests' with: [ spec requires: 'Core' ].
			
		spec
			group: 'default' with: #('Core' 'Web' 'Tests');
			group: 'Core' with: #('Citezen-Model' 'Citezen-Parsers' 'Citezen-Rendering');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #accessing }
ConfigurationOfCitezen >> project [

	^ project ifNil: [ | constructor |
		"Bootstrap Metacello if it is not already loaded"
		self class ensureMetacello.
		"Construct Metacello project"
		constructor := (Smalltalk at: #MetacelloVersionConstructor) on: self.
		project := constructor project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #versions }
ConfigurationOfCitezen >> version01: spec [
	<version: '0.1' imports: #('0.1-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #development;
			author: 'DamienPollet';
			description: 'First Metacello configuration'
	]
]

{ #category : #versions }
ConfigurationOfCitezen >> version02: spec [
	<version: '0.2' imports: #('0.2-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #development;
			author: 'DamienPollet';
			description: 'Depend on SmaCC too'
	]
]
