"
A CZLaTeXGenerator is a generator generating nice latex.
"
Class {
	#name : #CZLaTeXGenerator,
	#superclass : #CZFileFormatGenerator,
	#category : #'Citezen-Reborn'
}

{ #category : #configuration }
CZLaTeXGenerator >> defaultFooter [
	^ '\end{document}' withUnixLineEndings
]

{ #category : #configuration }
CZLaTeXGenerator >> defaultHeader [
	^ '\documentclass{article}
\usepackage[french]{babel}
\usepackage{times}

\title{{\bf Prof. Dr. St\''ephane Ducasse}\\[0.5cm]
{\bf }}
\author{}
\begin{document}
\maketitle


	' withUnixLineEndings
]

{ #category : #configuration }
CZLaTeXGenerator >> visitString: aCZString [
	outputStream nextPutAll: aCZString notExpanded asString
]
