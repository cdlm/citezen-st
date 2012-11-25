Class {
	#name : #HervePublicationsDocBuilder,
	#superclass : #CZSingleAuthorDocBuilder,
	#category : #'Citezen-Herve'
}

{ #category : #'as yet unclassified' }
HervePublicationsDocBuilder class >> bibtex [
	"self bibtex"
	| builder|
	builder := self new
		fileNamed: '/Volumes/WIN/home/hv/minimized/listic/data/publications/biblst/trunk/bibtex/biblst.bib';
		setFilteringOn;
		yourself.
	builder generateBibtexFile
]

{ #category : #'as yet unclassified' }
HervePublicationsDocBuilder class >> latex [
	"self latex"
	
	| builder |
	builder := self new
		fileNamed: '/Volumes/WIN/home/hv/minimized/listic/data/publications/biblst/trunk/bibtex/biblst.bib';
		toLatex;
		english;  "french"
		fieldOrder: #(#author 
			  #title 
			  #journal 
			  #booktitle 
			  #volume 
			  #pages 
			  #publisher  
			  #year 
			  #impactfactor 
			  #rate); "removed doi and url since they may contain _ and the generator does not handle that well for the moment."
		setFilteringOn;
		yourself.
	builder generateLatexFile.
	
]

{ #category : #'as yet unclassified' }
HervePublicationsDocBuilder class >> xhtml [
	"self xhtml"
		
	|  builder|
	builder :=  self new
		english; 
		fileNamed: '/Volumes/WIN/home/hv/minimized/listic/data/publications/biblst/trunk/bibtex/biblst.bib';
		setFilteringOn;
		yourself.
	builder generateXHTMLFile.
	builder generateBibtexFile.
]

{ #category : #'as yet unclassified' }
HervePublicationsDocBuilder >> buildBody [

	self addBibSection: (self journalQuery) withTitle: localization  internationalReviewedJournal;
		addBibSection: (self topConferenceQuery) withTitle:  localization topConferences;				
		addBibSection: (self nationalJournalQuery) withTitle: localization nationalReviewedJournal;
		addBibSection: (self bookChapterQuery) withTitle: localization bookChapters;
		addBibSection: (self internationalConferenceQuery)  withTitle: localization internationalConference;
		addBibSection: (self nationalConferenceQuery) withTitle: localization nationalReviewedConference;
		addBibSection: (self invitedQuery) withTitle: localization invitedPapers;
		addBibSection: (self bookQuery) withTitle: localization books;
		addBibSection: (self editorQuery) withTitle: localization editor;
		addBibSection: (self internationalWorkshopQuery) withTitle: localization internationalReviewedWorkshops;
		addBibSection: (self nationalWorkshopQuery) withTitle: localization nationalWorkshops;

		addBibSection: (self PhDAndHabilitationQuery) withTitle: localization phdAndHdr;

		addBibSection: (self deliverableQuery)   withTitle: localization deliverable;

		addBibSection: (self technicalReportQuery)   withTitle: localization technicalReport;

		addBibSection: (self toolDemoQuery)   withTitle: localization toolDemo;
		addBibSection: (self periodicalQuery)   withTitle: localization periodical;

		addBibSection: (self vulgarisationQuery) withTitle: localization vulgarisation.
]

{ #category : #'as yet unclassified' }
HervePublicationsDocBuilder >> initialize [

	super initialize.
	self authorMatchingString: '*Verjus*'.
]

{ #category : #'as yet unclassified' }
HervePublicationsDocBuilder >> latexName [

	^  'Dr. Herv\''e Verjus'
]

{ #category : #'as yet unclassified' }
HervePublicationsDocBuilder >> xhtmlFooter [
	^ '
	</div>
	</div>

	<?php

	endMainContent();
	footer("publications.php");

	?>

	'
]

{ #category : #'as yet unclassified' }
HervePublicationsDocBuilder >> xhtmlHeader [
	^ '
	
	<?php

		include("functions.php");
		headHVE();
		bodyTop();
		beginMainContent();
		menu("Publications");

	?>

	<div id="pageContent">
	<div xmlns="" class="paperList">

'
]

{ #category : #'as yet unclassified' }
HervePublicationsDocBuilder >> xhtmlName [

	^ 'Dr. H. Verjus'
]
