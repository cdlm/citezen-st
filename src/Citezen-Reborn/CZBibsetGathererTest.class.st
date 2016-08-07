"
A CZBibsetGathererTest is a test suite
"
Class {
	#name : #CZBibsetGathererTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'entry2',
		'bibset'
	],
	#category : #'Citezen-Reborn-Core-Visitor'
}

{ #category : #setup }
CZBibsetGathererTest >> Abde08a [
	^  (CZEntry type: CZEntry inproceedings)
		key: #Abde08a;
		at: #author put: 'Hani Abdeen and Ilham Alloui and St\''ephane Ducasse and Damien Pollet and Mathieu Suen';
		at: CZPool title
			put: 'Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships';
		at: #Aeres put: 'ACT';
		at: #Aeresstatus put: 'aeres08';
		at: #Annote put: 'internationalconference stefPub';
		at: CZPool booktitle put: 'European Conference on Software Maintenance and Reengineering (CSMR)';
		at: #Inria put: 'ADAM';
		at: #Keywords put: 'moose-pub';
		at: #Location put: 'Athens, Greece';
		at: #Misc put: 'Acceptance rate: 24/87 = 27\%';
		at: #AcceptTotal put: 87;
		at: #AcceptNum put: 24;
		at: CZPool pages put: '213--222';
		at: CZPool publisher put: 'IEEE Computer Society Press';
		at: #Rate put: '27%';
		at: #Selectif put: 'oui';
		at: #Url put: 'http://scg.unibe.ch/archive/external/Abde08a.pdf';
		at: CZPool year put: 2008;
		at: #'Bdsk-Url-1' put: 'http://scg.unibe.ch/archive/external/Abde08a.pdf'
]

{ #category : #setup }
CZBibsetGathererTest >> Duca10a [
	^ (CZEntry type: CZEntry article)
		key: #Duca10a;
		at: #author put: 'St\''ephane Ducasse and Damien Pollet';
		at: CZPool title put: 'Fingerprints';
		at: CZPool journal put: 'Journal of Information System';
		at: CZPool year put: '2010';
		yourself
]

{ #category : #setup }
CZBibsetGathererTest >> Duca12a [
	^ (CZEntry type: CZEntry article)
		key: #Duca12a;
		at: #author put: 'St\''ephane Ducasse and Florence Ducasse';
		at: CZPool title put: 'La maledication de la fille de la femme crocodile';
		at: CZPool journal put: 'Journal of Hatred';
		at: CZPool year put: '2012';
		yourself
]

{ #category : #setup }
CZBibsetGathererTest >> setUp [
	bibset := CZSet new.
	entry := self Duca10a.
	entry2 := self Abde08a.
	bibset addEntry: self Duca12a
]

{ #category : #tests }
CZBibsetGathererTest >> testCreatedVisitorHasAnEmptyBibSet [
	"self debug: #testCreatedVisitorHasAnEmptyBibSet"
	
	| visitor |
	visitor := CZBibsetGatherer new.
	self assert: visitor bibset size isZero.	
	self deny: visitor hasEntries.
	
]

{ #category : #tests }
CZBibsetGathererTest >> testTwoEntriesOneAfterTheOneCollectThem [
	"self debug: #testTwoEntriesOneAfterTheOneCollectThem"
	
	| visitor |
	visitor := CZBibsetGatherer new.
	self assert: visitor bibset size isZero.	
	visitor visit: entry.
	visitor visit: entry2.
	self assert: visitor bibset size = 2.			
	
]

{ #category : #tests }
CZBibsetGathererTest >> testVisitingASetVisitItsElements [
	"self debug: #testVisitingASetVisitItsElements"
	
	| visitor |
	visitor := CZBibsetGatherer new.
	self deny: visitor hasEntries.	
	visitor visit: bibset.
	visitor visit: entry.
	visitor visit: entry2.
	self assert: visitor numberOfEntries = 3.			
	
]

{ #category : #tests }
CZBibsetGathererTest >> testVisitingASetWithMoreElementsVisitItsElements [
	"self debug: #testVisitingASetWithMoreElementsVisitItsElements"
	
	| visitor |
	visitor := CZBibsetGatherer new.
	self deny: visitor hasEntries.	
	bibset addEntry: entry; addEntry: entry2.
	self assert: bibset size = 3.
	visitor visit: bibset.
	self assert: visitor numberOfEntries = 3.			
	
]

{ #category : #tests }
CZBibsetGathererTest >> testVisitingOneEntryIncreasesTheBibSetByOne [
	"self debug: #testVisitingOneEntryIncreasesTheBibSetByOne"
	
	| visitor |
	visitor := CZBibsetGatherer new.
	self assert: visitor bibset size isZero.	
	visitor visit: entry.
	self assert: visitor bibset size = 1.			
	
]
