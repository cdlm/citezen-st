"
Version 1.5 is now promoted as stable for 1.4.
Let us know if you get some problems.

	(ConfigurationOfCitezen project version: #stable) load: { 'NoWeb'}.

	

The following was somehow working in the past. But we did not test it recently. 
	(ConfigurationOfCitezen project version: '1.1') load: { 'Citezen-Seaside'}.


This configuration depends on the SmaCC runtime only; to work on the parsers this is needed:

	ConfigurationOfSmaCC project latestVersion load: 'Tools'
	

To sync
SystemOrganization categories select: [:each |    '*Citezen*' match: each]

#(	'Citezen-Checking' 
	'Citezen-Model'
 	'Citezen-Model'
	'Citezen-Parsers'
	 'Citezen-Query'
	'Citezen-Reborn'
	'Citezen-Stef'
	'Citezen-Outputers'
	'Citezen-Herve'
 	'Citezen-Tests'
	'ConfigurationOfCitezen'
	)
do: [:each | Gofer new
	squeaksource3: 'citezen';
	package: each;
	push ]

Gofer new
	squeaksource3: 'citezen';
	package: 'ConfigurationOfCitezen';
	push 




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
	

	| packageNames |
	packageNames := SystemOrganization categories select: [:each |    '*Citezen*' match: each].
	packageNames 
		do: [:each | Gofer new
		squeaksource: 'Citezen';
		package: each;
		fetch ]




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
ConfigurationOfCitezen class >> message [

	^ message ifNil: [message := 'well you should use ConfigurationOfCitezen message: amessage ; push' ]
]

{ #category : #synching }
ConfigurationOfCitezen class >> message: aString [

	message := aString
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

	| packageNames |
	packageNames := SystemOrganization categories select: [:each |    '*Citezen*' match: each].
	packageNames 
		do: [:each | Gofer new
		squeaksource: 'Citezen';
		package: each;
		commit: self message ;
		push ]




]

{ #category : #'development support' }
ConfigurationOfCitezen class >> saveModifiedPackagesAndConfiguration: commitMessage [
	"Save modified mcz files, update the #development version and then save the configuration."

	"self saveModifiedPackagesAndConfiguration: '- fixed bug'"

	<apiDocumentation>
	self ensureMetacello.
	(Smalltalk at: #MetacelloToolBox) saveModifiedPackagesAndConfigurationIn: self description: commitMessage
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

{ #category : #baselines }
ConfigurationOfCitezen >> baseline06: spec [
	<version: '0.6-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Removed the dependency to FS since it is available in Pharo1.4.'.
		spec author: 'StephaneDucasse'.
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
			package: 'Citezen-Script';
			package: 'Citezen-Stef-Scripts' with: [ spec requires: #('Citezen-Model' 'Citezen-Outputers' 'Citezen-Query') ];
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside') ];
			package:  'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Checking' with: [ spec requires: 'Core' ];
			package: 'Citezen-CommandLine' with: [ spec requires: #('Core' 'OSProcess') ];
			package: 'Citezen-Tests' with: [ spec requires: #('Core') ].
			
		spec
			group: 'default' with: #('NoWeb');
			group: 'NoWeb' with: #('Core' 'Tests' 'Grease Core');
			group: 'Core' with: #('Citezen-Model' 'Citezen-Parsers' 'Citezen-Rendering' 'Citezen-Outputers' 'Citezen-Query' 'Citezen-Script' 'Citezen-Checking' 'Citezen-Stef-Scripts');
			group: 'CommandLine' with: #('NoWeb' 'Citezen-CommandLine');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline07: spec [
	<version: '0.7-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Moving to Squeaksource 30'.
		spec author: 'StephaneDucasse'.
		spec repository: 'http://ss3.gemstone.com/ss/citezen'.
		
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
			package: 'Citezen-Script';
			package: 'Citezen-Stef-Scripts' with: [ spec requires: #('Citezen-Model' 'Citezen-Outputers' 'Citezen-Query') ];
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside') ];
			package:  'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Checking' with: [ spec requires: 'Core' ];
			package: 'Citezen-CommandLine' with: [ spec requires: #('Core' 'OSProcess') ];
			package: 'Citezen-Tests' with: [ spec requires: #('Core') ].
			
		spec
			group: 'default' with: #('NoWeb');
			group: 'NoWeb' with: #('Core' 'Tests' 'Grease Core');
			group: 'Core' with: #('Citezen-Model' 'Citezen-Parsers' 'Citezen-Rendering' 'Citezen-Outputers' 'Citezen-Query' 'Citezen-Script' 'Citezen-Checking' 'Citezen-Stef-Scripts');
			group: 'CommandLine' with: #('NoWeb' 'Citezen-CommandLine');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline08: spec [
	<version: '0.8-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Addign reborn'.
		spec author: 'StephaneDucasse'.
		spec repository: 'http://ss3.gemstone.com/ss/citezen'.
		
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
			package: 'Citezen-Reborn' with: [spec requires: 'Citezen-Model'];
			package: 'Citezen-Script';
			package: 'Citezen-Stef-Scripts' with: [ spec requires: #('Citezen-Model' 'Citezen-Outputers' 'Citezen-Query') ];
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside') ];
			package:  'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Checking' with: [ spec requires: 'Core' ];
			package: 'Citezen-CommandLine' with: [ spec requires: #('Core' 'OSProcess') ];
			package: 'Citezen-Tests' with: [ spec requires: #('Core') ].
			
		spec
			group: 'default' with: #('NoWeb');
			group: 'NoWeb' with: #('Core' 'Tests' 'Grease Core');
			group: 'Core' with: #('Citezen-Model' 'Citezen-Parsers' 'Citezen-Rendering' 'Citezen-Outputers' 'Citezen-Query' 'Citezen-Script' 'Citezen-Checking' 'Citezen-Reborn' 'Citezen-Stef-Scripts');
			group: 'CommandLine' with: #('NoWeb' 'Citezen-CommandLine');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline09: spec [
	<version: '0.9-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Adding Tool'.
		spec author: 'StephaneDucasse'.
		spec repository: 'http://ss3.gemstone.com/ss/citezen'.
		
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					file: 'ConfigurationOfSeaside30';
					versionString: #stable;
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
			package: 'Citezen-Tools' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Query' with: [ spec requires: 'Citezen-Model'];
			package: 'Citezen-Reborn' with: [spec requires: 'Citezen-Model'];
			package: 'Citezen-Script';
			package: 'Citezen-Stef-Scripts' with: [ spec requires: #('Citezen-Model' 'Citezen-Outputers' 'Citezen-Query') ];
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside') ];
			package:  'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Checking' with: [ spec requires: 'Core' ];
			package: 'Citezen-CommandLine' with: [ spec requires: #('Core' 'OSProcess') ];
			package: 'Citezen-Tests' with: [ spec requires: #('Core') ].
			
		spec
			group: 'default' with: #('NoWeb');
			group: 'NoWeb' with: #('Core' 'Tests' 'Grease Core');
			group: 'Core' with: #('Citezen-Model' 'Citezen-Parsers' 'Citezen-Rendering' 'Citezen-Outputers' 'Citezen-Query' 'Citezen-Script' 'Citezen-Checking' 'Citezen-Reborn' 'Citezen-Tools' 'Citezen-Stef-Scripts');
			group: 'CommandLine' with: #('NoWeb' 'Citezen-CommandLine');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline10: spec [
	<version: '1.0-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Making sure that we only load Seaside Base and not the Development tools because it loads OB and blocks on Moose'.
		spec author: 'StephaneDucasse'.
		spec repository: 'http://ss3.gemstone.com/ss/citezen'.
		
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					file: 'ConfigurationOfSeaside30';
					versionString: #stable;
					loads: #('Base');
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
			package: 'Citezen-Tools' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Query' with: [ spec requires: 'Citezen-Model'];
			package: 'Citezen-Reborn' with: [spec requires: 'Citezen-Model'];
			package: 'Citezen-Script';
			package: 'Citezen-Stef-Scripts' with: [ spec requires: #('Citezen-Model' 'Citezen-Outputers' 'Citezen-Query') ];
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside'  'Citezen-Tests' 'Citezen-Magritte') ]; "ugly and wrong it also requires Magritte"
			package: 'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Checking' with: [ spec requires: 'Core' ];
			package: 'Citezen-CommandLine' with: [ spec requires: #('Core' 'OSProcess') ];
			package: 'Citezen-Tests' with: [ spec requires: #('Core') ].
			
		spec
			group: 'default' with: #('NoWeb');
			group: 'NoWeb' with: #('Core' 'Tests' 'Grease Core');
			group: 'Core' with: #('Citezen-Model' 'Citezen-Parsers' 'Citezen-Rendering' 'Citezen-Outputers' 'Citezen-Query' 'Citezen-Script' 'Citezen-Checking' 'Citezen-Reborn' 'Citezen-Tools' 'Citezen-Stef-Scripts');
			group: 'CommandLine' with: #('NoWeb' 'Citezen-CommandLine');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline11: spec [
	<version: '1.1-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Removing script packages'.
		spec author: 'StephaneDucasse'.
		spec repository: 'http://ss3.gemstone.com/ss/citezen'.
		
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					file: 'ConfigurationOfSeaside30';
					versionString: #stable;
					loads: #('Base');
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
			package: 'Citezen-Tools' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Query' with: [ spec requires: 'Citezen-Model'];
			package: 'Citezen-Reborn' with: [spec requires: 'Citezen-Model'];
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside'  'Citezen-Tests' 'Citezen-Magritte') ]; "ugly and wrong it also requires Magritte"
			package: 'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Checking' with: [ spec requires: 'Core' ];
			package: 'Citezen-CommandLine' with: [ spec requires: #('Core' 'OSProcess') ];
			package: 'Citezen-Tests' with: [ spec requires: #('Core') ].
			
		spec
			group: 'default' with: #('NoWeb');
			group: 'NoWeb' with: #('Core' 'Tests' 'Grease Core');
			group: 'Core' with: #('Citezen-Model'
							 'Citezen-Parsers'
							 'Citezen-Rendering'
							 'Citezen-Outputers'
							 'Citezen-Query'
							 'Citezen-Checking'
							 'Citezen-Reborn'
							 'Citezen-Tools');
			group: 'CommandLine' with: #('NoWeb' 'Citezen-CommandLine');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline12: spec [
	<version: '1.2-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Removing script packages'.
		spec author: 'StephaneDucasse'.
		spec repository: 'http://ss3.gemstone.com/ss/citezen'.
		
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					file: 'ConfigurationOfSeaside30';
					versionString: #stable;
					loads: #('Base');
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
			package: 'Citezen-Tools' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Query' with: [ spec requires: 'Citezen-Model'];
			package: 'Citezen-Reborn' with: [spec requires: 'Citezen-Model'];
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside'  'Citezen-Tests' 'Citezen-Magritte') ]; "ugly and wrong it also requires Magritte"
			package: 'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Checking' with: [ spec requires: 'Core' ];
			package: 'Citezen-Stef' with: [ spec requires: 'Citezen-Reborn' ];
			package: 'Citezen-CommandLine' with: [ spec requires: #('Core' 'OSProcess') ];
			package: 'Citezen-Tests' with: [ spec requires: #('Core') ].
			
		spec
			group: 'default' with: #('NoWeb');
			group: 'NoWeb' with: #('Core' 'Tests' 'Grease Core');
			group: 'Core' with: #('Citezen-Model'
							 'Citezen-Parsers'
							 'Citezen-Rendering'
							 'Citezen-Outputers'
							 'Citezen-Query'
							 'Citezen-Checking'
							 'Citezen-Reborn'
							 'Citezen-Tools'
							'Citezen-Stef');
			group: 'CommandLine' with: #('NoWeb' 'Citezen-CommandLine');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline13: spec [
	<version: '1.3-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Adding Herve Package'.
		spec author: 'StephaneDucasse'.
		spec repository: 'http://ss3.gemstone.com/ss/citezen'.
		
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					file: 'ConfigurationOfSeaside30';
					versionString: #stable;
					loads: #('Base');
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
			package: 'Citezen-Tools' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Query' with: [ spec requires: 'Citezen-Model'];
			package: 'Citezen-Reborn' with: [spec requires: 'Citezen-Model'];
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside'  'Citezen-Tests' 'Citezen-Magritte') ]; "ugly and wrong it also requires Magritte"
			package: 'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Checking' with: [ spec requires: 'Core' ];
			package: 'Citezen-Stef' with: [ spec requires: 'Citezen-Reborn' ];
			package: 'Citezen-Herve' with: [ spec requires: 'Citezen-Reborn' ];
			package: 'Citezen-CommandLine' with: [ spec requires: #('Core' 'OSProcess') ];
			package: 'Citezen-Tests' with: [ spec requires: #('Core') ].
			
		spec
			group: 'default' with: #('NoWeb');
			group: 'NoWeb' with: #('Core' 'Tests' 'Grease Core');
			group: 'Core' with: #('Citezen-Model'
							 'Citezen-Parsers'
							 'Citezen-Rendering'
							 'Citezen-Outputers'
							 'Citezen-Query'
							 'Citezen-Checking'
							 'Citezen-Reborn'
							 'Citezen-Tools'
							'Citezen-Stef'
							'Citezen-Herve'); "one day we will have to split core"
			group: 'CommandLine' with: #('NoWeb' 'Citezen-CommandLine');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #baselines }
ConfigurationOfCitezen >> baseline14: spec [
	<version: '1.4-baseline'>

	spec for: #common do: [
		spec blessing: #baseline.
		spec description: 'Migration to SmalltalkHub'.
		spec author: 'StephaneDucasse'.
		spec repository: 'http://smalltalkhub.com/mc/RMoD/Citezen/main'.
		
		spec
			project: 'Seaside' with: [
				spec
					className: 'ConfigurationOfSeaside30';
					file: 'ConfigurationOfSeaside30';
					versionString: #stable;
					loads: #('Base');
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
			package: 'Citezen-Tools' with: [ spec requires: 'Citezen-Model' ];
			package: 'Citezen-Query' with: [ spec requires: 'Citezen-Model'];
			package: 'Citezen-Reborn' with: [spec requires: 'Citezen-Model'];
			package: 'Citezen-Seaside' with: [ spec requires: #('Core' 'Seaside'  'Citezen-Tests' 'Citezen-Magritte') ]; "ugly and wrong it also requires Magritte"
			package: 'Citezen-Magritte' with: [ spec requires: 'Magritte' ];
			package: 'Citezen-Pier' with: [ spec requires: #('Core' 'Pier' 'Citezen-Seaside' 'Citezen-Magritte') ];
			package: 'Citezen-Checking' with: [ spec requires: 'Core' ];
			package: 'Citezen-Stef' with: [ spec requires: 'Citezen-Reborn' ];
			package: 'Citezen-Herve' with: [ spec requires: 'Citezen-Reborn' ];
			package: 'Citezen-CommandLine' with: [ spec requires: #('Core' 'OSProcess') ];
			package: 'Citezen-Tests' with: [ spec requires: #('Core') ].
			
		spec
			group: 'default' with: #('NoWeb');
			group: 'NoWeb' with: #('Core' 'Tests' 'Grease Core');
			group: 'Core' with: #('Citezen-Model'
							 'Citezen-Parsers'
							 'Citezen-Rendering'
							 'Citezen-Outputers'
							 'Citezen-Query'
							 'Citezen-Checking'
							 'Citezen-Reborn'
							 'Citezen-Tools'
							'Citezen-Stef'
							'Citezen-Herve'); "one day we will have to split core"
			group: 'CommandLine' with: #('NoWeb' 'Citezen-CommandLine');
			group: 'Web' with: #('Citezen-Seaside' 'Citezen-Magritte' 'Citezen-Pier');
			group: 'Tests' with: #('Citezen-Tests')
	]
]

{ #category : #'symbolic versions' }
ConfigurationOfCitezen >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'pharo1.4.x' version: '1.6'.
	spec for: #'pharo2.x' version: '1.8'.

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

{ #category : #'symbolic versions' }
ConfigurationOfCitezen >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'pharo' version: '0.8'.
	spec for: #'pharo1.3.x' version: '0.8'.
	"spec for: #'pharo1.4.x' version: '1.1'. previous stable"
	spec for: #'pharo1.4.x' version: '1.6'.
	spec for: #'pharo2.x' version: '1.6'.

]

{ #category : #versions }
ConfigurationOfCitezen >> version01: spec [
"	<version: '0.1' imports: #('0.1-baseline')>"
	
	spec for: #common do: [
		spec
			blessing: #development;
			author: 'DamienPollet';
			description: 'First Metacello configuration'
	]
]

{ #category : #versions }
ConfigurationOfCitezen >> version02: spec [
"	<version: '0.2' imports: #('0.2-baseline')>"
	
	spec for: #common do: [
		spec
			blessing: #development;
			author: 'DamienPollet';
			description: 'Depend on SmaCC too'
	]
]

{ #category : #versions }
ConfigurationOfCitezen >> version03: spec [
	"<version: '0.3' imports: #('0.3-baseline')>"
	
	spec for: #common do: [
		spec
			blessing: #development;
			author: 'DamienPollet';
			description: 'Switch to Seaside 3'
	]
]

{ #category : #versions }
ConfigurationOfCitezen >> version04: spec [
	"<version: '0.4' imports: #('0.4-baseline')>"
	
	spec for: #common do: [
		spec
			blessing: #development;
			author: 'AdrienBarreau';
			description: 'Change to Pharo 1.1'
	]
]

{ #category : #versions }
ConfigurationOfCitezen >> version05: spec [
	"<version: '0.5' imports: #('0.5-baseline')>"
	
	spec for: #common do: [
		spec
			blessing: #development;
			author: 'StephaneDucasse';
			description: 'Added Stef Scripts'
	]
]

{ #category : #versions }
ConfigurationOfCitezen >> version06: spec [
	<version: '0.6' imports: #('0.5-baseline')>
	
	spec for: #common do: [
		spec
			blessing: #development;
			author: 'StephaneDucasse';
			description: 'With versions before my modifications'.
		spec 
			package: 'Citezen-Model' with: 'Citezen-Model-StephaneDucasse.50' ;
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-AdrienBarreau.20';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-StephaneDucasse.39';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-StephaneDucasse.40';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.15';
			package: 'Citezen-Script' with: 'Citezen-Scripts-StephaneDucasse.20';
			package: 'Citezen-Stef-Scripts' with: 'Citezen-Stef-Scripts-StephaneDucasse.20'.]
]

{ #category : #versions }
ConfigurationOfCitezen >> version07: spec [
	<version: '0.7' imports: #('0.6-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: 'Localization in latex generation
Reload only the CZPool use elimination
Really stop using CZPool variables'.
		spec author: 'DamienPollet'.
		spec timestamp: '1/23/2012 18:13'.
		spec 
			package: 'Citezen-Checking' with: 'Citezen-Checking-StephaneDucasse.5';
			package: 'Citezen-Model' with: 'Citezen-Model-DamienPollet.59';
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-DamienCassou.21';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-DamienPollet.40';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-DamienPollet.50';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.15';
			package: 'Citezen-Script' with: 'Citezen-Script-sd.46';
			package: 'Citezen-Stef-Scripts' with: 'Citezen-Stef-Scripts-DamienPollet.33';
			package: 'Citezen-Tests' with: 'Citezen-Tests-DamienPollet.82'. ].

]

{ #category : #versions }
ConfigurationOfCitezen >> version08: spec [
	<version: '0.8' imports: #('0.7-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: 'Moving to ss3.0'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '1/23/2012 18:13'.
		spec 
			package: 'Citezen-Checking' with: 'Citezen-Checking-StephaneDucasse.5';
			package: 'Citezen-Model' with: 'Citezen-Model-DamienPollet.59';
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-DamienCassou.21';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-DamienPollet.40';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-DamienPollet.50';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.15';
			package: 'Citezen-Script' with: 'Citezen-Script-sd.46';
			package: 'Citezen-Stef-Scripts' with: 'Citezen-Stef-Scripts-DamienPollet.33';
			package: 'Citezen-Tests' with: 'Citezen-Tests-DamienPollet.82'. ].

]

{ #category : #versions }
ConfigurationOfCitezen >> version09: spec [
	<version: '0.9' imports: #('0.8-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: 'Latex + Bibtex generator + header /footer '.
		spec author: 'StephaneDucasse'.
		spec timestamp: '2/26/2012 18:13'.
		spec 
			package: 'Citezen-Checking' with: 'Citezen-Checking-StephaneDucasse.5';
			package: 'Citezen-Model' with: 'Citezen-Model-StephaneDucasse.60';
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-DamienCassou.21';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-DamienPollet.40';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-StephaneDucasse.51';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.16';
			package: 'Citezen-Script' with: 'Citezen-Script-StephaneDucasse.48';
			package: 'Citezen-Reborn' with: 'Citezen-Reborn-StephaneDucasse.9';
			package: 'Citezen-Stef-Scripts' with: 'Citezen-Stef-Scripts-StephaneDucasse.36';
			package: 'Citezen-Tests' with: 'Citezen-Tests-StephaneDucasse.83'. ].

]

{ #category : #versions }
ConfigurationOfCitezen >> version10: spec [
	<version: '1.0' imports: #('1.0-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'development'.
		spec description: 'Removing dull tests '.
		spec author: 'StephaneDucasse'.
		spec timestamp: '11/3/2012 18:13'.
		spec 
			package: 'Citezen-Checking' with: 'Citezen-Checking-StephaneDucasse.5';
			package: 'Citezen-Model' with: 'Citezen-Model-StephaneDucasse.61';
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-StephaneDucasse.22';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-DamienPollet.40';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-StephaneDucasse.53';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.17';
			package: 'Citezen-Script' with: 'Citezen-Script-StephaneDucasse.49';
			package: 'Citezen-Reborn' with: 'Citezen-Reborn-StephaneDucasse.15';
			package: 'Citezen-Tools' with: 'Citezen-Tools-StephaneDucasse.2';
			package: 'Citezen-Stef-Scripts' with: 'Citezen-Stef-Scripts-StephaneDucasse.37';
			package: 'Citezen-Tests' with: 'Citezen-Tests-StephaneDucasse.85'. ].

]

{ #category : #versions }
ConfigurationOfCitezen >> version11: spec [
	<version: '1.1' imports: #('1.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: 'New visitor, new object model for document, removed scripts and ugly code'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '23/3/2012 11:13'.
		spec 
			package: 'Citezen-Checking' with: 'Citezen-Checking-StephaneDucasse.5';
			package: 'Citezen-Model' with: 'Citezen-Model-StephaneDucasse.61';
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-StephaneDucasse.22';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-DamienPollet.40';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-StephaneDucasse.53';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.17';
			package: 'Citezen-Reborn' with: 'Citezen-Reborn-StephaneDucasse.16';
			package: 'Citezen-Tools' with: 'Citezen-Tools-StephaneDucasse.2';
			package: 'Citezen-Tests' with: 'Citezen-Tests-StephaneDucasse.86'. ].

]

{ #category : #versions }
ConfigurationOfCitezen >> version12: spec [
	<version: '1.2' imports: #('1.2-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: ' Use enhancements made by herve	verjus!'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '27/06/2012 12:43'.
		spec 
			package: 'Citezen-Checking' with: 'Citezen-Checking-StephaneDucasse.5';
			package: 'Citezen-Model' with: 'Citezen-Model-StephaneDucasse.61';
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-StephaneDucasse.22';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-DamienPollet.40';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-StephaneDucasse.53';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.17';
			package: 'Citezen-Reborn' with: 'Citezen-Reborn-HerveVerjus.20';
			package: 'Citezen-Stef' with: 'Citezen-Stef-StephaneDucasse.2';
			package: 'Citezen-Tools' with: 'Citezen-Tools-StephaneDucasse.2';
			package: 'Citezen-Tests' with: 'Citezen-Tests-StephaneDucasse.86'. ].

]

{ #category : #versions }
ConfigurationOfCitezen >> version13: spec [
	<version: '1.3' imports: #('1.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: ' Use enhancements made by herve	verjus and in addition load herve personal package
			In the future we should create separate configuration such as ConfigurationOfCitezenStef and ConfigurationOfCitezenHerve so that everybody is free to change without impacting the core'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '27/06/2012 12:43'.
		spec 
			package: 'Citezen-Checking' with: 'Citezen-Checking-StephaneDucasse.5';
			package: 'Citezen-Model' with: 'Citezen-Model-StephaneDucasse.61';
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-StephaneDucasse.22';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-DamienPollet.40';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-StephaneDucasse.53';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.17';
			package: 'Citezen-Reborn' with: 'Citezen-Reborn-HerveVerjus.20';
			package: 'Citezen-Stef' with: 'Citezen-Stef-StephaneDucasse.2';
			package: 'Citezen-Herve' with: 'Citezen-Herve-HerveVerjus.2';
			package: 'Citezen-Tools' with: 'Citezen-Tools-StephaneDucasse.2';
			package: 'Citezen-Tests' with: 'Citezen-Tests-StephaneDucasse.86'. ].

]

{ #category : #versions }
ConfigurationOfCitezen >> version14: spec [
	<version: '1.4' imports: #('1.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: ' Add latest changes of Herve and fix accent in bibtex'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '28/07/2012 12:43'.
		spec 
			package: 'Citezen-Checking' with: 'Citezen-Checking-StephaneDucasse.5';
			package: 'Citezen-Model' with: 'Citezen-Model-StephaneDucasse.61';
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-StephaneDucasse.22';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-DamienPollet.40';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-StephaneDucasse.53';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.17';
			package: 'Citezen-Reborn' with: 'Citezen-Reborn-StephaneDucasse.22';
			package: 'Citezen-Stef' with: 'Citezen-Stef-StephaneDucasse.3';
			package: 'Citezen-Herve' with: 'Citezen-Herve-HerveVerjus.3';
			package: 'Citezen-Tools' with: 'Citezen-Tools-StephaneDucasse.2';
			package: 'Citezen-Tests' with: 'Citezen-Tests-StephaneDucasse.86'. ].

]

{ #category : #versions }
ConfigurationOfCitezen >> version15: spec [
	<version: '1.5' imports: #('1.3-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: ' RMOD Report working'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '28/07/2012 12:43'.
		spec 
			package: 'Citezen-Checking' with: 'Citezen-Checking-StephaneDucasse.5';
			package: 'Citezen-Model' with: 'Citezen-Model-StephaneDucasse.62';
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-StephaneDucasse.22';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-DamienPollet.40';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-StephaneDucasse.53';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.18';
			package: 'Citezen-Reborn' with: 'Citezen-Reborn-StephaneDucasse.25';
			package: 'Citezen-Stef' with: 'Citezen-Stef-StephaneDucasse.5';
			package: 'Citezen-Herve' with: 'Citezen-Herve-HerveVerjus.3';
			package: 'Citezen-Tools' with: 'Citezen-Tools-StephaneDucasse.2';
			package: 'Citezen-Tests' with: 'Citezen-Tests-StephaneDucasse.86'. ].

]

{ #category : #versions }
ConfigurationOfCitezen >> version16: spec [
	<version: '1.6' imports: #('1.4-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: 'Migration to SmalltalkHub'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '17/02/2013 16:43'.
		spec 
			package: 'Citezen-Checking' with: 'Citezen-Checking-StephaneDucasse.5';
			package: 'Citezen-Model' with: 'Citezen-Model-StephaneDucasse.62';
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-StephaneDucasse.22';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-DamienPollet.40';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-StephaneDucasse.53';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.18';
			package: 'Citezen-Reborn' with: 'Citezen-Reborn-StephaneDucasse.25';
			package: 'Citezen-Stef' with: 'Citezen-Stef-StephaneDucasse.5';
			package: 'Citezen-Herve' with: 'Citezen-Herve-HerveVerjus.3';
			package: 'Citezen-Tools' with: 'Citezen-Tools-StephaneDucasse.2';
			package: 'Citezen-Tests' with: 'Citezen-Tests-StephaneDucasse.86'. ].

]

{ #category : #versions }
ConfigurationOfCitezen >> version17: spec [
	<version: '1.7' imports: #('1.4-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: 'adding publication principle in html but does not work when called from kozen'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '17/02/2013 16:43'.
		spec 
			package: 'Citezen-Checking' with: 'Citezen-Checking-StephaneDucasse.5';
			package: 'Citezen-Model' with: 'Citezen-Model-StephaneDucasse.62';
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-StephaneDucasse.22';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-DamienPollet.40';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-StephaneDucasse.53';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.18';
			package: 'Citezen-Reborn' with: 'Citezen-Reborn-StephaneDucasse.25';
			package: 'Citezen-Stef' with: 'Citezen-Stef-StephaneDucasse.6';
			package: 'Citezen-Herve' with: 'Citezen-Herve-HerveVerjus.3';
			package: 'Citezen-Tools' with: 'Citezen-Tools-StephaneDucasse.2';
			package: 'Citezen-Tests' with: 'Citezen-Tests-StephaneDucasse.86'. ].

]

{ #category : #versions }
ConfigurationOfCitezen >> version18: spec [
	<version: '1.8' imports: #('1.4-baseline' )>

	spec for: #'common' do: [
		spec blessing: #release.
		spec description: 'Starting to clean'.
		spec author: 'StephaneDucasse'.
		spec timestamp: '23/09/2013 16:43'.
		spec 
			package: 'Citezen-Checking' with: 'Citezen-Checking-StephaneDucasse.5';
			package: 'Citezen-Model' with: 'Citezen-Model-StephaneDucasse.62';
			package: 'Citezen-Parsers' with: 'Citezen-Parsers-StephaneDucasse.22';
			package: 'Citezen-Rendering' with: 'Citezen-Rendering-DamienPollet.40';
			package: 'Citezen-Outputers' with: 'Citezen-Outputers-StephaneDucasse.54';
			package: 'Citezen-Query' with: 'Citezen-Query-StephaneDucasse.18';
			package: 'Citezen-Reborn' with: 'Citezen-Reborn-StephaneDucasse.26';
			package: 'Citezen-Stef' with: 'Citezen-Stef-StephaneDucasse.6';
			package: 'Citezen-Herve' with: 'Citezen-Herve-HerveVerjus.3';
			package: 'Citezen-Tools' with: 'Citezen-Tools-StephaneDucasse.2';
			package: 'Citezen-Tests' with: 'Citezen-Tests-StephaneDucasse.86'. ].

]
