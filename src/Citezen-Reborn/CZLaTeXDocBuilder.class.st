"
To build a latex document


| builder |
builder := self new
		fileNamed: 'rmod.bib';
		authorMatchingString: '*Ducasse*';
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
			  #misc); ""removed doi and url since they may contain _ and the generator does not handle that well for the moment.""
		setFilteringOn.
	builder generate.	
		


"
Class {
	#name : #CZLaTeXDocBuilder,
	#superclass : #CZDecoratedDocBuilder,
	#category : #'Citezen-Reborn'
}

{ #category : #building }
CZLaTeXDocBuilder >> defaultFooterString [
	^ '\end{document}'
]

{ #category : #building }
CZLaTeXDocBuilder >> defaultHeaderString [

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

{ #category : #utils }
CZLaTeXDocBuilder >> extension [
	^ '-Full.tex'
]

{ #category : #utils }
CZLaTeXDocBuilder >> generatorClass [
	^ CZLaTeXGenerator 
]

{ #category : #latex }
CZLaTeXDocBuilder >> latexName [

	^ 'Foo'
]
