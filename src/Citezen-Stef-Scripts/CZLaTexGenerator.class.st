"
CZLaTexGenerator to be able to define somewhere a footer
"
Class {
	#name : #CZLaTexGenerator,
	#superclass : #CZPersonalWebPageGenerator,
	#category : #'Citezen-Stef-Scripts'
}

{ #category : #'as yet unclassified' }
CZLaTexGenerator >> configure [

	self document footer: self latexFooter.
	self document header: '\end{document}'
]

{ #category : #'as yet unclassified' }
CZLaTexGenerator >> latexFooter [

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
	\item[\bf{[\arabic{publi}]}]}'
]
