"
A CZFileLoader loads and parse a file from a file.
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
