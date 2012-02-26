"
StefPublicationsDocBuilder new 
	bibset: CZDocBuilderTest someArticles;
	authorMatchingString: '*S*Ducasse*';
	build;
	document
"
Class {
	#name : #StefPublicationsDocBuilder,
	#superclass : #CZSingleAuthorDocBuilder,
	#category : #'Citezen-Reborn'
}

{ #category : #'as yet unclassified' }
StefPublicationsDocBuilder class >> doit [
	"self doit"
	"clearly to reconsider to make it nicer to compose"
	
	| bibset builder |
	bibset := CZBibParser parse: ((FileStream readOnlyFileNamed: 'rmod.bib') contents).
	bibset scope: CZSet standardDefinitions.
	
	builder :=  self new
		french; 
		setFilteringOn;
		authorMatchingString: '*Ducasse*';
		"outputFileName: Date today yyyymmdd, '-stefFull.html';"
		bibset: bibset;
		yourself.
	
	CZHTMLGenerator new 
			outputStream: (FileStream newFileNamed:  Date today yyyymmdd, '-stefFull.html'); 
			visit: builder build document.
		
	
]

{ #category : #building }
StefPublicationsDocBuilder >> build [

	super build.
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

{ #category : #building }
StefPublicationsDocBuilder >> filter [

	super filter.
	workingBibSet
]
