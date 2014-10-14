Class {
	#name : #NicolasPublicationsDocBuilder,
	#superclass : #CZSingleAuthorDocBuilder,
	#category : #'Citezen-Nicolas'
}

{ #category : #generation }
NicolasPublicationsDocBuilder class >> xhtml [
	"self xhtml"
		
	|  builder|
	builder :=  self new
		english; 
		fileNamed: 'rmod.bib';
		setFilteringOn;
		yourself.
	builder generateXHTMLFile.
]

{ #category : #building }
NicolasPublicationsDocBuilder >> buildBody [

	self addBibSection: (self journalQuery) withTitle: localization  internationalReviewedJournal;
		"addBibSection: (self topConferenceQuery) withTitle:  localization topConferences;"
		addBibSection: (self nationalJournalQuery) withTitle: 'Refereed Articles in National Journals';
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

{ #category : #utils }
NicolasPublicationsDocBuilder >> generateXHTMLFileFor: aDoc [

	| visitor |
	visitor := CZNicolasHTMLGenerator new.
	fieldOrder ifNotNilDo: [:x|  visitor fieldOrder: fieldOrder].
	visitor	
			outputStream: (FileStream newFileNamed:  Date today yyyymmdd, '.html'); 
			visit: aDoc.
	visitor outputStream   close.
]

{ #category : #initialize }
NicolasPublicationsDocBuilder >> initialize [

	super initialize.
	self authorMatchingString: '*Anquetil*'.
]

{ #category : #building }
NicolasPublicationsDocBuilder >> xhtmlFooter [
	^ '				</div>
		</div>
		
<div id="footer">
			Copyright © 2014 | All Rights Reserved </div>
</body>
</html>
'
]

{ #category : #building }
NicolasPublicationsDocBuilder >> xhtmlHeader [
	^ '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Nicolas Anquetil</title>
<link href="main.css" rel="stylesheet" type="text/css" />
<link href="bib.css"   rel="stylesheet" type="text/css"/>
</head>
<body>
		<div id="title">
				<h1><font color="#0183E5">Nicolas Anquetil</font></h1>
				<p>Publication list</p>
</div>		
		<div id="container">
				<div id="sidebar">
						
						<h1>Main Menu</h1>
		
							<div id="menu">
								<a href="nicolasAnquetil.html">Home</a><br />
								<a href="publications.html">Publications</a><br />
								<a href="miscAcademy.html">Misc. Academia</a><br />
								<a href="projects.html">Projects</a><br />
								<a href="links.html">External links</a>
				 			 </div>
							 <p></p>
							<div id="menu">
Nicolas.Anquetil @ inria.fr<br />
Research office: +33 (0)3 59 35 87 47, Room: 321, Inria building B<br />
Teaching Office: +33 (0)3 20 43 47 14, Room: IUT-A, 3A049
							</div>
				</div>
				<div id="content">
				<h1>Publications</h1>
'
]

{ #category : #building }
NicolasPublicationsDocBuilder >> xhtmlName [

	^ 'Nicolas Anquetil'
]
