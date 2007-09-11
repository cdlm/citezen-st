Class {
	#name : #BibPhraseLibraryTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'phrase',
		'renderer',
		'rendererBib',
		'phraseBib'
	],
	#category : 'Citezen-Tests'
}

{ #category : #setup }
BibPhraseLibraryTest >> setUp [
	entry := (BibEntry type: #article)
		key: #foobar;
		at: #url put: 'U';
		at: #keywords put: 'K';
		at: #fire put: 'F';
		at: #water put: 'W';
		yourself.
	phrase := BibSequencePhrase new
		addNamedFields: #(url keywords);
		add: ((BibAlternativePhrase
				rules: {
					[:e | e hasField: #here]
					-> (BibSequencePhrase new
							add: (BibLiteralPhrase text: 'HERE');
							addField: #weight;
							separatorText: '/ '; yourself)}
				default: (BibSequencePhrase new
							addFields: #(water fire);
							separatorText: '| '; yourself))
			named: 'elements');
		addNamedField: #note;
		separatorText: '!? ';
		terminatorText: '...';
		named: 'nimp'.
	renderer := (BibBblRenderer new)
]

{ #category : #testing }
BibPhraseLibraryTest >> testNewBblPhrase [
	|result|
	renderer render: phrase for: entry.
	result := renderer contents.
	self assert: result = 'U!? 
\newblock K!? 
\newblock W| F...'
]
