"
This class is a private class to play with the Script and Document to generate a couple of personal output. May be a generalization will be usefull to avoid that everybody is doing the same. but for now we are learning.

May be this class should be a subclass of CZDocument

Indeed we have to rethink that! Because I was also thinking that this class can be a subclass of CZDocument.
"
Class {
	#name : #CZWebPageGenerator,
	#superclass : #CZPersonalGenerator,
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #'as yet unclassified' }
CZWebPageGenerator class >> forStef [
	"self forStef"
	
	self new
		french; 
		author: '*Ducasse*';
		outputFileName: Date today yyyymmdd, '-stefFull.html';
		inputFileName: 'rmod.bib'; 
		typeOriented;
		generate.
]

{ #category : #'as yet unclassified' }
CZWebPageGenerator class >> todo [

	^ 'the exporters should work on a potentially external stream'
]

{ #category : #document }
CZWebPageGenerator >> configure [

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

{ #category : #oldexperiments }
CZWebPageGenerator >> generateSortedByYear [
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

{ #category : #oldexperiments }
CZWebPageGenerator >> generateTypeOriented [
	"self new generateTypeOriented"
	
	self typeOriented.
	self configure.
	self document generate.
	^ self document
]

{ #category : #oldexperiments }
CZWebPageGenerator >> generateTypeOriented20062009 [
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

{ #category : #oldexperiments }
CZWebPageGenerator >> select20062009 [
	
	| rmod selected|	
	rmod :=  (CZBibParser parse: ((FileStream readOnlyFileNamed: inputFileName ) contents)).
	selected := rmod select: (CZFieldQuery 
					named: #year 
					checks: [ :value | value asNumber between: 2006 and: 2010]).
	^ selected
]

{ #category : #public }
CZWebPageGenerator >> typeOriented [
	"Propagate input/output information, item configuration and format."
	
	self setDocument.
	self typeOrientedConfiguration.
	self document exportAsHtml.
	self configure. "xHTML header"
]
