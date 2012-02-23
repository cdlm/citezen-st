Class {
	#name : #StefPublicationsDocBuilder,
	#superclass : #CZDocBuilder,
	#category : #'Citezen-Reborn'
}

{ #category : #building }
StefPublicationsDocBuilder >> build [

	super build.
	self addBibSection: (self journalQuery) titleString: localization  internationalReviewedJournal;
		addBibSection: (self topConferenceQuery) titleString:  localization topConferences;				
		addBibSection: (self nationalJournalQuery) titleString: localization nationalReviewedJournal;
		addBibSection: (self conferencesQuery)  titleString: localization internationalConference;
		addBibSection: (self nationalConferenceQuery) titleString: localization nationalReviewedConference;
		addBibSection: (self invitedQuery) titleString: localization invitedPapers;
		addBibSection: (self bookChapterQuery) titleString: localization bookChapters;
		addBibSection: (self bookQuery) titleString: localization books;
		addBibSection: (self editorQuery) titleString: localization editor;
		addBibSection: (self internationalWorkshopQuery) titleString: localization internationalReviewedWorkshops;
		addBibSection: (self PhDAndHabilitation) titleString: localization phdAndHdr;

		addBibSection: (self toolDemoQuery)   titleString: localization toolDemo ;
		addBibSection: (self vulgarisationQuery) titleString: localization vulgarisation.
]
