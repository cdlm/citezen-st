Class {
	#name : #CZDocument,
	#superclass : #Object,
	#instVars : [
		'originalBibset',
		'outputFile',
		'outputer',
		'elements',
		'entriesDisplayed',
		'listIndex',
		'restartOrdered',
		'withoutHeaderAndFooter',
		'header',
		'footer'
	],
	#classInstVars : [
		'exportTypeMatching'
	],
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZDocument class >> bibExporterEncoding [
	^ #bib
]

{ #category : #'as yet unclassified' }
CZDocument class >> defaultExportType [ 
	^ self bibExporterEncoding 
]

{ #category : #'as yet unclassified' }
CZDocument class >> defaultOutputer [ 
	^ self matchType: self defaultExportType 
]

{ #category : #'as yet unclassified' }
CZDocument class >> htmlExporterEncoding [
	^ #html
]

{ #category : #'as yet unclassified' }
CZDocument class >> initializeExportTypeMatching [
	exportTypeMatching := Dictionary new.
	exportTypeMatching 
		add: (self bibExporterEncoding) -> CZRawOutputer;
		add: (self htmlExporterEncoding) -> CZHtmlOutputer 
		
]

{ #category : #'as yet unclassified' }
CZDocument class >> matchType: aString [
	exportTypeMatching ifNil: [ self initializeExportTypeMatching ].
	^ exportTypeMatching at: aString ifAbsent: self defaultExportType
]

{ #category : #'as yet unclassified' }
CZDocument >> acceptVisitor: aVisitor [
	aVisitor visitDocument: self
]

{ #category : #'as yet unclassified' }
CZDocument >> addElement: aDocumentElement [
	(aDocumentElement isNil | elements includes: aDocumentElement)
		ifFalse: [ 
			elements add: aDocumentElement.
			(aDocumentElement class = CZScript) ifTrue: [ aDocumentElement document: self ] ]
]

{ #category : #'as yet unclassified' }
CZDocument >> addEntriesDisplayed: aNumber [
	restartOrdered ifFalse: [
	listIndex := listIndex + aNumber ]
]

{ #category : #'as yet unclassified' }
CZDocument >> elements [
	^ elements 
]

{ #category : #'as yet unclassified' }
CZDocument >> exportAsBib [
	self exportType: self class bibExporterEncoding
]

{ #category : #'as yet unclassified' }
CZDocument >> exportAsHtml [
	self exportType: self class htmlExporterEncoding
]

{ #category : #'as yet unclassified' }
CZDocument >> exportType: aString [
	outputer := (self class matchType: aString) new
]

{ #category : #'as yet unclassified' }
CZDocument >> footer [
	^ footer
]

{ #category : #'as yet unclassified' }
CZDocument >> footer: aString [
	footer := aString 
]

{ #category : #'as yet unclassified' }
CZDocument >> generate [
	outputer ifNil: [ outputer := self class defaultOutputer ].
	outputer setOutputFile: outputFile.
	
	outputer getOutputFor: self
	

]

{ #category : #'as yet unclassified' }
CZDocument >> getWithoutHeaderAndFooter [
	^ withoutHeaderAndFooter 
]

{ #category : #'as yet unclassified' }
CZDocument >> header [ 
	^ header 
]

{ #category : #'as yet unclassified' }
CZDocument >> header: aString [
	header := aString 
]

{ #category : #'as yet unclassified' }
CZDocument >> initialize [ 
	super initialize.
	
	self unorderedList.
	elements := OrderedCollection new.
	withoutHeaderAndFooter := false.
	header := nil.
	footer := nil.
]

{ #category : #'as yet unclassified' }
CZDocument >> inputFile: aString [
	originalBibset := CZBibParser parse: ((FileStream readOnlyFileNamed: aString) contents).
	originalBibset scope: CZSet standardDefinitions 
]

{ #category : #'as yet unclassified' }
CZDocument >> listIndex [
	^ listIndex
]

{ #category : #'as yet unclassified' }
CZDocument >> orderedList [
	listIndex := 1.
	restartOrdered := true
]

{ #category : #'as yet unclassified' }
CZDocument >> originalBibset [
	^ originalBibset 
]

{ #category : #'as yet unclassified' }
CZDocument >> outputFile: aString [
	outputFile := aString
]

{ #category : #'as yet unclassified' }
CZDocument >> requestBibset [
	^ originalBibset copyTwoLevel
]

{ #category : #'as yet unclassified' }
CZDocument >> restartOrderedListAtEachScript: aBoolean [
	restartOrdered := aBoolean 
]

{ #category : #'as yet unclassified' }
CZDocument >> unorderedList [
	listIndex := 0
]

{ #category : #'as yet unclassified' }
CZDocument >> withoutHeaderAndFooter [
	withoutHeaderAndFooter := true
]
