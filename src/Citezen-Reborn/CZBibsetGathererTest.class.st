Class {
	#name : #CZBibsetGathererTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'entry2',
		'bibset'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #setup }
CZBibsetGathererTest >> setUp [
	
	bibset := CZSet new.
	entry := (CZEntry type: CZEntry article)
				key: #Duca10a;
				at: #author put: 'St\''ephane Ducasse and Damien Pollet';
				at: CZPool title put: 'Fingerprints';
				at: CZPool journal put: 'Journal of Information System';
				at: CZPool year put: '2010';
				yourself.
	entry2 := (CZEntry type: CZEntry inproceedings)
				key: #Abde08a;
				at: #author put: 'Hani Abdeen and Ilham Alloui and St\''ephane Ducasse and Damien Pollet and Mathieu Suen';
				at: CZPool title put: 'Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships';
				at: #Aeres	 put: 'ACT';
 				at: #Aeresstatus   put:  'aeres08';
				at: #Annote       put:  'internationalconference stefPub';
 				at: CZPool booktitle    put: 'European Conference on Software Maintenance and Reengineering (CSMR)';
  				at: #Inria	        put: 'ADAM';
  				at: #Keywords     put:  'moose-pub';
  				at: #Location     put: 'Athens, Greece';
  				at: #Misc	       put:  'Acceptance rate: 24/87 = 27\%';
  				at: #AcceptTotal  put:  87;
  				at: #AcceptNum    put:  24;
  				at: CZPool pages	       put:  '213--222';
  				at: CZPool publisher    put:  'IEEE Computer Society Press';
  				at: #Rate	       put:  '27%';
  				at: #Selectif     put:  'oui';
   				at: #Url	       put:  'http://scg.unibe.ch/archive/external/Abde08a.pdf';
   				at: CZPool year	       put:  2008;
   				at: #'Bdsk-Url-1'  put: 'http://scg.unibe.ch/archive/external/Abde08a.pdf'.
	bibset addEntry: ((CZEntry type: CZEntry article)
					key: #Duca12a;
					at: #author put: 'St\''ephane Ducasse and Florence Ducasse';
					at: CZPool title put: 'La maledication de la fille de la femme crocodile';
					at: CZPool journal put: 'Journal of Hatred';
					at: CZPool year put: '2012';
				yourself)
]

{ #category : #setup }
CZBibsetGathererTest >> testEntry [
	"self debug: #testEntry"
	
	| visitor |
	visitor := CZBibsetGatherer new.
	self assert: visitor bibset size isZero.	
	visitor visit: entry.
	self assert: visitor bibset size = 1.			
	
]

{ #category : #setup }
CZBibsetGathererTest >> testSet [
	"self debug: #testSet"
	
	| visitor |
	visitor := CZBibsetGatherer new.
	self assert: visitor bibset size isZero.	
	visitor visit: bibset.
	visitor visit: entry.
	visitor visit: entry2.
	self assert: visitor bibset size = 3.			
	
]

{ #category : #setup }
CZBibsetGathererTest >> testTwoEntries [
	"self debug: #testEntries"
	
	| visitor |
	visitor := CZBibsetGatherer new.
	self assert: visitor bibset size isZero.	
	visitor visit: entry.
	visitor visit: entry2.
	self assert: visitor bibset size = 2.			
	
]
