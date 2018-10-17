"
A set of template phrases for named bibliographic entry types.

Default values for entry types are defined by class-side methods of the same name (lowercased), in protocol phrases-entries.
"
Class {
	#name : #BibPhraseLibrary,
	#superclass : #Object,
	#instVars : [
		'phrases'
	],
	#classInstVars : [
		'defaultInstance',
		'monthMappings'
	],
	#category : 'Citezen-Rendering'
}

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> acceptanceRate [
	^ BibAlternativePhrase new
		add: (BibSequencePhrase new
				add: (BibLiteralPhrase text: 'Acceptance rate: ');
				addField: #acceptnum;
				add: (BibLiteralPhrase text: '/');
				addField: #accepttotal;
				add: (BibLiteralPhrase text: ' = ');
				add: (BibDeferredPhrase block: [:entry | ((entry at: #acceptnum) value asNumber / (entry at: #accepttotal) value asNumber * 100) rounded]);
				add: (BibLiteralPhrase text: '%');
				yourself)
		condition: [ :anEntry | (anEntry hasField: #accepttotal) and: [ anEntry hasField: #acceptnum ] ]
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> article [
	^ (BibSequencePhrase new)
		addBlockWithField: #author;
		addBlockWithField: #title;
		add: ((BibAlternativePhrase rules: { 
							([:e | e hasField: #crossref] -> ((BibSequencePhrase new)
										add: (BibLiteralPhrase text: 'CROSSREF');
										add: self pagination;
										separatorText: ', ';
										yourself))}
					default: ((BibSequencePhrase new)
							add: (self containmentIn: #journal);
							add: self locationMonthYear;
							initiatorText: 'In ';
							separatorText: ', ';
							yourself)) 
						blockNamed: 'publishing');
		addBlockWithField: #note;
		separatorText: '. ';
		terminatorText: '.'
]

{ #category : #'formats-fields' }
BibPhraseLibrary class >> author: aField [
	| authors andSep |
	authors := (CZAuthorParser parse: aField value) collect: [:each | BibLiteralPhrase text: each fullName].
	andSep := authors size > 2 ifTrue: [', and '] ifFalse: [' and '].
	^ (BibSequencePhrase with: authors)
		separatorText: ', ';
		lastSeparatorText: andSep;
		yourself
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> book [
	^ (BibSequencePhrase new)
		addBlockWithField: #author;
		add: self editor;
		add: ((BibAlternativePhrase rules: { 
							([:e | e hasField: #crossref] -> ((BibSequencePhrase new)
										add: (BibLiteralPhrase text: 'CROSSREF');
										add: self pagination;
										separatorText: ', ';
										yourself))}
					default: ((BibSequencePhrase new)
							addField: #title;
							add: self edition;
							add: (self containmentIn: #series);
							add: self publisherAddress;
							add: self locationMonthYear;
							"initiatorText: 'In ';" "This makes sense for a chapter in a book, not a book itself -- on"
							separatorText: ', ';
							yourself)) 
						blockNamed: 'publishing');
		addBlockWithField: #note;
		separatorText: '. ';
		terminatorText: '.'
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> booklet [
	^ self book
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> containmentIn: containerField [
	^ BibSequencePhrase new
		addField: containerField;
		add: self volumeNumber;
		add: self pagination;
		separatorText: ' ';
		yourself
]

{ #category : #'instance creation' }
BibPhraseLibrary class >> default [
	"defaultInstance := nil"
	^ defaultInstance ifNil: [defaultInstance := self new]
]

{ #category : #'formats-partial' }
BibPhraseLibrary class >> defaultFormat: aField [
	^ BibLiteralPhrase text: aField value
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

{ #category : #'formats-fields' }
BibPhraseLibrary class >> editor: aField [
	^ self author: aField
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> errorPhrase: anEntry [
	^ BibLiteralPhrase text: 'Unknown entry type:', anEntry type
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> field: aSymbol default: aString [
	^ BibAlternativePhrase
		rules: {[:e | e hasField: aSymbol] -> (BibFieldRef field: aSymbol)}
		default: (BibLiteralPhrase text: aString)
]

{ #category : #querying }
BibPhraseLibrary class >> formatFor: aField [
	"Return a phrase representing the value of this field."
	| selector |
	selector := (aField key copyWith: $:) asSymbol.
	^ ((self class allSelectorsInProtocol: 'formats-fields') includes: selector)
		ifTrue: [self perform: selector with: aField]
		ifFalse: [self defaultFormat: aField]
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> inbook [
	^ self incollection
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> incollection [
	^ (BibSequencePhrase new)
		addBlockWithField: #author;
		addBlockWithField: #title;
		add: ((BibAlternativePhrase rules: { 
							([:e | e hasField: #crossref] -> ((BibSequencePhrase new)
										add: (BibLiteralPhrase text: 'CROSSREF');
										add: self pagination;
										separatorText: ', ';
										yourself))}
					default: ((BibSequencePhrase new)
							add: self editor;
							addField: #booktitle;
							add: (self containmentIn: #series);
							add: self publisherAddress;
							add: self locationMonthYear;
							initiatorText: 'In ';
							separatorText: ', ';
							yourself)) 
						blockNamed: 'publishing');
		addBlockWithField: #note;
		separatorText: '. ';
		terminatorText: '.'
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> inproceedings [
	^ (BibSequencePhrase new)
		addBlockWithField: #author;
		addBlockWithField: #title;
		add: ((BibAlternativePhrase rules: { 
							([:e | e hasField: #crossref] -> ((BibSequencePhrase new)
										add: (BibLiteralPhrase text: 'CROSSREF');
										addField: #pages;
										separatorText: ', ';
										yourself))}
					default: ((BibSequencePhrase new)
							add: self editor;
							addField: #booktitle;
							add: (self containmentIn: #series);
							add: self publisherAddress;
							add: self locationMonthYear;
							initiatorText: 'In ';
							separatorText: ', ';
							yourself)) 
						blockNamed: 'publishing');
		addBlockWithField: #note;
		add: self acceptanceRate;
		separatorText: '. ';
		terminatorText: '.'
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> locationMonthYear [
	^ BibSequencePhrase new
		separatorText: ', ';
		addField: #location;
		add: (BibSequencePhrase new
			separatorText: ' ';
			addFields: #(month year))
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> manual [
	^ self techreport
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> mastersthesis [
	^ self 
		numberedReportFrom: #school
		type: 'Master''s thesis'
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> misc [
	^ (BibSequencePhrase new)
		addBlockWithField: #author;
		addBlockWithField: #title;
		add: (((BibSequencePhrase new)
					addField: #howpublished;
					add: self locationMonthYear;
					separatorText: ', ';
					yourself) blockNamed: 'publishing');
		addBlockWithField: #note;
		separatorText: '. ';
		terminatorText: '.'
]

{ #category : #'formats-fields' }
BibPhraseLibrary class >> month: aField [
	^ BibLiteralPhrase text: (self monthMappings at: aField value ifAbsent: aField value).
]

{ #category : #'instance creation' }
BibPhraseLibrary class >> monthMappings [
	"monthMappings := nil"
	^ monthMappings ifNil: [monthMappings := Dictionary newFromPairs: #(jan January feb February mar March apr April may May jun June jul July aug August sep September oct October nov November dec December)]
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> numberedReportFrom: institution type: aString [ 
	^ (BibSequencePhrase new)
		addBlockWithField: #author;
		addBlockWithField: #title;
		add: (((BibSequencePhrase new)
					add: ((BibSequencePhrase new)
								add: (self field: #type default: aString);
								addField: #number;
								separatorText: ' ';
								yourself);
					addField: institution;
					addField: #address;
					add: self locationMonthYear;
					separatorText: ', ';
					yourself) blockNamed: #publishing);
		addBlockWithField: #note;
		separatorText: '. ';
		terminatorText: '.'
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> pagination [
	^ BibSequencePhrase new
		initiatorText: 'p. ';
		addField: #pages;
		yourself
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> phdthesis [
	^ self 
		numberedReportFrom: #school
		type: 'Ph.D. thesis'
]

{ #category : #querying }
BibPhraseLibrary class >> phraseFor: anEntry [
	"Return a template phrase, named by the entry type, and built from the matching method in protocol phrases-entries."
	| selector |
	selector := anEntry type.
	^ ((self class allSelectorsInProtocol: 'phrases-entries') includes: selector)
 "BibPhraseLibrary class"		ifTrue: [(self perform: selector) named: selector]
		ifFalse: [self errorPhrase: anEntry]
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> proceedings [
	^ self book
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> publisherAddress [
	^ BibSequencePhrase new
		addFields: #(publisher address);
		separatorText: ', ';
		yourself
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> techreport [
	^ self 
		numberedReportFrom: #institution
		type: 'Technical report'
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> unpublished [
	^ BibSequencePhrase new
		addBlockWithField: #author;
		addBlockWithField: #title;
		addBlockWithField: #note;
		separatorText: '. '; terminatorText: '.'
]

{ #category : #'phrases-entries' }
BibPhraseLibrary class >> url [
	^ (BibSequencePhrase new)
		addBlockWithField: #author;
		addBlockWithField: #title;
		add: (((BibSequencePhrase new)
					addField: #url;
					add: self locationMonthYear;
					separatorText: ', ';
					yourself) blockNamed: 'publishing');
		addBlockWithField: #note;
		separatorText: '. ';
		terminatorText: '.'
]

{ #category : #'phrases-partial' }
BibPhraseLibrary class >> volumeNumber [
	^ BibSequencePhrase new
		addField: #volume;
		add: (BibSequencePhrase new
			initiatorText: '(';	addField: #number; terminatorText: ')');
		yourself
]

{ #category : #'formats-fields' }
BibPhraseLibrary class >> year: aField [
	^ BibLiteralPhrase text: aField value
]

{ #category : #querying }
BibPhraseLibrary >> formatFor: aField [
	^ self class formatFor: aField

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
