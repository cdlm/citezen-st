Class {
	#name : #CitezenLoader,
	#superclass : #Object,
	#category : #'Citezen-Loader'
}

{ #category : #'as yet unclassified' }
CitezenLoader class >> load [
	"self load"
	ScriptLoader new installingInstaller.
	ScriptLoader new installingUniverse.
	Smalltalk at: #Installer ifPresent: [:each | each ss project: 'Rio'; install: 'Rio-Kernel'; install: 'Rio-Grande'].
	self loadSmacc.
	self loadCitezen
]

{ #category : #'as yet unclassified' }
CitezenLoader class >> loadForPier12Image [
	"self loadForPier12Image"

	Gofer new 
		squeaksource: 'Rio'; 
		version: 'Rio-Kernel-razavi_acm_org.89'; 
		version: 'Rio-Grande-kph.45'; load.
	Gofer
		new
		squeaksource: 'SmaccDevelopment';
		version: 'SmaCC-lr.13'; load.
	Gofer
		new
		squeaksource: 'Citezen';
		package: 'Citezen-All'; load.					"load all the core not the pier related integration "
	Gofer
		new
		squeaksource: 'Citezen';
		package: 'Citezen-All'; load.	
		
	Gofer
		new
		squeaksource:'Citezen';
		 package: 'Citezen-Magritte';
		 package: 'Citezen-Pier'; load
]
