"
A CZFileLoader loads and parse a file from a file.

CZFileLoader bibFromFileNamed: 'others.bib'.

CZFileLoader bibFromFileNamed: 'rmod.bib'.
"
Class {
	#name : #CZFileLoader,
	#superclass : #CZTool,
	#category : #'Citezen-Tools'
}

{ #category : #'instance creation' }
CZFileLoader class >> bibFromFileNamed: aString [
	^ (CZBibParser parse: ((FileStream readOnlyFileNamed: aString) contents)).
]
