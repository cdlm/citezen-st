"
A CZLaTeXGenerator is a generator generating nice latex.

Currently there is a problem with the generation because it is not simple to see that there is a _ or & in the input text since looking for only one character does not really work (usually we put \& and \_ so more logic should be done.).

"
Class {
	#name : #CZLaTeXGenerator,
	#superclass : #CZFileFormatGenerator,
	#instVars : [
		'fieldEmbellishingTable'
	],
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
CZLaTeXGenerator >> emitEntryHeader: anEntry [
	"Add to the outputStream a header for the correponding anEntry if needed."
	
	outputStream nextPutAll: '\pub '.
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
	fieldEmbellishingTable at: CZPool author put: '\emph{'.
	fieldEmbellishingTable at: CZPool booktitle put: 'In \emph{'.
	fieldEmbellishingTable at: CZPool title put: '\emph{'.
	fieldEmbellishingTable at: CZPool journal put: 'In \emph{'.

	
]

{ #category : #visiting }
CZLaTeXGenerator >> visitBibSet: aCZSet [
	
	"we should test and do not do anything if size is empty"
	
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
	fieldEmbellishingTable at: aField key ifPresent: [:t | self outputStream nextPutAll: '}'].
	aField key = CZPool editor
		ifTrue: [ self outputStream nextPutAll: ' ed.'].
]

{ #category : #visiting }
CZLaTeXGenerator >> visitPeople: aCZPeople [

	aCZPeople perform:  expandOption.
	self outputStream nextPutAll:  aCZPeople expanded "so that we are sure that we get \'' for é"
]

{ #category : #visiting }
CZLaTeXGenerator >> visitSection: aCZSection [

	self outputStream 
		nextPutAll: '\section{';
		nextPutAll: aCZSection name;
		nextPut: $}.
	self line
]

{ #category : #visiting }
CZLaTeXGenerator >> visitString: aCZString [
	outputStream nextPutAll: aCZString notExpanded asString
]
