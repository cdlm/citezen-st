"
This class is a private class to play with the Script and Document to generate a couple of personal output. May be a generalization will be usefull to avoid that everybody is doing the same. but for now we are learning.

May be this class should be a subclass of CZDocument

Indeed we have to rethink that! Because I was also thinking that this class can be a subclass of CZDocument.
"
Class {
	#name : #CZPersonalWebPageGenerator,
	#superclass : #Object,
	#instVars : [
		'document',
		'outputFileName',
		'inputFileName',
		'conferenceDisplayPattern',
		'articleDisplayPattern',
		'allDisplayPattern'
	],
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #script }
CZPersonalWebPageGenerator >> PhDAndHabilitation [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: ((CZTypeQuery checks: [ :each | each = #phdthesis]) 
							OR: (CZFieldQuery 
									named: #annote 
									checks: [ :value | '*habilitation*' match: value ])))
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> allDisplayPattern [

	^ allDisplayPattern ifNil: [ allDisplayPattern := self allDisplayPatternDefault ]
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> allDisplayPatternDefault [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #journal;
			field: #booktitle;
			field: #volume;
			field: #pages;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #rate;
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> allDisplayPatternNoWeb [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #journal;
			field: #booktitle;
			field: #volume;
			field: #pages;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #rate;
			endsWith: '.'
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> articleDisplayPattern [

	^ articleDisplayPattern ifNil: [ articleDisplayPattern := self articleDisplayPatternDefault ]
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> articleDisplayPatternDefault [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #journal;
			field: #volume;
			field: #pages;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> articleDisplayPatternNoWeb [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #journal;
			field: #volume;
			field: #pages;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #rate;
			endsWith: '.'
]

{ #category : #parameters }
CZPersonalWebPageGenerator >> author [

	^ '*Ducasse*'
]

{ #category : #script }
CZPersonalWebPageGenerator >> bookChapterScript [ 
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor AND: (self withType: '*articlebook*') )
]

{ #category : #script }
CZPersonalWebPageGenerator >> booksScript [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (CZTypeQuery checks: [ :each | each = #book] ))
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> conferenceDisplayPattern [

	^ conferenceDisplayPattern ifNil: [ conferenceDisplayPattern := self conferenceDisplayPatternDefault ]
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> conferenceDisplayPatternDefault [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #booktitle;
			field: #volume;
			field: #pages;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #rate;
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> conferenceDisplayPatternNoWeb [

	^ CZDisplayPattern new 
			defaultSeparator: ', ';
			field: #author;
			field: #title;
			field: #booktitle;
			field: #volume;
			field: #pages;
			field: #publisher; 
			field: #year;
		"	separator: '---'; "
			field: #impactfactor;
			field: #misc;
			endsWith: '.'
]

{ #category : #script }
CZPersonalWebPageGenerator >> conferencesScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | ('*internationalconference*' match: value) 
													and: [('*topconference*' match: value) not ]]))
]

{ #category : #document }
CZPersonalWebPageGenerator >> configure [

	self document header: '<?xml version="1.0" encoding="ISO-8859-1"?>
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
</style>'.


	self document footer: '<h4>BibTex Files of the Publications</h4>
<A HREF="stef.bib">BibTex File</A> </div>  <!-- div xmlns= class="paperList" -->
	 </div><!-- mainContent -->
   </body>
</html>
'
]

{ #category : #accessing }
CZPersonalWebPageGenerator >> document [

	^ document ifNil: [document := CZDocument new]
]

{ #category : #script }
CZPersonalWebPageGenerator >> editorScript [
	
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: ((CZFieldQuery named: #editor checks: [ :value | self author match: value ])
					"AND: (CZBibFieldQuery 
								named: #annote 
								checks: [ :value | '*editor*' match: value ])"
					OR: (self withType: '*workshopproceedings*') )
]

{ #category : #public }
CZPersonalWebPageGenerator >> generateSortedByYear [
	"self new generateSortedByYear"
	
	self outputFile: 'stefY.html'.
	self inputFile: 'rmod.bib'.
	self setDocument..
	self document displayFullName.
	1999 to: 2009
		do: [:year | 
		self document 
				addElement: (CZTitleElement new  title: 'Articles in ', year asString; htmlLevel: 4);
				addElement: (self yearScript: year)].
	
	self document exportAsHtml. 
	self document generate.
	^ self document
]

{ #category : #public }
CZPersonalWebPageGenerator >> generateTypeOriented [
	"self new generateTypeOriented"
	
	self typeOriented.
	self configure.
	self document generate.
	^ self document
]

{ #category : #public }
CZPersonalWebPageGenerator >> generateTypeOriented20062009 [
	"self new generateTypeOriented20062009"
	
	self inputFileName: 'rmod.bib'.
	self document outputFile: 'stef2006-10.html'.
	self noWebFormat.
	
	self document bibsetInput: self select20062009.
	self typeOrientedConfiguration.
	self configure.
	self document exportAsHtml.
	self document generate.
	^ self document
]

{ #category : #public }
CZPersonalWebPageGenerator >> generateTypeOrientedAssociatedBibFile [
	"self new generateTypeOrientedAssociatedBibFile"
	
	| newbib |
	self typeOriented.
	self document fillUpOriginalSet.
	newbib := CZBibSetGatherer bibsetFrom: self document.
	newbib clean.
	^ CZBibtexOutputer new 
		setOutputFile: 'stef.bib';
		blackListedFields: CZEntry privateFields;
		initializeOutputStream; 
		visitSet: newbib;
		contents
]

{ #category : #'file parameter' }
CZPersonalWebPageGenerator >> inputFileName [
	^ inputFileName
]

{ #category : #'file parameter' }
CZPersonalWebPageGenerator >> inputFileName: aString [
	inputFileName := aString
]

{ #category : #script }
CZPersonalWebPageGenerator >> internationalWorkshopScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor AND: (self withType: '*internationalworkshop*') )
]

{ #category : #script }
CZPersonalWebPageGenerator >> invitedScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor AND: (self withType: '*invited*') )
]

{ #category : #script }
CZPersonalWebPageGenerator >> journalsScript [
	^ CZScript new
		id: 'journalsScript';
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: CZQuery isInternationalJournalQuery )
]

{ #category : #document }
CZPersonalWebPageGenerator >> metadata [

	self document addElement: (CZCommentElement new comment: 'Generated by Citezen --', Date today printString).
]

{ #category : #script }
CZPersonalWebPageGenerator >> nationalConferencesScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor AND: (self withType: 'nationalconference*') )
]

{ #category : #script }
CZPersonalWebPageGenerator >> nationalJournalsScript [ 
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | ('*nationaljournal*' match: value) and: [('*internationaljournal*' match: value) not] ]))
]

{ #category : #public }
CZPersonalWebPageGenerator >> noWebFormat [

	self setAllDisplayPattern: self allDisplayPatternNoWeb.
	self setArticleDisplayPattern: self articleDisplayPatternNoWeb.
	self setConferenceDisplayPattern:  self conferenceDisplayPatternNoWeb.
	

]

{ #category : #'file parameter' }
CZPersonalWebPageGenerator >> outputFileName [
	^ outputFileName 
]

{ #category : #'file parameter' }
CZPersonalWebPageGenerator >> outputFileName: aString [
	outputFileName := aString
]

{ #category : #public }
CZPersonalWebPageGenerator >> select20062009 [
	
	| rmod selected|	
	rmod :=  (CZBibParser parse: ((FileStream readOnlyFileNamed: inputFileName ) contents)).
	selected := rmod select: (CZFieldQuery 
					named: #year 
					checks: [ :value | value asNumber between: 2006 and: 2010]).
	^ selected
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> setAllDisplayPattern: aPattern [

	allDisplayPattern := aPattern
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> setArticleDisplayPattern: aPattern [

	articleDisplayPattern := aPattern
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> setConferenceDisplayPattern: aPattern [

	conferenceDisplayPattern := aPattern
]

{ #category : #accessing }
CZPersonalWebPageGenerator >> setDocument [

	self document 
		inputFile: inputFileName;
		outputFile: outputFileName 
]

{ #category : #script }
CZPersonalWebPageGenerator >> toolDemosScript [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (self withType: '*tooldemo*') )
]

{ #category : #script }
CZPersonalWebPageGenerator >> topConferencesScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (self withType: '*topconference*') )
]

{ #category : #public }
CZPersonalWebPageGenerator >> typeOriented [
	"self new generateTypeOriented"
	
	self outputFileName: 'stef.html'.
	self inputFileName: 'rmod.bib'.
	self setDocument.
	self typeOrientedConfiguration.
	self document exportAsHtml.
	
]

{ #category : #public }
CZPersonalWebPageGenerator >> typeOrientedConfiguration [
	"self new typeOrientedConfiguration"
	
	self document 
		displayFullName ;
		orderedList ;
		doNotRestartOrderedListAtEachScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in International Journals'; htmlLevel: 4);
		addElement: self journalsScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in Top Conferences'; htmlLevel: 4);
		addElement: self topConferencesScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in French Journals'; htmlLevel: 4);					
		addElement: self nationalJournalsScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in International Conferences'; htmlLevel: 4);
		addElement: self conferencesScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in National Conferences'; htmlLevel: 4);
		addElement: self nationalConferencesScript;
		addElement: (CZTitleElement new 
							title: 'Invited Articles'; htmlLevel: 4);
		addElement: self invitedScript;
		addElement: (CZTitleElement new 
							title: 'Book Chapters'; htmlLevel: 4);
		addElement: self bookChapterScript;
		addElement: (CZTitleElement new 
							title: 'Books'; htmlLevel: 4);
		addElement: self booksScript;
		addElement: (CZTitleElement new 
							title: 'Editor'; htmlLevel: 4);
		addElement: self editorScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in International Workshops'; htmlLevel: 4);
		addElement: self internationalWorkshopScript;
		addElement: (CZTitleElement new 
							title: 'PhD and Habilitation'; htmlLevel: 4);
		addElement: self PhDAndHabilitation;
			addElement: (CZTitleElement new 
							title: 'Tool Demos'; htmlLevel: 4);
		addElement: self toolDemosScript ;
			addElement: (CZTitleElement new 
							title: 'Vulgarisation'; htmlLevel: 4);
		addElement: self vulgarisationsScript.
	
]

{ #category : #script }
CZPersonalWebPageGenerator >> vulgarisationsScript [
	^ CZScript new
		displayPattern: self allDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: (self withType: '*vulgarisation*') )
]

{ #category : #queries }
CZPersonalWebPageGenerator >> withAuthor [
	^ CZFieldQuery named: #author checks: [ :value | self author match: value ]
]

{ #category : #queries }
CZPersonalWebPageGenerator >> withType: aQueryString [

	^ CZFieldQuery 
			named: #annote 
			checks: [ :value | aQueryString match: value ]
]

{ #category : #script }
CZPersonalWebPageGenerator >> yearScript: aYear [
 
	^ CZScript new
		displayPattern: self allDisplayPattern;
		sortByField: #author;
		query: (self withAuthor 
					AND: (CZFieldQuery 
								named: #year 
								checks: [ :value | value asInteger = aYear ]))
]
