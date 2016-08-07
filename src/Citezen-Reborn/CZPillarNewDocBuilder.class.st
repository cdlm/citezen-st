"
Generate pillar descriptions. Should replaced (and be renamed into CZPillarDocBuilder)

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
			 #url
			  #doi); 
		setFilteringOn.
	builder generate.	
		
"
Class {
	#name : #CZPillarNewDocBuilder,
	#superclass : #CZDecoratedDocBuilder,
	#category : #'Citezen-Reborn-DocumentBuilder'
}

{ #category : #generate }
CZPillarNewDocBuilder >> extension [

	^ '-Full.pillar'
]

{ #category : #utils }
CZPillarNewDocBuilder >> generatorClass [
	^ CZPillarNewGenerator 
]

{ #category : #initialize }
CZPillarNewDocBuilder >> initialize [
	super initialize.
	self noHeader.
]
