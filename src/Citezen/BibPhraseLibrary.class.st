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
							add: self volumeNumberPages;
							add: self monthYear;
							initiatorText: 'In '; separatorText: ', '; yourself))
			named: 'publishing');
		addNamedField: #note;
		separatorText: '. '; terminatorText: '.';
		named: 'article'
]

{ #category : #'instance creation' }
BibPhraseLibrary class >> default [
	^ defaultInstance ifNil: [defaultInstance := self new]
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> errorPhrase: anEntry [
	^ BibLiteralPhrase text: 'Unknown entry type:', anEntry type
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> monthYear [
	^ BibSequencePhrase new
		separatorText: ' ';
		addFields: #(month year)
]

{ #category : #'as yet unclassified' }
BibPhraseLibrary class >> phraseFor: anEntry [
	| selector |
	selector := anEntry type.
	
	^ ((self class allMethodsInCategory: 'phrases-entries') includes: selector)
		ifTrue: [self perform: selector]
		ifFalse: [self errorPhrase: anEntry]
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> volumeNumberPages [
	^ BibSequencePhrase new
		separatorText: ': ';
		add: (BibSequencePhrase new
			addField: #volume;
			add: (BibSequencePhrase new
				initiatorText: '(';	addField: #number; terminatorText: ')'));
		addField: #pages
]

{ #category : #'initialize-release' }
BibPhraseLibrary >> initialize [
	phrases := Dictionary new
]

{ #category : #'as yet unclassified' }
BibPhraseLibrary >> phraseFor: anEntry [
	^ phrases
		at: anEntry type
		ifAbsentPut: [self class phraseFor: anEntry]
]
