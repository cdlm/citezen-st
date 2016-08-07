"
To generate XHTML

self build

Normally since we refer to the bibtex file we should invoke the CZBibSingleAuthorDocBuilder, but this is to be done. 
"
Class {
	#name : #CZXHTMLDocBuilder,
	#superclass : #CZDecoratedDocBuilder,
	#category : #'Citezen-Reborn-DocumentBuilder'
}

{ #category : #'as yet unclassified' }
CZXHTMLDocBuilder class >> build [

	| builder |
	builder :=  self new
		french; 
		fileNamed: 'rmod.bib';
		setFilteringOn;
		yourself.
	builder generate.
	"builder generateBibtexFile."
]

{ #category : #xhtml }
CZXHTMLDocBuilder >> bibtexFileName [

	^ Date today yyyymmdd, 'bibtex.bib'
]

{ #category : #xhtml }
CZXHTMLDocBuilder >> defaultFooterString [
	^ '<h4>BibTex Files of the Publications</h4>
<A HREF="', self bibtexFileName,  '">BibTex File</A> </div>  <!-- div xmlns= class="paperList" -->
	 </div><!-- mainContent -->
   </body>
</html>
'
]

{ #category : #xhtml }
CZXHTMLDocBuilder >> defaultHeaderString [
	^ '<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
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
</style>' withUnixLineEndings 
]

{ #category : #utils }
CZXHTMLDocBuilder >> extension [

	^ '-Full.html'
]

{ #category : #xhtml }
CZXHTMLDocBuilder >> footerString [
	^ '<h4>BibTex Files of the Publications</h4>
<A HREF="', self bibtexFileName,  '">BibTex File</A> </div>  <!-- div xmlns= class="paperList" -->
	 </div><!-- mainContent -->
   </body>
</html>
'
]

{ #category : #utils }
CZXHTMLDocBuilder >> generatorClass [
	^ CZHTMLGenerator
	
]

{ #category : #xhtml }
CZXHTMLDocBuilder >> xhtmlName [

	^ 'Foo'
]
