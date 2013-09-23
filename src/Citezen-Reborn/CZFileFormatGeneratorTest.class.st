"
a bunch of tests
"
Class {
	#name : #CZFileFormatGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'entry2',
		'bibset'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #setUp }
CZFileFormatGeneratorTest >> generatorClass [
	^ CZFileFormatGenerator 
]

{ #category : #setUp }
CZFileFormatGeneratorTest >> setUp [
	
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
				yourself).
	bibset addEntry: ((CZEntry type: CZEntry book)
					key: #Duca10a;
					at: #author put: 'St\''ephane Ducasse';
					at: CZPool title put: 'Botsinc: Learning programming in Squeak';
					at: CZPool journal put: 'Apress';
					at: CZPool year put: '2005';
				yourself).
]

{ #category : #setUp }
CZFileFormatGeneratorTest >> testFieldOrderShouldBeRespected [
	"self debug: #testFieldOrderShouldBeRespected"
	
	| visitor |
	visitor := self generatorClass new.
	visitor fieldOrder: #(author #title).
	visitor visit: entry.
	
	self assert: (visitor outputStream contents = 'Ducasse, St\''ephane and Pollet, Damien, Fingerprints.
' )
]

{ #category : #setUp }
CZFileFormatGeneratorTest >> testSet [
	"self debug: #testSet"
	
	| visitor |
	visitor := self generatorClass new.
	visitor visit: bibset.
	self assert: (visitor outputStream contents =  '
Ducasse, St\''ephane and Ducasse, Florence, La maledication de la fille de la femme crocodile, Journal of Hatred, 2012.
Ducasse, St\''ephane, Botsinc: Learning programming in Squeak, Apress, 2005.

'  ).
]

{ #category : #setUp }
CZFileFormatGeneratorTest >> testVisitingDocumentWithSectionShouldProduceSections [
	"self debug: #testVisitingDocumentWithSectionShouldProduceSections"
	
	| visitor |
	visitor := self generatorClass new.
	visitor visit: CZDocBuilderTest aDoc.
	self assert: (visitor outputStream contents = '
Refereed Articles in International Journals
Abdeen, Hani and Ducasse, St\''ephane and Pollet, Damien and Alloui, Ilham, Package Fingerprint: a visual summary of package interfaces and relationships, Information and Software Technology Journal, 52, 1312-1330, 2010, ISI impact factor 1.821 (2010), http://rmod.lille.inria.fr/archives/papers/Abde10a-IST-Official-packageFingerprints.pdf, 10.1016/j.infsof.2010.07.005.
Ducasse, St\''ephane and Ranger, Zork, Woa, Journal of Information System, 2010, obsoleteData.pdf.

Refereed Articles in International Conferences
Denker, Marcus and Suen, Mathieu and Ducasse, St\''ephane, The Meta in Meta-object Architectures, Proceedings of TOOLS EUROPE 2008, 11, 218--237, Springer-Verlag, 2008, http://scg.unibe.ch/archive/papers/Denk08bMetaContextLNBIP.pdf, 10.1007/978-3-540-69824-1_13.

')
]
