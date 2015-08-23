"
'<h4>BibTex Files of the Publications</h4>
<A HREF=""', self bibtexFileName,  '"">BibTex File</A> 
	 </div><!-- mainContent -->
   </body>
</html>
' withUnixLineEndings 

"
Class {
	#name : #StefDocBuilder,
	#superclass : #Object,
	#category : #'Citezen-Stef'
}

{ #category : #hackish }
StefDocBuilder >> bibtexFileName [

	^ 'rmod.bib'
]

{ #category : #hackish }
StefDocBuilder >> buildLatex [
	"self new buildLatex"
	
	| builder |
	builder := CZLaTeXDocBuilder new
		fileNamed: 'rmod.bib';
		authorMatchingString: self pattern;
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
			  #misc); 
		headerString: self latexHeaderString; 
		setFilteringOn.
	builder generate.	
]

{ #category : #hackish }
StefDocBuilder >> buildXHTML [
	"self new buildXHTML"

	| builder |
	builder := CZXHTMLDocBuilder new
		fileNamed: 'rmod.bib';
		authorMatchingString: self pattern;
		english; 
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
			  #misc
			  #url
			  #doi); "removed doi and url since they may contain _ and the generator does not handle that well for the moment."
		headerString: self xmlHeaderString;
		footerString: self xmlFooterString; 
		setFilteringOn.
	builder generate.	
]

{ #category : #hackish }
StefDocBuilder >> generate [
	"self new generate"
	self buildLatex.
	self buildXHTML.
	
]

{ #category : #hackish }
StefDocBuilder >> latexHeaderString [

	^ '\documentclass{article}
\usepackage{times}

\newcommand{\czauthors}[1]{#1}
\newcommand{\cztitle}[1]{\emph{``#1''''}}
\newcommand{\czjournal}[1]{#1}
\newcommand{\czbooktitle}[1]{#1}

\title{{\bf Prof. Dr. St\''ephane Ducasse}\\[0.5cm]
{\bf }}
\author{}
\begin{document}
\maketitle
\newcounter{publi}
\newcommand{\pub}[0]
	{\stepcounter{publi}
	\item[\bf{[\arabic{publi}]}]}

	' withUnixLineEndings



]

{ #category : #hackish }
StefDocBuilder >> pattern [

	^ '*Ducasse*'
]

{ #category : #hackish }
StefDocBuilder >> xhtmlName [

	^ 'Dr. S. Ducasse'
]

{ #category : #hackish }
StefDocBuilder >> xmlFooterString [

	^ '<h4>BibTex Files of the Publications</h4>
<A HREF="', self bibtexFileName,  '">BibTex File</A> 
	 </div><!-- mainContent -->
   </body>
</html>
' withUnixLineEndings 

]

{ #category : #hackish }
StefDocBuilder >> xmlHeaderString [
	^ '<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<link rel="stylesheet" href="CSS/Stef.css"/>
     <title>', self xhtmlName, '</title>
   </head>
   <body>
<div id="header">
<div id="headerSideTitle">
St&eacute;phane Ducasse</div>    <!--Closing headerSideTitle --><div id="headerPageTitle">
Publications</div>    <!--Closing headerPageTitle --></div>    <!--Closing header --><div id="menu">
<div id="toc">
<div id="tocItem">
<a href="index.html">Home</a></div>    <!--Closing tocItem -->
<div id="tocItem">
<a href="http://www.pharo-project.org">Pharo</a></div>    <!--Closing tocItem -->
<div id="tocItem">
<a href="Publications.html">Publications</a></div>    <!--Closing tocItem -->
<div id="tocItem">
<a href="Books.html">Books</a></div>    <!--Closing tocItem -->
<div id="tocItem">
<a href="FreeBooks.html">Free Smalltalk Books</a></div>    <!--Closing tocItem -->
<div id="tocItem">
<a href="Resources.html">Downloads/Resources</a></div>    <!--Closing tocItem -->
<div id="tocItem">
<a href="Teaching.html">Lectures and Presentations</a></div>    <!--Closing tocItem -->
<div id="tocItem">
<a href="Coordinates.html">Coordinates</a></div>    <!--Closing tocItem --></div>    <!--Closing toc --></div>    <!--Closing menu --><div id="mainContent">
<div id="personalDetails">
<div>
<img src="StefFingerOnNose128.jpg">
</div>
<div id="personalDetailsItem">
<a href="http://www.inria.fr/">INRIA</a></div>    <!--Closing personalDetailsItem -->
<div id="personalDetailsItem">
<a href="http://rmod.lille.inria.fr/">RMOD</a></div>    <!--Closing personalDetailsItem -->
<div id="personalDetailsItem">
<a href="mailto:stephane.ducasse@inria.fr">Stephane.Ducasse(@At@)inria.fr</a></div>    <!--Closing personalDetailsItem --></div>    <!--Closing personalDetails -->' withUnixLineEndings 
]
