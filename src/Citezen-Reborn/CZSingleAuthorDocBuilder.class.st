"
I manage author filtering.

Now this is not easy to pass the settings to the visitor (like the order of the fields)
"
Class {
	#name : #CZSingleAuthorDocBuilder,
	#superclass : #CZDocBuilder,
	#instVars : [
		'noHeader',
		'xhtml'
	],
	#category : #'Citezen-Reborn-DocumentBuilder'
}

{ #category : #Bibtex }
CZSingleAuthorDocBuilder class >> bibtex [
	"self bibtex"
	| builder|
	builder := self new
		fileNamed: 'rmod.bib';
		setFilteringOn;
		yourself.
	builder generateBibtexFile
]

{ #category : #Bibtex }
CZSingleAuthorDocBuilder class >> latex [
	"self latex"
	
	| builder |
	builder := self new
		fileNamed: 'rmod.bib';
		toLatex;
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
			  #misc); "removed doi and url since they may contain _ and the generator does not handle that well for the moment."
		setFilteringOn;
		yourself.
	builder generateLatexFile.
	
]

{ #category : #doit }
CZSingleAuthorDocBuilder class >> xhtml [
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
CZSingleAuthorDocBuilder >> addFooter [
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
CZSingleAuthorDocBuilder >> addHeader [
	
	noHeader ifTrue: [^self].
	doc header:
			(CZHeader new
				text:
					(xhtml
						ifTrue: [ self xhtmlHeader ]
						ifFalse: [ self latexHeader ]))
]

{ #category : #utils }
CZSingleAuthorDocBuilder >> bibtexFileName [

	^ Date today yyyymmdd, 'bibtex.bib'
]

{ #category : #building }
CZSingleAuthorDocBuilder >> buildBody [

	self addBibSection: (self internationalJournalQuery) withTitle: localization  internationalReviewedJournal;
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
CZSingleAuthorDocBuilder >> filter [

	super filter.
	workingBibSet := workingBibSet select: self authorQuery
]

{ #category : #utils }
CZSingleAuthorDocBuilder >> generateBibtexFile [

	self generateBibtexFileFor: self build document.
]

{ #category : #utils }
CZSingleAuthorDocBuilder >> generateBibtexFileFor: aDoc [

	| visitor | 
	visitor := CZBibTexGenerator new.
	fieldOrder ifNotNil: [visitor fieldOrder: fieldOrder].
	visitor outputStream: (FileStream newFileNamed: self bibtexFileName). 
	visitor visit: aDoc
]

{ #category : #utils }
CZSingleAuthorDocBuilder >> generateLatexFile [

	self generateLatexFileFor: self build document.
]

{ #category : #utils }
CZSingleAuthorDocBuilder >> generateLatexFileFor: aDoc [

	| visitor | 
	visitor := CZLaTeXGenerator new.
	fieldOrder ifNotNil: [visitor fieldOrder: fieldOrder].
	visitor outputStream: (FileStream newFileNamed:  Date today yyyymmdd, '-Full.tex').
	visitor visit: aDoc
	
]

{ #category : #utils }
CZSingleAuthorDocBuilder >> generateXHTMLFile [

	self generateXHTMLFileFor: self build document.
]

{ #category : #utils }
CZSingleAuthorDocBuilder >> generateXHTMLFileFor: aDoc [
	| visitor |
	visitor := self htmlGeneratorClass new.
	fieldOrder ifNotNil: [ visitor fieldOrder: fieldOrder ].
	visitor
		outputStream: (FileStream newFileNamed: Date today yyyymmdd , '-Full.html');
		visit: aDoc
]

{ #category : #accessing }
CZSingleAuthorDocBuilder >> htmlGeneratorClass [
	^ CZHTMLGenerator
	
]

{ #category : #initialize }
CZSingleAuthorDocBuilder >> initialize [

	super initialize.
	noHeader := false.
	xhtml := true.
]

{ #category : #latex }
CZSingleAuthorDocBuilder >> latexFooter [
	^ '\end{document}'
]

{ #category : #latex }
CZSingleAuthorDocBuilder >> latexHeader [
	"there is something not working well since the visitor may require some different package so the logic should not really be totally define here. We will have to fix that. For now when a document as a header or footer it is used (not the one of the generator)"

	^ '\documentclass{article}
\usepackage{times}

\newcommand{\czauthors}[1]{#1}
\newcommand{\cztitle}[1]{\emph{``#1''''}}
\newcommand{\czjournal}[1]{#1}
\newcommand{\czbooktitle}[1]{#1}

\title{{\bf ', self latexName, '}\\[0.5cm]
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

{ #category : #latex }
CZSingleAuthorDocBuilder >> latexName [

	^ 'Foo'
]

{ #category : #accessing }
CZSingleAuthorDocBuilder >> noHeader [

	noHeader := true
]

{ #category : #accessing }
CZSingleAuthorDocBuilder >> toLatex [
	xhtml := false
]

{ #category : #accessing }
CZSingleAuthorDocBuilder >> toXhtml [
	xhtml := true
]

{ #category : #accessing }
CZSingleAuthorDocBuilder >> withHeader [

	noHeader := false
]

{ #category : #xhtml }
CZSingleAuthorDocBuilder >> xhtmlFooter [
	^ '<h4>BibTex Files of the Publications</h4>
<A HREF="', self bibtexFileName,  '">BibTex File</A> </div>  <!-- div xmlns= class="paperList" -->
	 </div><!-- mainContent -->
   </body>
</html>
'
]

{ #category : #xhtml }
CZSingleAuthorDocBuilder >> xhtmlHeader [
	^ '<?xml version="1.0" encoding="ISO-8859-1"?>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
   <head>
      <title>', self xhtmlName, '</title>
   </head>
   <body>
      <div id="header">
         <div id="headerSiteTitle">', self xhtmlName, '</div>
         <div id="headerPageTitle">Publications</div>
      </div><!-- header-->
      <div id="mainContent">
	  <div xmlns="" class="paperList"><style type="text/css">
<!--
-->
</style>'
]

{ #category : #xhtml }
CZSingleAuthorDocBuilder >> xhtmlName [

	^ 'Foo'
]
