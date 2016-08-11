Class {
	#name : #CZHTMLGeneratorTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'entry2',
		'renderer',
		'uqui2'
	],
	#category : #'Citezen-Reborn-FormattingVisitors'
}

{ #category : #setup }
CZHTMLGeneratorTest >> setUp [
	entry := (CZEntry type: CZEntry article)
		key: #Duca10a;
		at: #author
			put: 'St\''ephane Ducasse and Damien Pollet';
		at: CZPool title put: 'Fingerprints';
		at: CZPool journal
			put: 'Journal of Information System';
		at: CZPool year put: '2010';
		yourself.
	entry2 := (CZEntry
		type: CZEntry inproceedings)
		key: #Abde08a;
		at: #author
			put:
			'Hani Abdeen and Ilham Alloui and St\''ephane Ducasse and Damien Pollet and Mathieu Suen';
		at: CZPool title
			put:
			'Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships';
		at: #Aeres put: 'ACT';
		at: #Aeresstatus put: 'aeres08';
		at: #Annote
			put: 'internationalconference stefPub';
		at: CZPool booktitle
			put:
			'European Conference on Software Maintenance and Reengineering (CSMR)';
		at: #Inria put: 'ADAM';
		at: #Keywords put: 'moose-pub';
		at: #Location put: 'Athens, Greece';
		at: #Misc
			put: 'Acceptance rate: 24/87 = 27\%';
		at: #AcceptTotal put: 87;
		at: #AcceptNum put: 24;
		at: CZPool pages put: '213--222';
		at: CZPool publisher
			put: 'IEEE Computer Society Press';
		at: #Rate put: '27%';
		at: #Selectif put: 'oui';
		at: #Url
			put:
			'http://scg.unibe.ch/archive/external/Abde08a.pdf';
		at: CZPool year put: 2008;
		at: #'Bdsk-Url-1'
			put:
			'http://scg.unibe.ch/archive/external/Abde08a.pdf'.
	
		uqui2 := (CZBibParser
		parse:
			'	
@techreport{Dias14b,
	Annote = {technicalReport},
	Author = {Mart\''in Dias and Uquillas G\''{o}mez, Ver\''onica  and Damien Cassou and St\''ephane Ducasse},
	Hal-Id = {hal-01093496},
	Inria = {RMOD},
	Institution = {INRIA Lille},
	Keywords = {lse-pub},
	Title = {Software Integration Questions: A Quantitative Survey with \&},
	Url = {https://hal.inria.fr/hal-01093496},
	Year = {2014}}
') entries at: 1
]

{ #category : #setup }
CZHTMLGeneratorTest >> testArticle [
	"self debug: #testArticle"

	| result |
	result := (CZHTMLGenerator new
		visit: entry) outputStream contents.
	self
		assert:
			result asByteArray = 
 #[60 108 105 62 13 10 60 115 112 97 110 32 99 108 97 115 115 61 34 97 117 116 104 111 114 34 62 83 116 233 112 104 97 110 101 32 68 117 99 97 115 115 101 32 97 110 100 32 68 97 109 105 101 110 32 80 111 108 108 101 116 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 116 105 116 108 101 34 62 70 105 110 103 101 114 112 114 105 110 116 115 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 106 111 117 114 110 97 108 34 62 74 111 117 114 110 97 108 32 111 102 32 73 110 102 111 114 109 97 116 105 111 110 32 83 121 115 116 101 109 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 121 101 97 114 34 62 50 48 49 48 60 47 115 112 97 110 62 46 13 10 60 47 108 105 62 13 10]
]

{ #category : #setup }
CZHTMLGeneratorTest >> testLatexAndCharacter [
	"self debug: #testLatexAndCharacter"

	| result |
	result := (CZHTMLGenerator new
		visit: uqui2) outputStream contents.
	self
		assert:
			result asByteArray = 
 #[60 108 105 62 13 10 60 115 112 97 110 32 99 108 97 115 115 61 34 97 117 116 104 111 114 34 62 77 97 114 116 237 110 32 68 105 97 115 44 32 86 101 114 243 110 105 99 97 32 85 113 117 105 108 108 97 115 32 71 243 109 101 122 44 32 68 97 109 105 101 110 32 67 97 115 115 111 117 32 97 110 100 32 83 116 233 112 104 97 110 101 32 68 117 99 97 115 115 101 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 116 105 116 108 101 34 62 83 111 102 116 119 97 114 101 32 73 110 116 101 103 114 97 116 105 111 110 32 81 117 101 115 116 105 111 110 115 58 32 65 32 81 117 97 110 116 105 116 97 116 105 118 101 32 83 117 114 118 101 121 32 119 105 116 104 32 38 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 121 101 97 114 34 62 50 48 49 52 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 117 114 108 34 62 60 97 32 104 114 101 102 61 34 104 116 116 112 115 58 47 47 104 97 108 46 105 110 114 105 97 46 102 114 47 104 97 108 45 48 49 48 57 51 52 57 54 34 62 80 68 70 60 47 97 62 60 47 115 112 97 110 62 46 13 10 60 47 108 105 62 13 10]
]

{ #category : #setup }
CZHTMLGeneratorTest >> testLongArticle [
	"self debug: #testLongArticle"

	| result |
	result := (CZHTMLGenerator new
		visit: entry2) outputStream contents.
	self
		assert:
			result asByteArray = 
 #[60 108 105 62 13 10 60 115 112 97 110 32 99 108 97 115 115 61 34 97 117 116 104 111 114 34 62 72 97 110 105 32 65 98 100 101 101 110 44 32 73 108 104 97 109 32 65 108 108 111 117 105 44 32 83 116 233 112 104 97 110 101 32 68 117 99 97 115 115 101 44 32 68 97 109 105 101 110 32 80 111 108 108 101 116 32 97 110 100 32 77 97 116 104 105 101 117 32 83 117 101 110 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 116 105 116 108 101 34 62 80 97 99 107 97 103 101 32 82 101 102 101 114 101 110 99 101 32 70 105 110 103 101 114 112 114 105 110 116 58 32 97 32 82 105 99 104 32 97 110 100 32 67 111 109 112 97 99 116 32 86 105 115 117 97 108 105 122 97 116 105 111 110 32 116 111 32 85 110 100 101 114 115 116 97 110 100 32 80 97 99 107 97 103 101 32 82 101 108 97 116 105 111 110 115 104 105 112 115 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 98 111 111 107 116 105 116 108 101 34 62 69 117 114 111 112 101 97 110 32 67 111 110 102 101 114 101 110 99 101 32 111 110 32 83 111 102 116 119 97 114 101 32 77 97 105 110 116 101 110 97 110 99 101 32 97 110 100 32 82 101 101 110 103 105 110 101 101 114 105 110 103 32 40 67 83 77 82 41 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 112 97 103 101 115 34 62 50 49 51 45 45 50 50 50 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 112 117 98 108 105 115 104 101 114 34 62 73 69 69 69 32 67 111 109 112 117 116 101 114 32 83 111 99 105 101 116 121 32 80 114 101 115 115 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 121 101 97 114 34 62 50 48 48 56 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 109 105 115 99 34 62 65 99 99 101 112 116 97 110 99 101 32 114 97 116 101 58 32 50 52 47 56 55 32 61 32 50 55 37 60 47 115 112 97 110 62 44 32 60 115 112 97 110 32 99 108 97 115 115 61 34 117 114 108 34 62 60 97 32 104 114 101 102 61 34 104 116 116 112 58 47 47 115 99 103 46 117 110 105 98 101 46 99 104 47 97 114 99 104 105 118 101 47 101 120 116 101 114 110 97 108 47 65 98 100 101 48 56 97 46 112 100 102 34 62 80 68 70 60 47 97 62 60 47 115 112 97 110 62 46 13 10 60 47 108 105 62 13 10] 
]
