"
There are no released versions yet, so this is needed to load anything:

	((ConfigurationOfCitezen project) latestVersion: #development) load
	
	(ConfigurationOfCitezen project version: '0.5') load: { 'NoWeb'}.

This configuration depends on the SmaCC runtime only; to work on the parsers this is needed:

	ConfigurationOfSmaCC project latestVersion load: 'Tools'
	

To sync


#(	'Citezen-Checking' 
	'Citezen-Model'
 	'Citezen-Model'
 	'Citezen-Outputters'
 	'Citezen-Query'
 	'Citezen-Script'
 	'Citezen-Tests'
 	'Citezen-Stef-Scripts'
	)
do: [:each | Gofer new
	squeaksource: 'Citezen';
	package: each;
	push ]

SystemOrganization categories select: [:each |    '*Citezen*' match: each]


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

{ #category : #synching }
ConfigurationOfCitezen class >> fetch [ 
	"fetch all snapshots"
	self gofer fetch




]

{ #category : #synching }
ConfigurationOfCitezen class >> gofer [ 
	| gofer |
	gofer := Gofer new squeaksource: 'Citezen'.
	SystemOrganization categories
		select: [:each | '*Citezen*' match: each ]
		thenDo: [:each | gofer package: each ].
	^ gofer




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

	"^self project latestVersion load"
	
	((ConfigurationOfCitezen project) latestVersion: #development) load
]

{ #category : #loading }
ConfigurationOfCitezen class >> loadCommandLine [
	((ConfigurationOfCitezen project) latestVersion: #development) load: #CommandLine
]

{ #category : #loading }
ConfigurationOfCitezen class >> loadNoWeb [
	((ConfigurationOfCitezen project) latestVersion: #development) load: #NoWeb
]

{ #category : #synching }
ConfigurationOfCitezen class >> merge [
	self flag: 'doing a merge would probably be safer'
	self gofer merge



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

{ #category : #synching }
ConfigurationOfCitezen class >> push: aMessage [
	"self  push: 'simpler message implementation' "

	self gofer
		commit: aMessage;
		push




]

{ #category : #synching }
ConfigurationOfCitezen class >> update [
	self flag: 'doing a merge would probably be safer'
	self gofer update



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
			package: 'Citezen-Outputers' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Query' with: [ spec requires: 'Citezen-Model'];
			"package: 'Citezen-Scripts' with: [ spec requires: 'Core' ];"
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside') ];
			package:  'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte' 'Magritte-Seaside') ];
			package: 'Citezen-Tests' with: [ spec requires: 'Core' ].
			
		spec
			group: 'default' with: #('Core' 'Web' 'Tests');
			group: 'Core' with: #('Citezen-Model' 'Citezen-Parsers' 'Citezen-Rendering' 'Citezen-Outputers' 'Citezen-Query');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline03: spec [
	<version: '0.3-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'A set of tools to work with BibTeX bibliographies.'.
		spec author: 'DamienPollet'.
		spec repository: 'http://www.squeaksource.com/Citezen'.
		
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside';
					file: 'ConfigurationOfSeaside';
					repository: 'http://www.squeaksource.com/MetacelloRepository';
					loads: 'Seaside 3.0' ];
			project: 'Magritte' copyFrom: 'Seaside' with: [
				spec loads: #'Magritte2' ];
			project: 'Pier' copyFrom: 'Seaside' with: [
				spec loads: #'Pier2' ];
			project: 'SmaCC' with: [
				spec
					className: 'ConfigurationOfSmaCC';
					file: 'ConfigurationOfSmaCC';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].

		spec
			package: 'Citezen-Model';
			package: 'Citezen-Parsers' with: [ spec requires: #('Citezen-Model' 'SmaCC')];
			package: 'Citezen-Rendering' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Outputers' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Query' with: [ spec requires: 'Citezen-Model'];
			package: 'Citezen-Script' with: [ spec requires: #('Citezen-Model' 'Citezen-Outputers' 'Citezen-Query') ];
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside') ];
			package:  'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Tests' with: [ spec requires: 'Core' ].
			
		spec
			group: 'default' with: #('Core' 'Web' 'Tests');
			group: 'Core' with: #('Citezen-Model' 'Citezen-Parsers' 'Citezen-Rendering' 'Citezen-Outputers' 'Citezen-Query' 'Citezen-Script');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline04: spec [
	<version: '0.4-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'A set of tools to work with BibTeX bibliographies.'.
		spec author: 'AdrienBarreau'.
		spec repository: 'http://www.squeaksource.com/Citezen'.
		
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					file: 'ConfigurationOfSeaside30';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'Magritte' copyFrom: 'Seaside' with: [
				spec
					className: 'ConfigurationOfMagritte2';
					loads: #('Core' 'Magritte-Seaside');
					file: 'ConfigurationOfMagritte2';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'Pier' copyFrom: 'Seaside' with: [
				spec
					className: 'ConfigurationOfPier2';
					loads: #('Core');
					file: 'ConfigurationOfPier2';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'Grease Core' with: [
				spec
					className: 'ConfigurationOfGrease';
					loads: #('Core' );
					file: 'ConfigurationOfGrease';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'OSProcess' with: [
				spec
					className: 'ConfigurationOfOSProcess';
					file: 'ConfigurationOfOSProcess';
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
			package: 'Citezen-Outputers' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Query' with: [ spec requires: 'Citezen-Model'];
			package: 'Citezen-Script' with: [ spec requires: #('Citezen-Model' 'Citezen-Outputers' 'Citezen-Query') ];
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside') ];
			package:  'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Checking' with: [ spec requires: 'Core' ];
			package: 'Citezen-CommandLine' with: [ spec requires: #('Core' 'OSProcess') ];
			package: 'Citezen-Tests' with: [ spec requires: 'Core' ].
			
		spec
			group: 'default' with: #('NoWeb' 'Web');
			group: 'NoWeb' with: #('Core' 'Tests' 'Grease Core');
			group: 'Core' with: #('Citezen-Model' 'Citezen-Parsers' 'Citezen-Rendering' 'Citezen-Outputers' 'Citezen-Query' 'Citezen-Script' 'Citezen-Checking');
			group: 'CommandLine' with: #('NoWeb' 'Citezen-CommandLine');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline05: spec [
	<version: '0.5-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'A set of tools to work with BibTeX bibliographies.'.
		spec author: 'AdrienBarreau'.
		spec repository: 'http://www.squeaksource.com/Citezen'.
		
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					file: 'ConfigurationOfSeaside30';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'Magritte' copyFrom: 'Seaside' with: [
				spec
					className: 'ConfigurationOfMagritte2';
					loads: #('Core' 'Magritte-Seaside');
					file: 'ConfigurationOfMagritte2';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'Pier' copyFrom: 'Seaside' with: [
				spec
					className: 'ConfigurationOfPier2';
					loads: #('Core');
					file: 'ConfigurationOfPier2';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'Grease Core' with: [
				spec
					className: 'ConfigurationOfGrease';
					loads: #('Core' );
					file: 'ConfigurationOfGrease';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'OSProcess' with: [
				spec
					className: 'ConfigurationOfOSProcess';
					file: 'ConfigurationOfOSProcess';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'SmaCC' with: [
				spec
					className: 'ConfigurationOfSmaCC';
					file: 'ConfigurationOfSmaCC';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ];
			project: 'Filesystem' with: [
				spec
					className: 'ConfigurationOfFilesystem';
					file: 'ConfigurationOfFilesystem';
					repository: 'http://www.squeaksource.com/MetacelloRepository' ].

		spec
			package: 'Citezen-Model';
			package: 'Citezen-Parsers' with: [ spec requires: #('Citezen-Model' 'SmaCC')];
			package: 'Citezen-Rendering' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Outputers' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Query' with: [ spec requires: 'Citezen-Model'];
			package: 'Citezen-Script';
			package: 'Citezen-Stef-Scripts' with: [ spec requires: #('Citezen-Model' 'Citezen-Outputers' 'Citezen-Query') ];
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside') ];
			package:  'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Checking' with: [ spec requires: 'Core' ];
			package: 'Citezen-CommandLine' with: [ spec requires: #('Core' 'OSProcess') ];
			package: 'Citezen-Tests' with: [ spec requires: #('Core' 'Filesystem') ].
			
		spec
			group: 'default' with: #('NoWeb' 'Web');
			group: 'NoWeb' with: #('Core' 'Tests' 'Grease Core');
			group: 'Core' with: #('Citezen-Model' 'Citezen-Parsers' 'Citezen-Rendering' 'Citezen-Outputers' 'Citezen-Query' 'Citezen-Script' 'Citezen-Checking' 'Citezen-Stef-Scripts');
			group: 'CommandLine' with: #('NoWeb' 'Citezen-CommandLine');
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

{ #category : #versions }
ConfigurationOfCitezen >> version03: spec [
	<version: '0.3' imports: #('0.3-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #development;
			author: 'DamienPollet';
			description: 'Switch to Seaside 3'
	]
]

{ #category : #versions }
ConfigurationOfCitezen >> version04: spec [
	<version: '0.4' imports: #('0.4-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #development;
			author: 'AdrienBarreau';
			description: 'Change to Pharo 1.1'
	]
]

{ #category : #versions }
ConfigurationOfCitezen >> version05: spec [
	<version: '0.5' imports: #('0.5-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #development;
			author: 'StephaneDucasse';
			description: 'Added Stef Scripts'
	]
]
