"
CZPersonalGenerator should be probably a subclass of CZDocument.

For now it is used to generate information based on a set of scripts for an author.


Right now use displayPattern but we should probably use Phrases developed by Damien. 
"
Class {
	#name : #CZPersonalGenerator,
	#superclass : #Object,
	#instVars : [
		'document',
		'outputFileName',
		'inputFileName',
		'conferenceDisplayPattern',
		'articleDisplayPattern',
		'allDisplayPattern',
		'author'
	],
	#pools : [
		'CZPool'
	],
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #script }
CZPersonalGenerator >> PhDAndHabilitation [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: Year;
		query: (self withAuthor 
					AND: ((CZTypeQuery checks: [ :each | each = #phdthesis]) 
							OR: (CZFieldQuery 
									named: #annote 
									checks: [ :value | '*habilitation*' match: value ])))
]

{ #category : #patterns }
CZPersonalGenerator >> allDisplayPattern [

	^ allDisplayPattern ifNil: [ allDisplayPattern := self allDisplayPatternDefault ]
]

{ #category : #patterns }
CZPersonalGenerator >> allDisplayPatternDefault [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: Title;
			field: Journal;
			field: #booktitle;
			field: #volume;
			field: #pages;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #rate;
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #patterns }
CZPersonalGenerator >> allDisplayPatternNoWeb [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #journal;
			field: #booktitle;
			field: #volume;
			field: #pages;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #rate;
			endsWith: '.'
]

{ #category : #patterns }
CZPersonalGenerator >> articleDisplayPattern [

	^ articleDisplayPattern ifNil: [ articleDisplayPattern := self articleDisplayPatternDefault ]
]

{ #category : #patterns }
CZPersonalGenerator >> articleDisplayPatternDefault [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #journal;
			field: #volume;
			field: #pages;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #patterns }
CZPersonalGenerator >> articleDisplayPatternNoWeb [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #journal;
			field: #volume;
			field: #pages;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #rate;
			endsWith: '.'
]

{ #category : #parameters }
CZPersonalGenerator >> author [

	^ author ifNil: [ author := '*Ducasse*']
]

{ #category : #parameters }
CZPersonalGenerator >> author: aPatternedMatchingAuthorNameString [
	" '*Ducasse*' "
	
	author := aPatternedMatchingAuthorNameString
]

{ #category : #script }
CZPersonalGenerator >> bookChapterScript [ 
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor AND: (self withType: '*articlebook*') )
]

{ #category : #script }
CZPersonalGenerator >> booksScript [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (CZTypeQuery checks: [ :each | each = #book] ))
]

{ #category : #patterns }
CZPersonalGenerator >> conferenceDisplayPattern [

	^ conferenceDisplayPattern ifNil: [ conferenceDisplayPattern := self conferenceDisplayPatternDefault ]
]

{ #category : #patterns }
CZPersonalGenerator >> conferenceDisplayPatternDefault [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #booktitle;
			field: #volume;
			field: #pages;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #rate;
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #patterns }
CZPersonalGenerator >> conferenceDisplayPatternNoWeb [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #booktitle;
			field: #volume;
			field: #pages;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #misc;
			endsWith: '.'
]

{ #category : #script }
CZPersonalGenerator >> conferencesScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | ('*internationalconference*' match: value) 
													and: [('*topconference*' match: value) not ]]))
]

{ #category : #accessing }
CZPersonalGenerator >> document [

	^ document ifNil: [document := CZDocument new]
]

{ #category : #script }
CZPersonalGenerator >> editorScript [
	
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: ((CZFieldQuery named: #editor checks: [ :value | self author match: value ])
					"AND: (CZBibFieldQuery 
								named: #annote 
								checks: [ :value | '*editor*' match: value ])"
					OR: (self withType: '*workshopproceedings*') )
]

{ #category : #public }
CZPersonalGenerator >> generate [
	"Once fully configured generate the document."
	
	self document generate.
	^ self document
]

{ #category : #'file parameter' }
CZPersonalGenerator >> inputFileName [
	^ inputFileName
]

{ #category : #'file parameter' }
CZPersonalGenerator >> inputFileName: aString [
	inputFileName := aString
]

{ #category : #script }
CZPersonalGenerator >> internationalWorkshopScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor AND: (self withType: '*internationalworkshop*') )
]

{ #category : #script }
CZPersonalGenerator >> invitedScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor AND: (self withType: '*invited*') )
]

{ #category : #script }
CZPersonalGenerator >> journalsScript [
	^ CZScript new
		id: 'journalsScript';
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: CZQuery isInternationalJournalQuery )
]

{ #category : #document }
CZPersonalGenerator >> metadata [

	self document addElement: (CZCommentElement new comment: 'Generated by Citezen --', Date today printString).
]

{ #category : #script }
CZPersonalGenerator >> nationalConferencesScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor AND: (self withType: 'nationalconference*') )
]

{ #category : #script }
CZPersonalGenerator >> nationalJournalsScript [ 
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | ('*nationaljournal*' match: value) and: [('*internationaljournal*' match: value) not] ]))
]

{ #category : #parameters }
CZPersonalGenerator >> noWebFormat [

	self setAllDisplayPattern: self allDisplayPatternNoWeb.
	self setArticleDisplayPattern: self articleDisplayPatternNoWeb.
	self setConferenceDisplayPattern:  self conferenceDisplayPatternNoWeb.
	

]

{ #category : #'file parameter' }
CZPersonalGenerator >> outputFileName [
	^ outputFileName 
]

{ #category : #'file parameter' }
CZPersonalGenerator >> outputFileName: aString [
	outputFileName := aString
]

{ #category : #patterns }
CZPersonalGenerator >> setAllDisplayPattern: aPattern [

	allDisplayPattern := aPattern
]

{ #category : #patterns }
CZPersonalGenerator >> setArticleDisplayPattern: aPattern [

	articleDisplayPattern := aPattern
]

{ #category : #patterns }
CZPersonalGenerator >> setConferenceDisplayPattern: aPattern [

	conferenceDisplayPattern := aPattern
]

{ #category : #accessing }
CZPersonalGenerator >> setDocument [

	self document 
		inputFile: inputFileName;
		outputFile: outputFileName 
]

{ #category : #script }
CZPersonalGenerator >> toolDemosScript [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (self withType: '*tooldemo*') )
]

{ #category : #script }
CZPersonalGenerator >> topConferencesScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (self withType: '*topconference*') )
]

{ #category : #script }
CZPersonalGenerator >> vulgarisationsScript [
	^ CZScript new
		displayPattern: self allDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (self withType: '*vulgarisation*') )
]

{ #category : #queries }
CZPersonalGenerator >> withAuthor [
	^ CZFieldQuery named: #author checks: [ :value | self author match: value ]
]

{ #category : #queries }
CZPersonalGenerator >> withType: aQueryString [

	^ CZFieldQuery 
			named: #annote 
			checks: [ :value | aQueryString match: value ]
]

{ #category : #script }
CZPersonalGenerator >> yearScript: aYear [
 
	^ CZScript new
		displayPattern: self allDisplayPattern;
		sortByField: #author;
		query: (self withAuthor 
					AND: (CZFieldQuery 
								named: #year 
								checks: [ :value | value asInteger = aYear ]))
]
