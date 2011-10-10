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

{ #category : #configure }
CZLaTexGenerator >> typeOrientedConfiguration [
	"self new typeOrientedConfiguration"
	
	self document 
		displayFullName ;
		orderedList ;
		doNotRestartOrderedListAtEachScript;
		addElement: (CZTitleElement new title: localization  internationalReviewedJournal; htmlLevel: 4);
		addElement: self journalsScript;
		
		addElement: (CZTitleElement new title:  localization topConferences; htmlLevel: 4);
		addElement: self topConferencesScript;
		
		addElement: (CZTitleElement new title: localization nationalReviewedJournal ; htmlLevel: 4);					
		addElement: self nationalJournalsScript;
		
		addElement: (CZTitleElement new title: localization internationalConference; htmlLevel: 4);
		addElement: self conferencesScript;
		
		addElement: (CZTitleElement new title: localization nationalReviewedConference; htmlLevel: 4);
		addElement: self nationalConferencesScript;
		addElement: (CZTitleElement new  title: localization invitedPapers; htmlLevel: 4);
		addElement: self invitedScript;
		addElement: (CZTitleElement new  title: localization bookChapters; htmlLevel: 4);
		addElement: self bookChapterScript;
		addElement: (CZTitleElement new  title: localization books; htmlLevel: 4);
		addElement: self booksScript;
		addElement: (CZTitleElement new  title: localization editor; htmlLevel: 4);
		addElement: self editorScript;
		addElement: (CZTitleElement new  title: localization internationalReviewedWorkshops; htmlLevel: 4);
		addElement: self internationalWorkshopScript;
		"addElement: (CZTitleElement new 
							title: 'PhD and Habilitation'; htmlLevel: 4);
		addElement: self PhDAndHabilitation;"
			addElement: (CZTitleElement new  title: localization toolDemo; htmlLevel: 4);
		addElement: self toolDemosScript ;
			addElement: (CZTitleElement new  title: localization vulgarisation; htmlLevel: 4);
		addElement: self vulgarisationsScript.
	
]
