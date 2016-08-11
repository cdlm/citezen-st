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
	^ '.pillar'
]

{ #category : #utils }
CZPillarNewDocBuilder >> generatorClass [
	^ CZPillarGenerator 
]

{ #category : #initialize }
CZPillarNewDocBuilder >> initialize [
	super initialize.
	self noHeader.
]
