Class {
	#name : #CZSimonScripts,
	#superclass : #CZPersonalWebPageGenerator,
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #'as yet unclassified' }
CZSimonScripts >> articleDisplayPattern [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #journal;
			separator: ', v. ';
			field: #volume;
			separator: '(';
			field: #number;
			separator: '), p. ';
			field: #pages;
			field: #note;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #'as yet unclassified' }
CZSimonScripts >> author [

	^ '*Denier*'
]

{ #category : #'as yet unclassified' }
CZSimonScripts >> bibInput [

	^ 'denier.bib'

]

{ #category : #'as yet unclassified' }
CZSimonScripts >> conferenceDisplayPattern [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #booktitle;
			separator: ', p. ';
			field: #pages;
			field: #note;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactFactor;
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #'as yet unclassified' }
CZSimonScripts >> configure [

	self document header: 'Last revision: ', Date today printString, '.
	'.

	self document footer: ''
]

{ #category : #'as yet unclassified' }
CZSimonScripts >> dissertationDisplayPattern [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #school;
			field: #note;
			field: #year;
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #'as yet unclassified' }
CZSimonScripts >> dissertationScript [
	^ CZScript new
		displayPattern: self dissertationDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (CZTypeQuery checks: [ :each | each = #phdthesis or: [ each = #mastersthesis ]] ))
]

{ #category : #'as yet unclassified' }
CZSimonScripts >> htmlOutput [

	^ 'denier_publi.html'
]

{ #category : #'as yet unclassified' }
CZSimonScripts >> reportDisplayPattern [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #institution;
			field: #number;
			field: #note;
			field: #year;
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #'as yet unclassified' }
CZSimonScripts >> reportScript [
	^ CZScript new
		displayPattern: self reportDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor AND: (self withType: '*technicalreport*') )
]

{ #category : #'as yet unclassified' }
CZSimonScripts >> typeOriented [
	"self new generateTypeOriented"
	
	self inout.
	self document 
		displayFullName ;
		orderedList ;
		doNotRestartOrderedListAtEachScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in International Journals'; htmlLevel: 2);
		addElement: self journalsScript;
"		addElement: (CZTitleElement new 
							title: 'Refereed Articles in Top Conferences'; htmlLevel: 2);
		addElement: self topConferencesScript;
"		addElement: (CZTitleElement new 
							title: 'Refereed Articles in French Journals'; htmlLevel: 2);					
		addElement: self nationalJournalsScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in International Conferences'; htmlLevel: 2);
		addElement: self conferencesScript;
"		addElement: (CZTitleElement new 
							title: 'Refereed Articles in National Conferences'; htmlLevel: 2);
		addElement: self nationalConferencesScript;
""		addElement: (CZTitleElement new 
							title: 'Invited Articles'; htmlLevel: 2);
		addElement: self invitedScript;
""		addElement: (CZTitleElement new 
							title: 'Book Chapters'; htmlLevel: 2);
		addElement: self bookChapterScript;
""		addElement: (CZTitleElement new 
							title: 'Books'; htmlLevel: 2);
		addElement: self booksScript;
"		addElement: (CZTitleElement new 
							title: 'Proceedings'; htmlLevel: 2);
		addElement: self editorScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in International Workshops'; htmlLevel: 2);
		addElement: self internationalWorkshopScript;
		addElement: (CZTitleElement new 
							title: 'Other Workshops'; htmlLevel: 2);
		addElement: self workshopScript;
		addElement: (CZTitleElement new 
							title: 'Dissertations'; htmlLevel: 2);
		addElement: self dissertationScript;
		addElement: (CZTitleElement new 
							title: 'Technical Reports'; htmlLevel: 2);
		addElement: self reportScript.
"			addElement: (CZTitleElement new 
							title: 'Tool Demos'; htmlLevel: 2);
		addElement: self toolDemosScript ;
""			addElement: (CZTitleElement new 
							title: 'Vulgarisation'; htmlLevel: 2);
		addElement: self vulgarisationsScript.
"	self document exportAsHtml. 
	
]

{ #category : #'as yet unclassified' }
CZSimonScripts >> workshopScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor AND: (self withType: '*otherworkshop*') )
]
