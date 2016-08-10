Class {
	#name : #CZEntryTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'duplicateEntry',
		'articleEntry',
		'inproceedingsEntry',
		'masterEntry',
		'team',
		'dirty',
		'uqui'
	],
	#category : #'Citezen-Tests'
}

{ #category : #setup }
CZEntryTest >> setUp [

	entry := (CZBibParser parse: CZTestResource bibTest) entries at: 1.
	duplicateEntry := (CZBibParser parse: CZTestResource bibTest) entries at: 1.
	articleEntry := CZBibParser parse: '	@article{Herm00a,
 author = {Herman, Ivan and Melan\c{c}on, Guy and Marshall, M. Scott},
 title = {Graph Visualization and Navigation in Information Visualization: A Survey},
 journal = {IEEE Transactions on Visualization and Computer Graphics},
 volume = {6},
 number = {1},
 year = {2000},
 issn = {1077-2626},
 pages = {24--43},
 doi = {10.1109/2945.841119},
 publisher = {IEEE Educational Activities Department},
 address = {Piscataway, NJ, USA}
 }'.

inproceedingsEntry := (CZBibParser parse: '	
@inproceedings{Nier04d,
  Abstract     = {In this paper we briefly review various kinds of
                  software changes and the issues that arise from
                  them. As a consequence, we propose research into
                  programming languages with explicit support for
                  representing first-class changes, and for
                  manipulating and merging multiple viewpoints of
                  evolving software systems.},
  Annote       = {internationalworkshop},
  Author       = {Oscar Nierstrasz and Marcus Denker},
  Booktitle    = {OOPSLA Workshop on Revival of Dynamic Languages},
  Cvs	       = {RDLchange},
  Keywords     = {snf05 scg-pub skip-doi jb05 pharo fromscgbib},
  Month	       = oct,
  Title	       = {Supporting Software Change in the Programming
                  Language},
  Url	       =
                  {http://rmod.lille.inria.fr/archives/workshops/Nier04d-RDL04-Change.pdf},
  Year	       = {2004}
}') entries at: 1.

masterEntry := (CZBibParser parse: '	
@mastersthesis{Peirs08a,
  author       = {Romain Peirs},
  title	       = {Enhanced Dependency Structure Matrix},
  year	       = {2008},
  abstract     = {Dependency Structure Matrix (DSM) is an approach taken from
                  process optimization and it exists a variety of algorithms
                  to help organizing the matrix in a form that reflects the
                  architecture and highlights patterns and problematic
                  dependencies. However, the existing DSM implementations have
                  a lack of information in their visualization. That is why, we
                  enhanced DSM by adding written and colored information in the
                  visualization to improve the architecture understanding of a
                  software system and the support of its remodularization. This
                  visualization has been implemented on top of Moose which is a
                  collaborative research platform for Software Analysis and
                  Information Visualization. This report presents my
                  internship done at the research centre INRIA Lille - Nord
                  Europe with the RMoD Team led by S. Ducasse.},
  annote       = {master cook},
  school       = {Enseita}
 }') entries at: 1.

				
dirty := (CZEntry type: CZEntry inproceedings)
				key: #Abde08a;
				at: #author put: 'Hani Abdeen and Ilham Alloui and St\''ephane Ducasse and Damien Pollet and Mathieu Suen';
				at: #title put: 'Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships';
				at: #Aeres	 put: 'ACT';
				at: #'Hal-ID' put: 'hal-01344842}';
 				at: #Aeresstatus   put:  'aeres08';
				at: #Annote       put:  'internationalconference stefPub';
 				at: #Booktitle    put: 'European Conference on Software Maintenance and Reengineering (CSMR)';
  				at: #Inria	        put: 'ADAM';
  				at: #Keywords     put:  'moose-pub';
  				at: #Location     put: 'Athens, Greece';
  				at: #Misc	       put:  'Acceptance rate: 24/87 = 27\%';
  				at: #AcceptTotal  put:  87;
  				at: #AcceptNum    put:  24;
  				at: #Pages	       put:  '213--222';
  				at: #Publisher    put:  'IEEE Computer Society Press';
  				at: #Rate	       put:  '27%';
  				at: #Selectif     put:  'oui';
   				at: #Url	       put:  'http://scg.unibe.ch/archive/external/Abde08a.pdf';
   				at: #Year	       put:  2008;
   				at: #'Bdsk-Url-1'  put: 'http://scg.unibe.ch/archive/external/Abde08a.pdf';
				at: #'Date-Added' put: '{2009-10-20 14:54:13 +0200}';
				at: #'Date-Modified' put: '{2009-10-20 15:05:13 +0200}'.


uqui := (CZBibParser parse: '	
@techreport{Dias14b,
	Annote = {technicalReport},
	Author = {Mart\''in Dias and Ver\''onica Uquillas-Gomez and Damien Cassou and St\''ephane Ducasse},
	Hal-Id = {hal-01093496},
	Inria = {RMOD},
	Institution = {INRIA Lille},
	Keywords = {lse-pub},
	Title = {Software Integration Questions: A Quantitative Survey},
	Url = {https://hal.inria.fr/hal-01093496},
	Year = {2014}}
') entries at: 1.
				

]

{ #category : #setup }
CZEntryTest >> tearDown [
	entry := nil.
	duplicateEntry := nil
]

{ #category : #tests }
CZEntryTest >> testAddToBibSet [
	| bibset |
	
	bibset := CZSet new.
	bibset addEntry: entry.
	
	self assert: ((bibset entries at:1) == entry).
	self assert: (entry scope == bibset).
	
]

{ #category : #tests }
CZEntryTest >> testAt [
	self assert: ((entry at:#pages) class = CZField).
	self assert: ((entry at:#absent) class = CZUndefinedField).
	self assert: (entry at:#absent ifAbsent:'a pas' = 'a pas').
	
]

{ #category : #tests }
CZEntryTest >> testAuthorAccess [
	"self debug: #testAuthorAccess"

	self assert: dirty author class = CZField.
	self assert: dirty author valueClass = CZPeople.
	self assert: dirty author rawValueObject class = CZPeople.
	self assert: dirty author rawValue class = ByteString
]

{ #category : #tests }
CZEntryTest >> testClean [
	"self debug: #testClean"

	self assert: (dirty  hasField: #aeres).
	self assert: (dirty  hasField: #aeresstatus).
	self assert: (dirty  hasField: #'bdsk-url-1').
	self assert: (dirty  hasField: #'date-added').
	self assert: (dirty  hasField: #'date-modified').
	dirty clean.
	self deny: (dirty hasField: #'date-added').
	self deny: (dirty hasField: #'date-modified').
	self deny: (dirty hasField: #'bdsk-url-1').
	CZEntry fieldKeysToRemove
		do: [ :each | self deny: (dirty hasFieldWithKey: each)].

]

{ #category : #tests }
CZEntryTest >> testCompactName [
	"self debug: #testCompactName"

	self assert: dirty author rawValueObject people first compactLastName = 'Abdeen'.
	self assert: uqui author rawValueObject people second compactLastName = 'Uquillas-Gomez'.
]

{ #category : #tests }
CZEntryTest >> testFieldSorted [
	"self debug: #testFieldSorted"

	| res |
	res := dirty fieldSortedFollowingKeys: #(#author #title #annote #booktitle #location #misc #accepttotal #acceptnum #pages #publisher #rate  #url #year).
	self assert: res size = #(#author #title #annote #booktitle #location #misc #accepttotal #acceptnum #pages #publisher #rate  #url #year) size.
	

	res := dirty fieldSortedFollowingKeys: #(#ZORKTHEGREAT #title #annote #booktitle #location #misc #accepttotal #acceptnum #pages #publisher #rate  #url #year).
	self assert: res size = #(#title #annote #booktitle #location #misc #accepttotal #acceptnum #pages #publisher #rate  #url #year) size.
	
]

{ #category : #tests }
CZEntryTest >> testHasField [
	self assert: (entry hasField: #author).
	self assert: (entry hasField: #title).
	self assert: (entry hasField: #pages).
	self deny: (entry hasField: #anotherField).
	self deny: (entry hasField: '').
]

{ #category : #tests }
CZEntryTest >> testKeepFields [
	"self debug: #testKeepFields"
	
	self assert: (dirty  hasField: #aeres).
	self assert: (dirty  hasField: #aeresstatus).
	self assert: (dirty  hasField: #'bdsk-url-1').
	self assert: (dirty  hasField: #'date-added').
	self assert: (dirty  hasField: #'date-modified').
	dirty keepFields: #(#aeres #'bdsk-url-1').
	self assert: (dirty  hasField: #aeres).
	self deny: (dirty hasField: #author).
	self deny: (dirty  hasField: #aeresstatus).
	self assert: (dirty  hasField: #'bdsk-url-1').
	self deny: (dirty  hasField: #'date-added').
	self deny: (dirty  hasField: #'date-modified').
	


]

{ #category : #tests }
CZEntryTest >> testKey [
	self assert: (entry key = #testUnpublished).
	entry key: #test.
	self assert: (entry key = #test)
]

{ #category : #tests }
CZEntryTest >> testKeywords [
	"self debug: #testKeywords"
	
	| keywords |
	self assert: (inproceedingsEntry hasField: #author).
	keywords := inproceedingsEntry at: #keywords.
	self assert: keywords value = 'snf05 scg-pub skip-doi jb05 pharo fromscgbib'.
	self assert: inproceedingsEntry isPharoPub

]

{ #category : #tests }
CZEntryTest >> testMacroReferences [
	self assert: (entry macroReferences size = 1).
	entry at: #macro put:#MACRO.
	self assert: (entry macroReferences size = 2)
]

{ #category : #tests }
CZEntryTest >> testMoveToBibSet [
	| bibsetFrom bibsetTo |
	bibsetFrom := CZSet new.
	bibsetTo := CZSet new.
	
	entry addToBibSet: bibsetFrom.
	entry moveToBibSet: bibsetTo.
	
	self assert: (bibsetFrom entries size = 0).
	self assert: (bibsetTo entries size = 1).
	self assert: (entry scope == bibsetTo).
	
]

{ #category : #tests }
CZEntryTest >> testPeople [
	"self debug: #testPeople"

	self assert: dirty author rawValueObject people class = OrderedCollection.
	self assert: dirty author rawValueObject people first class = CZAuthor.
]

{ #category : #tests }
CZEntryTest >> testPredefinedAccess [
	"self debug: #testPredefinedAccess"
	
	
]

{ #category : #tests }
CZEntryTest >> testRemoveField [
	"self debug: #testRemoveField"
	
	self assert: (dirty  hasField: #aeres).
	self assert: (dirty  hasField: #aeresstatus).
	self assert: (dirty  hasField: #'bdsk-url-1').
	self assert: (dirty  hasField: #'date-added').
	self assert: (dirty  hasField: #'date-modified').
	dirty removeFieldWithKey: #aeres.
	self deny: (dirty  hasField: #aeres).
	self assert: (dirty  hasField: #aeresstatus).
	self assert: (dirty  hasField: #'bdsk-url-1').
	self assert: (dirty  hasField: #'date-added').
	self assert: (dirty  hasField: #'date-modified').
	


]

{ #category : #tests }
CZEntryTest >> testRemoveFields [
	"self debug: #testRemoveFields"
	
	self assert: (dirty  hasField: #aeres).
	self assert: (dirty  hasField: #aeresstatus).
	self assert: (dirty  hasField: #'bdsk-url-1').
	self assert: (dirty  hasField: #'date-added').
	self assert: (dirty  hasField: #'date-modified').
	dirty removeFields: #(#aeres #'bdsk-url-1').
	self deny: (dirty  hasField: #aeres).
	self assert: (dirty  hasField: #aeresstatus).
	self deny: (dirty  hasField: #'bdsk-url-1').
	self assert: (dirty  hasField: #'date-added').
	self assert: (dirty  hasField: #'date-modified').
	


]

{ #category : #tests }
CZEntryTest >> testShortenedName [
	"self debug: #testShortenedName"

	self assert: dirty author rawValueObject useDisplayShortenedName expanded = 'H. Abdeen, I. Alloui, S. Ducasse, D. Pollet and M. Suen'.
	self assert: dirty author rawValueObject shortenedName = 'H. Abdeen, I. Alloui, S. Ducasse, D. Pollet and M. Suen'.
]

{ #category : #tests }
CZEntryTest >> testSize [
	| entrySize |
	entrySize := 0.
	entry do: [:each | entrySize := entrySize+1].
	
	self assert: (entry size = entrySize).
	entry at:#nonRenseigne put:'maintenant, si'.
	self assert: (entry size = (entrySize+1))
]

{ #category : #tests }
CZEntryTest >> testType [
	self assert: (entry type = #unpublished).
	entry type: #test.
	self assert: (entry type = #test)
]
