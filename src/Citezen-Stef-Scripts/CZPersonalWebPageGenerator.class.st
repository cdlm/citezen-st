"
This class is a private class to play with the Script and Document to generate a couple of personal output. May be a generalization will be usefull to avoid that everybody is doing the same. but for now we are learning.

May be this class should be a subclass of CZDocument
"
Class {
	#name : #CZPersonalWebPageGenerator,
	#superclass : #Object,
	#instVars : [
		'document'
	],
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #script }
CZPersonalWebPageGenerator >> PhDAndHabilitation [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: ((CZTypeQuery checks: [ :each | each = #phdthesis]) 
							OR: (CZFieldQuery 
									named: #annote 
									checks: [ :value | '*habilitation*' match: value ])))
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> allDisplayPattern [

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
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> articleDisplayPattern [

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

{ #category : #script }
CZPersonalWebPageGenerator >> bookChapterScript [ 
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*articlebook*' match: value ]))
]

{ #category : #script }
CZPersonalWebPageGenerator >> booksScript [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZTypeQuery checks: [ :each | each = #book] ))
]

{ #category : #patterns }
CZPersonalWebPageGenerator >> conferenceDisplayPattern [

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
			field: #impactFactor;
			field: #url;
			field: #doi;
			endsWith: '.'
]

{ #category : #script }
CZPersonalWebPageGenerator >> conferencesScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
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
		query: ((CZFieldQuery named: #editor checks: [ :value | '*Ducasse*' match: value ])
					"AND: (CZBibFieldQuery 
								named: #annote 
								checks: [ :value | '*editor*' match: value ])"
					OR: (CZFieldQuery
								named: #annot
								checks: [:value | '*workshopproceedings*' match: value]			
								))
]

{ #category : #public }
CZPersonalWebPageGenerator >> generateSortedByYear [
	"self new generateSortedByYear"
	
	self inoutYear.
	self document 
		displayFullName.
	1999 to: 2009
		do: [:year | 
		self document 
				addElement: (CZTitleElement new 
							title: 'Articles in ', year asString; htmlLevel: 4);
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
CZPersonalWebPageGenerator >> inout [

	self document
		inputFile: 'all.bib';
		outputFile: 'stef.html'.
]

{ #category : #'file parameter' }
CZPersonalWebPageGenerator >> inoutYear [ 

	self document
		inputFile: 'scg.bib';
		outputFile: 'stefY.html'.
]

{ #category : #script }
CZPersonalWebPageGenerator >> internationalWorkshopScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*internationalworkshop*' match: value ]))
]

{ #category : #script }
CZPersonalWebPageGenerator >> invitedScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*invited*' match: value ]))
]

{ #category : #script }
CZPersonalWebPageGenerator >> journalsScript [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*internationaljournal*' match: value ]))
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
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | 'nationalconference*' match: value ]))
]

{ #category : #script }
CZPersonalWebPageGenerator >> nationalJournalsScript [ 
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | ('*nationaljournal*' match: value) and: [('*internationaljournal*' match: value) not] ]))
]

{ #category : #queries }
CZPersonalWebPageGenerator >> onlyStefAuthor [
	^ CZFieldQuery named: #author checks: [ :value | '*Ducasse*' match: value ]
]

{ #category : #script }
CZPersonalWebPageGenerator >> toolDemosScript [
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*tooldemo*' match: value ]))
]

{ #category : #script }
CZPersonalWebPageGenerator >> topConferencesScript [
	^ CZScript new
		displayPattern: self conferenceDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*topconference*' match: value ]))
]

{ #category : #public }
CZPersonalWebPageGenerator >> typeOriented [
	"self new generateTypeOriented"
	
	self inout.
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
							title: 'Refereed Articles in Conferences'; htmlLevel: 4);
		addElement: self conferencesScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in National Conferences'; htmlLevel: 4);
		addElement: self nationalConferencesScript;
		addElement: (CZTitleElement new 
							title: 'Invited Articles'; htmlLevel: 4);
		addElement: self invitedScript;
		addElement: (CZTitleElement new 
							title: 'Book Chapter'; htmlLevel: 4);
		addElement: self bookChapterScript;
		addElement: (CZTitleElement new 
							title: 'Books'; htmlLevel: 4);
		addElement: self booksScript;
		addElement: (CZTitleElement new 
							title: 'Editor'; htmlLevel: 4);
		addElement: self editorScript;
		addElement: (CZTitleElement new 
							title: 'International Workshops Refereed Articles'; htmlLevel: 4);
		addElement: self internationalWorkshopScript;
		addElement: (CZTitleElement new 
							title: 'PhD and Habilitation'; htmlLevel: 4);
		addElement: self PhDAndHabilitation;
			addElement: (CZTitleElement new 
							title: 'Tool Demo'; htmlLevel: 4);
		addElement: self toolDemosScript ;
			addElement: (CZTitleElement new 
							title: 'Vulgarisation'; htmlLevel: 4);
		addElement: self vulgarisationsScript.
	self document exportAsHtml. 
	
]

{ #category : #script }
CZPersonalWebPageGenerator >> vulgarisationsScript [
	^ CZScript new
		displayPattern: self allDisplayPattern;
		reversedSortByField: #year;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #annote 
								checks: [ :value | '*vulgarisation*' match: value ]))
]

{ #category : #script }
CZPersonalWebPageGenerator >> yearScript: aYear [
 
	^ CZScript new
		displayPattern: self allDisplayPattern;
		sortByField: #author;
		query: (self onlyStefAuthor 
					AND: (CZFieldQuery 
								named: #year 
								checks: [ :value | value asInteger = aYear ]))
]
