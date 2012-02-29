"
StefPublicationsDocBuilder new 
	bibset: CZDocBuilderTest someArticles;
	authorMatchingString: '*S*Ducasse*';
	build;
	document
	


StefPublicationsDocBuilder doit
"
Class {
	#name : #StefPublicationsDocBuilder,
	#superclass : #CZSingleAuthorDocBuilder,
	#instVars : [
		'xhtml'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #doit }
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
		"outputFileName: Date today yyyymmdd, '-NewStefFull.html';"
		bibset: bibset;
		yourself.
	
	CZHTMLGenerator new 
			outputStream: (FileStream newFileNamed:  Date today yyyymmdd, '-stefFull.html'); 
			visit: builder build document.
		
	
]

{ #category : #building }
StefPublicationsDocBuilder >> addFooter [

	xhtml 
		ifTrue: [
	doc add: (CZFooter new text: '<h4>BibTex Files of the Publications</h4>
<A HREF="stef.bib">BibTex File</A> </div>  <!-- div xmlns= class="paperList" -->
	 </div><!-- mainContent -->
   </body>
</html>
')]
		ifFalse: [
			
			
			
			]
]

{ #category : #building }
StefPublicationsDocBuilder >> addHeader [

	doc add: (CZHeader new text: '<?xml version="1.0" encoding="ISO-8859-1"?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <link rel="stylesheet" href="stef.css"/>
   <head>
      <title>Prof. Dr. St&eacute;phane Ducasse</title>
   </head>
   <body>
      <div id="header">
         <div id="headerSiteTitle">St&eacute;phane Ducasse</div>
         <div id="headerPageTitle">Publications</div>
      </div><!-- header-->
      <div xmlns="" id="menu">
         <div id="toc">
            <div id="tocItem"> <a href="index.html">Home</a> </div>
            <div id="tocItem"> <a href="Publications.html">Publications</a> </div>
			<div id="tocItem"> <a href="Supervised.html">PhDs and Masters</a> </div>
            <div id="tocItem"> <a href="Books.html">Books and Columns</a> </div>
			<div id="tocItem"> <a href="FreeBooks.html">Free Smalltalk Books</a> </div>
			<div id="tocItem"> <a href="Resources.html">Downloads/Resources</a> </div>
            <div id="tocItem"> <a href="Teaching.html">Lectures</a> </div>
			<div id="tocItem"> <A HREF= "skweek2.htm">Skweek ...Strikes Back</a></div>
            <div id="tocItem"> <A HREF= "index.html#coor">Coordinates</A> </div>
         </div><!-- toc-->
         <div id="copyright">last revision: ', Date today printString, '<br/></div>
				
		<div xmlns="" id="personalDetails">
            <div id="personalDetailsItem"> <A HREF="http://rmod.inria.lille.fr">Rmod</A></div>
		</div>		
      </div> <!-- menu-->
      <div id="mainContent">
	  <div xmlns="" class="paperList"><style type="text/css">
<!--
-->
</style>')
]

{ #category : #building }
StefPublicationsDocBuilder >> buildBody [

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

{ #category : #initialize }
StefPublicationsDocBuilder >> initialize [

	super initialize.
	xhtml := true
]
