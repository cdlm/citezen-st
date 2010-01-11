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
	self loadPierRequirements.
	"Not needed with latext Pharo/Pier images"
	"Installer ss project: 'Pharo';
		install: 'Collections-Unordered'.
	Installer ss project: 'SplitJoin';
		 install: 'SplitJoin'."
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
CZLoader class >> loadPierRequirements [
	"Need PRStructure>>lookupPath:"
	Installer lukas project: 'pier'; install: 'Pier-Model'.
	"Need PRPierFrame>>structureFrom:"
	Installer lukas project: 'pier'; install: 'Pier-Seaside'.
	"Need MAExternalFileModel>>urlFor:"
	Installer lukas project: 'magritte'; install: 'Magritte-Model'.
	Installer lukas project: 'magritte'; install: 'Magritte-Seaside'
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
	"self updatePier"
	Installer lukas project: 'pieraddons'; install: 'Pier-Setup'.
	PRDistribution update.

]
