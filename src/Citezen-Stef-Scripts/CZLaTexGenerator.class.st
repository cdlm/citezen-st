"
CZLaTexGenerator to be able to define somewhere a footer
"
Class {
	#name : #CZLaTexGenerator,
	#superclass : #CZPersonalGenerator,
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #'instance creation' }
CZLaTexGenerator class >> forStef [
	"self forStef"
	
	self new
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

{ #category : #configure }
CZLaTexGenerator >> typeOrientedConfiguration [
	"self new typeOrientedConfiguration"
	
	self document 
		displayFullName ;
		orderedList ;
		doNotRestartOrderedListAtEachScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in International Journals');
		addElement: self journalsScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in Top Conferences');
		addElement: self topConferencesScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in French Journals');					
		addElement: self nationalJournalsScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in International Conferences');
		addElement: self conferencesScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in National Conferences');
		addElement: self nationalConferencesScript;
		addElement: (CZTitleElement new 
							title: 'Invited Articles');
		addElement: self invitedScript;
		addElement: (CZTitleElement new 
							title: 'Book Chapters');
		addElement: self bookChapterScript;
		addElement: (CZTitleElement new 
							title: 'Books');
		addElement: self booksScript;
		addElement: (CZTitleElement new 
							title: 'Editor');
		addElement: self editorScript;
		addElement: (CZTitleElement new 
							title: 'Refereed Articles in International Workshops');
		addElement: self internationalWorkshopScript;
		addElement: (CZTitleElement new 
							title: 'PhD and Habilitation');
		addElement: self PhDAndHabilitation;
			addElement: (CZTitleElement new 
							title: 'Tool Demos');
		addElement: self toolDemosScript ;
			addElement: (CZTitleElement new 
							title: 'Vulgarisation');
		addElement: self vulgarisationsScript.
	
]
