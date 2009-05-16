Class {
	#name : #CZLoader,
	#superclass : #Object,
	#category : #'Citezen-Loader'
}

{ #category : #load }
CZLoader class >> load [
	
	ScriptLoader new installingInstaller.
	ScriptLoader new installingUniverse.
	Installer ss project: 'Rio'; install: 'Rio-Kernel'; install: 'Rio-Grande'.
	self loadSmacc.
	self loadCitezen
]

{ #category : #load }
CZLoader class >> loadCitezen [

	Installer ss project: 'Citezen';
		addPackage: 'Citezen-All';
		install: 'Citezen-All'
	"Citezen-Seaside"
]

{ #category : #load }
CZLoader class >> loadCitezenPier [
	Installer ss project: 'SplitJoin';
		 install: 'SplitJoin'.
	self updatePier.
	Installer ss project: 'Citezen';
		 install: 'Citezen-Magritte';
		 install: 'Citezen-Pier'
]

{ #category : #load }
CZLoader class >> loadCitezenSeaside [
	Installer ss project: 'Citezen';
		 install: 'Citezen-Magritte';
		 install: 'Citezen-Seaside'
]

{ #category : #load }
CZLoader class >> loadSmacc [

	Installer universe install: 'SmaCC runtime'
]

{ #category : #load }
CZLoader class >> loadWithPier [
	self load.
	self loadCitezenPier.
]

{ #category : #load }
CZLoader class >> loadWithSeaside [
	self load.
	self loadCitezenSeaside
]

{ #category : #load }
CZLoader class >> updatePier [
	Installer lukas project: 'magritte';
		install: 'Magritte-Model';
		install: 'Magritte-Seaside';
		install: 'Magritte-Tests'.
	Installer lukas project: 'pier';
		install: 'Pier-Model';
		install: 'Pier-Seaside';
		install: 'Pier-Blog';
		install: 'Pier-Security';
		install: 'Pier-Squeak-Persistency';
		install: 'Pier-Tests'.
	Installer lukas project: 'pieraddons';
		install: 'Pier-Setup';
		install: 'Pier-Design';
		install: 'Pier-Documents';
		install: 'Pier-EditorEnh';
		install: 'Pier-Google';
		install: 'Pier-Randomizer';
		install: 'Pier-TagCloud';
		install: 'Pier-Titles';
		install: 'ShoutPier'.
	Installer ss project: 'Seaside';
		install: 'Seaside2.8a1';
		install: 'Scriptaculous'.

]
