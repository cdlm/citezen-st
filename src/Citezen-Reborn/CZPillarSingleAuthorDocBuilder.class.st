"
Generate pillar descriptions

!!Supported features

- keysOfBlackListedEntries:
- fileNamed: 'rmod.bib';
- authorMatchingString:
- fieldOrder:

!! Example

| builder |
builder := self new
		fileNamed: 'rmod.bib';
		authorMatchingString: '*Ducasse*';
		french; 
		fieldOrder: #(#author 
			  #title 
			  #journal 
			  #booktitle 
			  #volume 
			  #pages 
			  #publisher  
			  #year 
			  #school
			  #impactfactor 
			  #misc); ""removed doi and url since they may contain _ and the generator does not handle that well for the moment.""
		setFilteringOn.
	builder generate.	
		
"
Class {
	#name : #CZPillarSingleAuthorDocBuilder,
	#superclass : #CZDecoratedDocBuilder,
	#category : #'Citezen-Reborn'
}

{ #category : #initialize }
CZPillarSingleAuthorDocBuilder >> buildBody [

	self addBibSection: (self journalQuery) withTitle: localization  internationalJournal;
		addBibSection: (self topConferenceQuery) withTitle:  localization topConference;				
		addBibSection: (self nationalJournalQuery) withTitle: localization nationalJournal;
		addBibSection: (self internationalConferenceQuery)  withTitle: localization internationalConference;
		addBibSection: (self nationalConferenceQuery) withTitle: localization nationalReviewedConference;
		addBibSection: (self invitedPaperQuery) withTitle: localization invitedPaper;
		addBibSection: (self bookChapterQuery) withTitle: localization bookChapters;
		addBibSection: (self bookQuery) withTitle: localization book;
		addBibSection: (self editorQuery) withTitle: localization editor;
		addBibSection: (self internationalWorkshopQuery) withTitle: localization internationalReviewedWorkshops;
		addBibSection: (self PhDAndHabilitationQuery) withTitle: localization PhDAndHabilitation;
		addBibSection: (self toolDemoQuery)   withTitle: localization toolDemo ;
		addBibSection: (self vulgarisationQuery) withTitle: localization vulgarisation.
]

{ #category : #initialize }
CZPillarSingleAuthorDocBuilder >> extension [

	^ '-Full.pillar'
]

{ #category : #initialize }
CZPillarSingleAuthorDocBuilder >> generatorClass [
	^ CZPillarGenerator 
]

{ #category : #initialize }
CZPillarSingleAuthorDocBuilder >> initialize [
	super initialize.
	noHeader := true.
]
