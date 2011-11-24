"
CZLaTexGenerator to be able to define somewhere a footer
"
Class {
	#name : #CZLaTexGenerator,
	#superclass : #CZPersonalGenerator,
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #'instance creation' }
CZLaTexGenerator class >> forCassou [
	"self forCassou"
	
	CZLaTexGenerator new
		french;
		author: '*Cassou*';
		outputFileName: Date today yyyymmdd, '-cassou.tex';
		inputFileName: 'rmod.bib'; 
		typeOriented;
		generate.
]

{ #category : #'instance creation' }
CZLaTexGenerator class >> forNicolas [
	"self forNicolas"
	
	CZLaTexGenerator new
		french;
		author: '*Anquetil*';
		outputFileName: Date today yyyymmdd, '-nico.tex';
		inputFileName: 'rmod.bib'; 
		typeOriented;
		generate.
]

{ #category : #'instance creation' }
CZLaTexGenerator class >> forStef [
	"self forStef"
	
	self new
		french;
		author: '*Ducasse*';
		outputFileName: Date today yyyymmdd, '-stefFull.tex';
		inputFileName: 'rmod.bib'; 
		typeOriented;
		generate.
]

{ #category : #'as yet unclassified' }
CZLaTexGenerator >> configure [
	self document header: self latexHeader.
	self document footer: '\end{document}'
]

{ #category : #'as yet unclassified' }
CZLaTexGenerator >> latexHeader [

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

{ #category : #configure }
CZLaTexGenerator >> typeOriented [
	"Propagate input/output information, item configuration and format."
	
	self noWebFormat.
	self setDocument.
	self typeOrientedConfiguration.
	self document exportAsLaTeX.
	self configure. "Latex header"
]
