"
A CZLaTeXGenerator is a generator generating nice latex.

Currently there is a problem with the generation because it is not simple to see that there is a _ or & in the input text since looking for only one character does not really work (usually we put \& and \_ so more logic should be done.).


| visitor bibset |
bibset := CZBibParser parse: (FileStream readOnlyFileNamed: 'rmod.bib') contents.
bibset scope: CZSet standardDefinitions.
visitor := CZLaTeXGenerator new filename: 'rmod-Generated.tex'.
visitor visit: bibset.

"
Class {
	#name : #CZLaTeXGenerator,
	#superclass : #CZFileFormatGenerator,
	#instVars : [
		'fieldEmbellishingTable'
	],
	#category : 'Citezen-Reborn-FormattingVisitors'
}

{ #category : #configuration }
CZLaTeXGenerator >> defaultFooter [
	^ '\end{document}' withUnixLineEndings
]

{ #category : #configuration }
CZLaTeXGenerator >> defaultHeader [
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

{ #category : #configuration }
CZLaTeXGenerator >> emitEntryHeader: anEntry [
	"Add to the outputStream a header for the correponding anEntry if needed."
	
	outputStream nextPutAll: '
	\pub '.
]

{ #category : #initialize }
CZLaTeXGenerator >> initialize [

	super initialize.
	self initializeFieldEmbellishingTable.

]

{ #category : #initialize }
CZLaTeXGenerator >> initializeFieldEmbellishingTable [
	"Rather ugly but it works!"
	
	fieldEmbellishingTable := Dictionary new. 
	fieldEmbellishingTable at: CZPool author put: '\czauthors{'.
	fieldEmbellishingTable at: CZPool booktitle put: 'In \czbooktitle{'.
	fieldEmbellishingTable at: CZPool title put: '\cztitle{'.
	fieldEmbellishingTable at: CZPool journal put: 'In \czjournal{'.

	
]

{ #category : #'string encoding hooks' }
CZLaTeXGenerator >> treatTexEncoding: aString [
	"we want the tex encodings"

	^ aString notExpanded
]

{ #category : #visiting }
CZLaTeXGenerator >> visitBibSet: aCZSet [

	aCZSet isEmpty ifTrue: [ ^self ].
	self outputStream nextPutAll: '\begin{itemize}'.
	super visitBibSet: aCZSet.
	self outputStream nextPutAll: '\end{itemize}'
]

{ #category : #visiting }
CZLaTeXGenerator >> visitComment: aCZCommentElement [

	self outputStream 
		nextPutAll: '%%',aCZCommentElement text.
	self line ; line	
		
	
]

{ #category : #visiting }
CZLaTeXGenerator >> visitField: aField [
	"We should probably use phrases instead of doing everything ourselves."
	
	aField key = CZPool volume ifTrue: [self outputStream nextPutAll: 'Volume '].
	aField key = CZPool pages ifTrue: [self outputStream nextPutAll: 'pp. '].

	fieldEmbellishingTable at: aField key ifPresent: [:t | self outputStream nextPutAll: ' ', t].
	aField dispatchVisitor: self.
	"One day I have to think about this dispatch ugly point"
	fieldEmbellishingTable at: aField key ifPresent: [:t | self outputStream nextPutAll: '}'].
	aField key = CZPool editor
		ifTrue: [ self outputStream nextPutAll: ' ed.'].
]

{ #category : #visiting }
CZLaTeXGenerator >> visitPeople: aCZPeople [

	aCZPeople perform:  expandOption.
	self outputStream nextPutAll:  aCZPeople notExpanded "so that we are sure that we get \'' for é"
]

{ #category : #visiting }
CZLaTeXGenerator >> visitSectionText: aCZText [

	self outputStream 
		nextPutAll: aCZText text.
	self line
]

{ #category : #visiting }
CZLaTeXGenerator >> visitSectionTitle: aCZString [

	self outputStream 
		nextPutAll: '\section{';
		nextPutAll: aCZString notExpanded;
		nextPut: $}.
	self line
]

{ #category : #visiting }
CZLaTeXGenerator >> visitString: aCZString [
	
	| latexifiedString |
	latexifiedString := aCZString notExpanded asString.
	
	"latexifiedString := (latexifiedString copyReplaceAll: '&' with: '\&')."
	"could be done smarter but no time to be smart"
	outputStream nextPutAll: latexifiedString.
]
