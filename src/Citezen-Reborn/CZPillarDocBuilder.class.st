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
			  #misc
			#doi
			#url	) ""removed doi and url since they may contain _ and the generator does not handle that well for the moment."".
	builder generate.	
		
"
Class {
	#name : #CZPillarDocBuilder,
	#superclass : #CZDecoratedDocBuilder,
	#category : #'Citezen-Reborn-DocumentBuilder'
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
	self noHeader.
	self setFilteringOn.
]
