"
StefPublicationsDocBuilder new 
	bibset: CZDocBuilderTest someArticles;
	authorMatchingString: '*S*Ducasse*';
	build;
	document
	


StefPublicationsDocBuilder doit

StefPublicationsDocBuilder bibtex

StefPublicationsDocBuilder latex

"
Class {
	#name : #StefPublicationsDocBuilder,
	#superclass : #CZSingleAuthorDocBuilder,
	#instVars : [
		'noHeader',
		'xhtml'
	],
	#category : #'Citezen-Stef'
}

{ #category : #doit }
StefPublicationsDocBuilder class >> bibtex [
	"self bibtex"
	"clearly to reconsider to make it nicer to compose"
	
	| builder doc |
	builder := self new
		fileNamed: 'rmod.bib';
		french; 
		setFilteringOn;
		yourself.
	doc := builder build document.
	
	"here we extract the associated bib"		
	CZBibTexGenerator new 
			outputStream: (FileStream newFileNamed:  Date today yyyymmdd, '-stefFull.bib'); 
			visit: doc
		
	
]

{ #category : #doit }
StefPublicationsDocBuilder class >> doit [
	"self doit"
	"clearly to reconsider to make it nicer to compose"
	
	| bibset builder doc |
	bibset := CZBibParser parse: ((FileStream readOnlyFileNamed: 'rmod.bib') contents).
	bibset scope: CZSet standardDefinitions.
	
	builder :=  self new
		french; 
		setFilteringOn;
		authorMatchingString: '*Ducasse*';
		bibset: bibset;
		yourself.
	doc := builder build document.
	CZHTMLGenerator new 
			outputStream: (FileStream newFileNamed:  Date today yyyymmdd, '-stefFull.html'); 
			visit: doc.
	
	"here we extract the associated bib"		
	CZBibTexGenerator new 
			outputStream: (FileStream newFileNamed:  Date today yyyymmdd, '-stefFull.bib'); 
			visit: doc
		
	
]

{ #category : #doit }
StefPublicationsDocBuilder class >> doit2 [
	"self doit2"
	"clearly to reconsider to make it nicer to compose"
	
	| builder doc |
	builder := self new
		fileNamed: 'rmod.bib';
		"bibset: ... a bibset"
		french; 
		setFilteringOn;
		yourself.
	doc := builder build document.
	
	CZHTMLGenerator new 
			outputStream: (FileStream newFileNamed:  Date today yyyymmdd, '-stefFull.html'); 
			visit: doc.
	
	"here we extract the associated bib"		
	CZBibTexGenerator new 
			outputStream: (FileStream newFileNamed:  Date today yyyymmdd, '-stefFull.bib'); 
			visit: doc
		
		"ugly because the name of the bib file referenced to in the footer should be the same as the generated one - ugly ugly ugly because this should be done automatically"
	
]

{ #category : #doit }
StefPublicationsDocBuilder class >> latex [
	"self latex"
	"clearly to reconsider to make it nicer to compose"
	
	| builder doc |
	builder := self new
		fileNamed: 'rmod.bib';
		toLatex;
		french; 
		setFilteringOn;
		yourself.
	doc := builder build document.
	
	"here we extract the associated bib"		
	CZLaTeXGenerator new 
			outputStream: (FileStream newFileNamed:  Date today yyyymmdd, '-stefFull.tex'); 
			visit: doc
		
	
]

{ #category : #building }
StefPublicationsDocBuilder >> addFooter [
	"ugly conditional but this is my code :)"

	noHeader ifTrue: [^self].
	doc footer:
			(CZFooter new
				text:
					(xhtml
						ifTrue: [ self xhtmlFooter ]
						ifFalse: [ self latexFooter ]))
]

{ #category : #building }
StefPublicationsDocBuilder >> addHeader [
	
	noHeader ifTrue: [^self].
	doc header:
			(CZHeader new
				text:
					(xhtml
						ifTrue: [ self xhtmlHeader ]
						ifFalse: [ self latexHeader ]))
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

{ #category : #'configuration public api' }
StefPublicationsDocBuilder >> fileNamed: aStringDotBib [
	
	| bibset2 | 
	bibset2 := CZBibParser parse: ((FileStream readOnlyFileNamed: aStringDotBib) contents).
	bibset2 scope: CZSet standardDefinitions.
	self bibset:  bibset2
	
	
]

{ #category : #initialize }
StefPublicationsDocBuilder >> initialize [

	super initialize.
	noHeader := false.
	xhtml := true.
	self authorMatchingString: '*Ducasse*'.
]

{ #category : #building }
StefPublicationsDocBuilder >> latexFooter [
	^ '\end{document}'
]

{ #category : #building }
StefPublicationsDocBuilder >> latexHeader [
	^ '\documentclass{article}
\usepackage[french]{babel}
\usepackage{times}
\usepackage[unitcntnoreset]{bibtopic}
\usepackage[numbers,sort&compress]{natbib}

\title{{\bf Prof. Dr. St\''ephane Ducasse}\\[0.5cm]
{\bf }}
\author{}
\begin{document}
\maketitle
\newcounter{publi}
\newcommand{\pub}[0]
	{\stepcounter{publi}
	\item[\bf{[\arabic{publi}]}]}
	
	'
]

{ #category : #accessing }
StefPublicationsDocBuilder >> noHeader [

	noHeader := true
]

{ #category : #accessing }
StefPublicationsDocBuilder >> toLatex [
	xhtml := false
]

{ #category : #accessing }
StefPublicationsDocBuilder >> toXhtml [
	xhtml := true
]

{ #category : #accessing }
StefPublicationsDocBuilder >> withHeader [

	noHeader := false
]

{ #category : #building }
StefPublicationsDocBuilder >> xhtmlFooter [
	^ '<h4>BibTex Files of the Publications</h4>
<A HREF="', Date today yyyymmdd, '-stefFull.bib', '">BibTex File</A> </div>  <!-- div xmlns= class="paperList" -->
	 </div><!-- mainContent -->
   </body>
</html>
'
]

{ #category : #building }
StefPublicationsDocBuilder >> xhtmlHeader [
	^ '<?xml version="1.0" encoding="ISO-8859-1"?>
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
         <div id="copyright">last revision: ' , Date today printString
		,
			'<br/></div>
				
		<div xmlns="" id="personalDetails">
            <div id="personalDetailsItem"> <A HREF="http://rmod.inria.lille.fr">Rmod</A></div>
		</div>		
      </div> <!-- menu-->
      <div id="mainContent">
	  <div xmlns="" class="paperList"><style type="text/css">
<!--
-->
</style>'
]
