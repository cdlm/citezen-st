"
| visitor bibset |
bibset := CZBibParser parse: (FileStream readOnlyFileNamed: 'rmod.bib') contents.
bibset scope: CZSet standardDefinitions.
visitor := CZBblGenerator new.
visitor 
	fieldOrder: #(#author  #title  #journal  #booktitle #volume 
			  #pages   #publisher   #year   #school   #impactfactor 
			  #doi #url #hald-id); 
	filename: 'rmod.bbl'.
visitor visit: bibset.
"
Class {
	#name : #CZBblGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'entry2',
		'renderer',
		'bibset'
	],
	#category : #'Citezen-Reborn-FormattingVisitors'
}

{ #category : #'as yet unclassified' }
CZBblGeneratorTest >> generatorClass [
	^ CZBblGenerator 
]

{ #category : #'as yet unclassified' }
CZBblGeneratorTest >> setUp [
	
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
				at: #'Hal-Id'	put: 'hal-1234';
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
				yourself).
	bibset addEntry: ((CZEntry type: CZEntry book)
					key: #Duca10a;
					at: #author put: 'St\''ephane Ducasse';
					at: CZPool title put: 'Botsinc: Learning programming in Squeak';
					at: CZPool journal put: 'Apress';
					at: CZPool year put: '2005';
				yourself).
]

{ #category : #'as yet unclassified' }
CZBblGeneratorTest >> testOneEntry [
	"self debug: #testOneEntry"
	
	| visitor |
	visitor := self generatorClass new.
	visitor fieldOrder: #(#author #title #chapter #journal #booktitle #volume #pages #publisher #school #year #url #doi).
	visitor visit: entry2.
	self halt. 
	self assert: (visitor outputStream contents = 
 'Ducasse, St\''ephane and Pollet, Damien, Fingerprints.

' )
]

{ #category : #'as yet unclassified' }
CZBblGeneratorTest >> testStarted [
	"self debug: #testStarted"
	
	| visitor |
	visitor := self generatorClass new.
	visitor fieldOrder: #(#author #title #chapter #journal #booktitle #volume #pages #publisher #school #year #url #doi).
	visitor visit: entry2.
	self halt. 
	self assert: (visitor outputStream contents = 
 'Ducasse, St\''ephane and Pollet, Damien, Fingerprints.

' )
]
