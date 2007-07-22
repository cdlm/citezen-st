Class {
	#name : #BibPhraseLibrary,
	#superclass : #Object,
	#instVars : [
		'phrases'
	],
	#classInstVars : [
		'defaultInstance'
	],
	#category : #'Citezen-Rendering'
}

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> article [
	^ BibSequencePhrase new
		addNamedFields: #(author title);
		add: ((BibAlternativePhrase
				rules: {
					[:e | e hasField: #crossref]
					-> (BibSequencePhrase new
							add: (BibLiteralPhrase text: 'CROSSREF');
							addField: #pages;
							separatorText: ', '; yourself)}
				default: (BibSequencePhrase new
							addField: #journal;
							add: self volumeNumber;
							add: self pages;
							add: self monthYear;
							initiatorText: 'In '; separatorText: ', '; yourself))
			named: 'publishing');
		addNamedField: #note;
		separatorText: '. '; terminatorText: '.';
		named: 'article'
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> book [
	^ BibSequencePhrase new
		addNamedField: #author;
		add: self editor;
		add: ((BibAlternativePhrase
				rules: {
					[:e | e hasField: #crossref]
					-> (BibSequencePhrase new
							add: (BibLiteralPhrase text: 'CROSSREF');
							addField: #pages;
							separatorText: ', '; yourself)}
				default: (BibSequencePhrase new
							addField: #title;
							add: self edition;
							add: self series;
							add: self publisherAddress;
							add: self monthYear;
							initiatorText: 'In '; separatorText: ', '; yourself))
			named: 'publishing');
		addNamedField: #note;
		separatorText: '. '; terminatorText: '.';
		named: 'book'
]

{ #category : #'instance creation' }
BibPhraseLibrary class >> default [
	^ defaultInstance ifNil: [defaultInstance := self new]
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> edition [
	^ BibSequencePhrase new
		addField: #edition;
		terminatorText: ' ed.';
		yourself
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> editor [
	^ BibSequencePhrase new
		addField: #editor;
		terminatorText: ' (Ed.)';
		yourself
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> errorPhrase: anEntry [
	^ BibLiteralPhrase text: 'Unknown entry type:', anEntry type
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> inproceedings [
	^ BibSequencePhrase new
		addNamedFields: #(author title);
		add: ((BibAlternativePhrase
				rules: {
					[:e | e hasField: #crossref]
					-> (BibSequencePhrase new
							add: (BibLiteralPhrase text: 'CROSSREF');
							addField: #pages;
							separatorText: ', '; yourself)}
				default: (BibSequencePhrase new
							add: (BibSequencePhrase new
								addField: #editor;
								terminatorText: ' (Ed.)'; yourself);
							addField: #booktitle;
							add: self series;
							add: self publisherAddress;
							add: self monthYear;
							initiatorText: 'In '; separatorText: ', '; yourself))
			named: 'publishing');
		addNamedField: #note;
		separatorText: '. '; terminatorText: '.';
		named: 'inproceedings'
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> misc [
	^ BibSequencePhrase new
		addNamedFields: #(author title);
		add: ((BibSequencePhrase new
				addField: #howpublished;
				add: self monthYear;
				separatorText: ', '; yourself)
			named: 'publishing');
		addNamedField: #note;
		separatorText: '. '; terminatorText: '.';
		named: 'misc'
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> monthYear [
	^ BibSequencePhrase new
		separatorText: ' ';
		addFields: #(month year)
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> pages [
	^ BibSequencePhrase new
		initiatorText: 'p. ';
		addField: #pages;
		yourself
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> phdthesis [
	^ BibSequencePhrase new
		addNamedFields: #(author title);
		add: ((BibSequencePhrase new
				add: self thesisType;
				addFields: #(school address);
				add: self monthYear;
				separatorText: ', '; yourself)
			named: 'publishing');
		addNamedField: #note;
		separatorText: '. '; terminatorText: '.';
		named: 'phdthesis'
]

{ #category : #querying }
BibPhraseLibrary class >> phraseFor: anEntry [
	| selector |
	selector := anEntry type.
	
	^ ((self class allMethodsInCategory: 'phrases-entries') includes: selector)
		ifTrue: [self perform: selector]
		ifFalse: [self errorPhrase: anEntry]
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> publisherAddress [
	^ BibLiteralPhrase text: 'publisherAddress'
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> series [
	^ BibSequencePhrase new
		addField: #series;
		add: self volumeNumber;
		add: self pages;
		separatorText: ' ';
		yourself
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> thesisType [
	^ BibAlternativePhrase
		rules: {[:e | e hasField: #type] -> (BibFieldRef field: #type)}
		default: (BibLiteralPhrase text: 'Ph.D. thesis')
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> volumeNumber [
	^ BibSequencePhrase new
		addField: #volume;
		add: (BibSequencePhrase new
			initiatorText: '(';	addField: #number; terminatorText: ')');
		yourself
]

{ #category : #'initialize-release' }
BibPhraseLibrary >> initialize [
	phrases := Dictionary new
]

{ #category : #querying }
BibPhraseLibrary >> phraseFor: anEntry [
	^ self class phraseFor: anEntry
	"^ phrases
		at: anEntry type
		ifAbsentPut: [self class phraseFor: anEntry]"
]
