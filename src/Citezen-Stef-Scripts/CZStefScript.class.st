"
This class is a private class to play with the Script and Document to generate a couple of personal output. May be a generalization will be usefull to avoid that everybody is doing the same. but for now we are learning.
"
Class {
	#name : #CZStefScript,
	#superclass : #Object,
	#instVars : [
		'document'
	],
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #script }
CZStefScript >> PhDAndHabilitation [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: ((CZTypeQuery checks: [ :each | each = #phdthesis]) 
							OR: (CZFieldQuery 
									named: #annote 
									checks: [ :value | '*habilitation*' match: value ])))
]

{ #category : #patterns }
CZStefScript >> allDisplayPattern [

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
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #patterns }
CZStefScript >> articleDisplayPattern [

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

{ #category : #script }
CZStefScript >> bookChapterScript [ 
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*articlebook*' match: value ]))
]

{ #category : #script }
CZStefScript >> booksScript [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZTypeQuery checks: [ :each | each = #book] ))
]

{ #category : #patterns }
CZStefScript >> conferenceDisplayPattern [

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
			field: #impactFactor;
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #script }
CZStefScript >> conferencesScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | ('*internationalconference*' match: value) 
													and: [('*topconference*' match: value) not ]]))
]

{ #category : #accessing }
CZStefScript >> document [

	^ document ifNil: [document := CZDocument new]
]

{ #category : #script }
CZStefScript >> editorScript [
	
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: ((CZFieldQuery named: #editor checks: [ :value | '*Ducasse*' match: value ])
					"AND: (CZBibFieldQuery 
								named: #annote 
								checks: [ :value | '*editor*' match: value ])"
					OR: (CZFieldQuery
								named: #annot
								checks: [:value | '*workshopproceedings*' match: value]			
								))
]

{ #category : #public }
CZStefScript >> generateSortedByYear [
	"self new generateSortedByYear"
	
	self inoutYear.
	self document 
		displayFullName.
	1999 to: 2009
		do: [:year | 
		self document 
				addElement: (CZTitleElement new 
							title: 'Articles in ', year asString; htmlLevel: 4);
				addElement: (self yearScript: year)].
	
	self document exportAsHtml. 
	self document generate.
	^ self document
]

{ #category : #public }
CZStefScript >> generateTypeOriented [
	"self new generateTypeOriented"
	
	self typeOriented.
	self document generate.
	self document entitiesAlreadyTreated.
	^ self document
]

{ #category : #public }
CZStefScript >> generateTypeOrientedAssociatedBibFile [
	"self new generateTypeOrientedAssociatedBibFile"
	
	| newbib |
	self typeOriented.
	self document fillUpOriginalSet.
	newbib := CZBibSetGatherer bibsetFrom: self document.
	^ CZBibtexOutputer new 
		setOutputFile: 'stef.bib';
		blackListedFields: CZEntry privateFields;
		initializeOutputStream; 
		visitSet: newbib;
		contents
]

{ #category : #'file parameter' }
CZStefScript >> inout [

	self document
		inputFile: 'all.bib';
		outputFile: 'stef.html'.
]

{ #category : #'file parameter' }
CZStefScript >> inoutYear [ 

	self document
		inputFile: 'scg.bib';
		outputFile: 'stefY.html'.
]

{ #category : #script }
CZStefScript >> internationalWorkshopScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*internationalworkshop*' match: value ]))
]

{ #category : #script }
CZStefScript >> invitedScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*invited*' match: value ]))
]

{ #category : #script }
CZStefScript >> journalsScript [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*internationaljournal*' match: value ]))
]

{ #category : #document }
CZStefScript >> metadata [

	self document addElement: (CZCommentElement new comment: 'Generated by Citezen --', Date today printString).
]

{ #category : #script }
CZStefScript >> nationalConferencesScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | 'nationalconference*' match: value ]))
]

{ #category : #script }
CZStefScript >> nationalJournalsScript [ 
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | ('*nationaljournal*' match: value) and: [('*internationaljournal*' match: value) not] ]))
]

{ #category : #queries }
CZStefScript >> onlyStefAuthor [
	^ CZFieldQuery named: #author checks: [ :value | '*Ducasse*' match: value ]
]

{ #category : #script }
CZStefScript >> toolDemosScript [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*tooldemo*' match: value ]))
]

{ #category : #script }
CZStefScript >> topConferencesScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*topconference*' match: value ]))
]

{ #category : #public }
CZStefScript >> typeOriented [
	"self new generateTypeOriented"
	
	self inout.
	self document 
		displayFullName ;
		orderedList ;
		doNotRestartOrderedListAtEachScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in International Journals'; htmlLevel: 4);
		addElement: self journalsScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in Top Conferences'; htmlLevel: 4);
		addElement: self topConferencesScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in French Journals'; htmlLevel: 4);					
		addElement: self nationalJournalsScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in Conferences'; htmlLevel: 4);
		addElement: self conferencesScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in National Conferences'; htmlLevel: 4);
		addElement: self nationalConferencesScript;
		addElement: (CZTitleElement new 
							title: 'Invited Articles'; htmlLevel: 4);
		addElement: self invitedScript;
		addElement: (CZTitleElement new 
							title: 'Book Chapter'; htmlLevel: 4);
		addElement: self bookChapterScript;
		addElement: (CZTitleElement new 
							title: 'Books'; htmlLevel: 4);
		addElement: self booksScript;
		addElement: (CZTitleElement new 
							title: 'Editor'; htmlLevel: 4);
		addElement: self editorScript;
		addElement: (CZTitleElement new 
							title: 'International Workshops Refereed Articles'; htmlLevel: 4);
		addElement: self internationalWorkshopScript;
		addElement: (CZTitleElement new 
							title: 'PhD and Habilitation'; htmlLevel: 4);
		addElement: self PhDAndHabilitation;
			addElement: (CZTitleElement new 
							title: 'Tool Demo'; htmlLevel: 4);
		addElement: self toolDemosScript ;
			addElement: (CZTitleElement new 
							title: 'Vulgarisation'; htmlLevel: 4);
		addElement: self vulgarisationsScript.
	self document exportAsHtml. 
	
]

{ #category : #script }
CZStefScript >> vulgarisationsScript [
	^ CZScript new
		displayPattern: self allDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*vulgarisation*' match: value ]))
]

{ #category : #script }
CZStefScript >> yearScript: aYear [
 
	^ CZScript new
		displayPattern: self allDisplayPattern;
		sortByField: #author;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #year 
								checks: [ :value | value asInteger = aYear ]))
]
