"
Generate pillar descriptions

self build
"
Class {
	#name : #CZPillarSingleAuthorDocBuilder,
	#superclass : #CZNewSingleAuthorDocBuilder,
	#category : #'Citezen-Reborn'
}

{ #category : #'as yet unclassified' }
CZPillarSingleAuthorDocBuilder class >> build [
	"self build"
	| builder |
	builder :=  self new
		french; 
		fileNamed: 'rmod.bib';
		setFilteringOn;
		yourself.
	builder generate.
]

{ #category : #initialize }
CZPillarSingleAuthorDocBuilder >> extension [

	^ '-Full.pillar'
]

{ #category : #initialize }
CZPillarSingleAuthorDocBuilder >> generatorClass [
	^ CZPillarGenerator 
]

{ #category : #initialize }
CZPillarSingleAuthorDocBuilder >> initialize [
	super initialize.
	noHeader := true.
]
