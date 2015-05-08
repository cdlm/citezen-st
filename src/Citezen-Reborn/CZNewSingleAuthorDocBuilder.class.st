Class {
	#name : #CZNewSingleAuthorDocBuilder,
	#superclass : #CZDocBuilder,
	#instVars : [
		'noHeader',
		'xhtml'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #Bibtex }
CZNewSingleAuthorDocBuilder class >> bibtex [
	"self bibtex"
	| builder|
	builder := self new
		fileNamed: 'rmod.bib';
		setFilteringOn;
		yourself.
	builder generateBibtexFile
]

{ #category : #doit }
CZNewSingleAuthorDocBuilder class >> xhtml [
	"self xhtml"
		
	|  builder|
	builder :=  self new
		french; 
		fileNamed: 'rmod.bib';
		setFilteringOn;
		yourself.
	builder generateXHTMLFile.
	builder generateBibtexFile.
]

{ #category : #building }
CZNewSingleAuthorDocBuilder >> addFooter [

	noHeader ifTrue: [^self].
	doc footer: (CZFooter new text: self footer)
					
]

{ #category : #building }
CZNewSingleAuthorDocBuilder >> addHeader [
	
	noHeader ifTrue: [^self].
	doc header: (CZHeader new text: self header)
]

{ #category : #building }
CZNewSingleAuthorDocBuilder >> buildBody [

	self addBibSection: (self journalQuery) withTitle: localization  internationalReviewedJournal;
		addBibSection: (self topConferenceQuery) withTitle:  localization topConferences;				
		addBibSection: (self nationalJournalQuery) withTitle: localization nationalReviewedJournal;
		addBibSection: (self internationalConferenceQuery)  withTitle: localization internationalConference;
		addBibSection: (self nationalConferenceQuery) withTitle: localization nationalReviewedConference;
		addBibSection: (self invitedQuery) withTitle: localization invitedPapers;
		addBibSection: (self bookChapterQuery) withTitle: localization bookChapters;
		addBibSection: (self bookQuery) withTitle: localization books;
		addBibSection: (self editorQuery) withTitle: localization editor;
		addBibSection: (self internationalWorkshopQuery) withTitle: localization internationalReviewedWorkshops;
		addBibSection: (self PhDAndHabilitationQuery) withTitle: localization phdAndHdr;

		addBibSection: (self toolDemoQuery)   withTitle: localization toolDemo ;
		addBibSection: (self vulgarisationQuery) withTitle: localization vulgarisation.
]

{ #category : #generate }
CZNewSingleAuthorDocBuilder >> extension [
	^ '.txt'
]

{ #category : #building }
CZNewSingleAuthorDocBuilder >> filter [

	super filter.
	workingBibSet := workingBibSet select: self authorQuery
]

{ #category : #building }
CZNewSingleAuthorDocBuilder >> footer [
					
]

{ #category : #generate }
CZNewSingleAuthorDocBuilder >> generate [

	self generateFor: self build document.
]

{ #category : #generate }
CZNewSingleAuthorDocBuilder >> generateFor: aDoc [
	self generateFor: aDoc on: (FileStream newFileNamed: Date today yyyymmdd , self extension).
]

{ #category : #generate }
CZNewSingleAuthorDocBuilder >> generateFor: aDoc on: aStream [
	| visitor |
	visitor := self generatorClass new.
	fieldOrder ifNotNil: [ visitor fieldOrder: fieldOrder ].
	visitor outputStream: aStream.
	visitor visit: aDoc
]

{ #category : #building }
CZNewSingleAuthorDocBuilder >> header [
					
]

{ #category : #initialize }
CZNewSingleAuthorDocBuilder >> initialize [

	super initialize.
	noHeader := false.

]

{ #category : #accessing }
CZNewSingleAuthorDocBuilder >> noHeader [

	noHeader := true
]

{ #category : #accessing }
CZNewSingleAuthorDocBuilder >> withHeader [

	noHeader := false
]
