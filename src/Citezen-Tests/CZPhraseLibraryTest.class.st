Class {
	#name : #CZPhraseLibraryTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'phrase',
		'renderer',
		'rendererBib',
		'phraseBib'
	],
	#category : #'Citezen-Tests'
}

{ #category : #setup }
CZPhraseLibraryTest >> setUp [
	entry := (CZEntry type: #article)
				key: #foobar;
				at: #url put: 'U';
				at: #keywords put: 'K';
				at: #fire put: 'F';
				at: #water put: 'W';
				yourself.
	phrase := (BibSequencePhrase new)
				addBlockWithField: #url;
				addBlockWithField: #keywords;
				add: ((BibAlternativePhrase rules: { 
									([:e | e hasField: #here] -> ((BibSequencePhrase new)
												add: (BibLiteralPhrase text: 'HERE');
												addField: #weight;
												separatorText: '/ ';
												yourself))}
							default: ((BibSequencePhrase new)
									addFields: #(#water #fire );
									separatorText: '| ';
									yourself)) 
								named: 'elements');
				addBlockWithField: #note;
				separatorText: '!? ';
				terminatorText: '...';
				named: 'nimp'.
	renderer := BibBblRenderer new
]

{ #category : #testing }
CZPhraseLibraryTest >> testNewBblPhrase [
	|result|
	renderer render: phrase for: entry.
	result := renderer contents.
	self assert: result = 'U!? 
\newblock K!? 
\newblock W| F...'
]