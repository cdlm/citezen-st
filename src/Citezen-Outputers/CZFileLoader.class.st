Class {
	#name : #CZFileLoader,
	#superclass : #CZTool,
	#category : #'Citezen-Outputers'
}

{ #category : #'instance creation' }
CZFileLoader class >> bibFromFileNamed: aString [
	^ (CZBibParser parse: ((FileStream readOnlyFileNamed: aString) contents)).
]
