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

	self document add: (CZHeader new text: '
<p>You will find here my publications presented by category and in chronological order.
In my <a href="themes.html">research themes page</a>, the same publications are organized by topics.</p>' ; yourself).
	
	self 
	      addBibSection: (self journalQuery) withTitle: localization  internationalReviewedJournal;
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
NicolasPublicationsDocBuilder >> htmlFileName [
	^ Date today yyyymmdd , '.html'
]

{ #category : #accessing }
NicolasPublicationsDocBuilder >> htmlGeneratorClass [
	^ CZNicolasHTMLGenerator
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
			Copyright &copy; 2014 | All Rights Reserved </div>
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
	<p>'
	
	 , self xhtmlTitle ,
	
	'</p>
</div>		
		<div id="container">
				<div id="sidebarout">
				<div id="sidebarin">
					<h1>Main Menu</h1>
		
							<div id="menu">
								<a href="nicolasAnquetil.html">Home</a><br />
								<a href="publications.html">Publications</a><br />
								<a href="themes.html">Research themes</a><br />
								<a href="miscAcademy.html">Misc. Academia</a><br />
								<a href="projects.html">Projects</a><br />
								<a href="links.html">External links</a>
				 			</div>

							 <p></p>

							<div id="menu">

<p>Nicolas.Anquetil @ inria.fr<br />
Research office: Room 321, Inria building B, +33 (0)3 59 35 87 47<br />
Teaching Office: Room 3A049, IUT-A, +33 (0)3 20 43 47 14</p>

		 			 </div>
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

{ #category : #building }
NicolasPublicationsDocBuilder >> xhtmlTitle [
	^  'Publication list'
]
