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
			french.
builder generate.	
		
"
Class {
	#name : #CZPillarDocBuilder,
	#superclass : #CZDecoratedDocBuilder,
	#category : 'Citezen-Reborn-DocumentBuilder'
}

{ #category : #initialize }
CZPillarDocBuilder >> extension [
	^ '.pillar'
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
