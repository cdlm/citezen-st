Class {
	#name : #CZLaTeXGeneratorTest,
	#superclass : #CZAbstractFileFormatGeneratorTest,
	#instVars : [
		'entry',
		'entry2',
		'renderer',
		'uqui2'
	],
	#category : 'Citezen-Reborn-FormattingVisitors'
}

{ #category : #setup }
CZLaTeXGeneratorTest >> setUp [
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
CZLaTeXGeneratorTest >> testArticle [
	"self debug: #testArticle"
	
	| result |
	result := (CZLaTeXGenerator new visit: entry) outputStream contents.
	self assert: result trimBoth
 = '
	\pub  \czauthors{St\''ephane Ducasse and Damien Pollet},  \cztitle{Fingerprints},  In \czjournal{Journal of Information System}, 2010.
' trimBoth
]

{ #category : #setup }
CZLaTeXGeneratorTest >> testLatexAndCharacter [
	"self debug: #testLatexAndCharacter"

	| result |
	result := (CZLaTeXGenerator new
		visit: uqui2) outputStream contents.
	self
		assert:
			(self isString: result equalsTo:
 '
	\pub  \czauthors{Mart\''in Dias and Uquillas G\''{o}mez, Ver\''onica  and Damien Cassou and St\''ephane Ducasse},  \cztitle{Software Integration Questions: A Quantitative Survey with \&}, 2014, https://hal.inria.fr/hal-01093496.
' )
]

{ #category : #setup }
CZLaTeXGeneratorTest >> testLongArticle [
	"self debug: #testLongArticle"
	
	| result |
	result := (CZLaTeXGenerator new visit: entry2) outputStream contents.

	self assert: result trimBoth= 
 '\pub  \czauthors{Hani Abdeen and Ilham Alloui and St\''ephane Ducasse and Damien Pollet and Mathieu Suen},  \cztitle{Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships},  In \czbooktitle{European Conference on Software Maintenance and Reengineering (CSMR)}, pp. 213--222, IEEE Computer Society Press, 2008, Acceptance rate: 24/87 = 27\%, http://scg.unibe.ch/archive/external/Abde08a.pdf.'
]
