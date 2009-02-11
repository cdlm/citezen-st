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
		package: 'Citezen-All'
	
	"Citezen-Seaside"
]

{ #category : #load }
CZLoader class >> loadSmacc [

	Installer universe install: 'SmaCC runtime'
]
