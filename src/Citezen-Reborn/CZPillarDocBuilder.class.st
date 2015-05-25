"
Generate pillar descriptions

!!Supported features

- keysOfBlackListedEntries:
- fileNamed: 'rmod.bib';
- authorMatchingString:
- fieldOrder:

!! Example

| builder |
builder := self new
		fileNamed: 'rmod.bib';
		authorMatchingString: '*Ducasse*';
		french; 
		fieldOrder: #(#author 
			  #title 
			  #journal 
			  #booktitle 
			  #volume 
			  #pages 
			  #publisher  
			  #year 
			  #school
			  #impactfactor 
			  #misc); ""removed doi and url since they may contain _ and the generator does not handle that well for the moment.""
		setFilteringOn.
	builder generate.	
		
"
Class {
	#name : #CZPillarDocBuilder,
	#superclass : #CZDecoratedDocBuilder,
	#category : #'Citezen-Reborn'
}

{ #category : #initialize }
CZPillarDocBuilder >> extension [

	^ '-Full.pillar'
]

{ #category : #initialize }
CZPillarDocBuilder >> generatorClass [
	^ CZPillarGenerator 
]

{ #category : #initialize }
CZPillarDocBuilder >> initialize [
	super initialize.
	noHeader := true.
]
