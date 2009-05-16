"
I am a Pier Structure that points to a bibtex file. I am located at a fixed url.

I read the file and split it up into strings represented individual [CP]BibEntry bibtex entries. The entries are parsed lazily, only when they are actually needed.

I remember the timestamp of the last time the file was read. Every time I am accessed, I check the timestamp, and reload the file only if I have been invalidated.

I can be queried, yielding a BibList of BibEntry instances.
"
Class {
	#name : #CPBibFilePage,
	#superclass : #PRStructure,
	#instVars : [
		'file',
		'timestamp',
		'bibList',
		'error'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'accessing-description' }
CPBibFilePage class >> descriptionFile [
	<ignoreForCoverage>
	^ MAFileDescription new
		comment: 'Local path to .bib file to render.';
		componentClass: MAServerFileChooserComponent;
		kind: MAReferenceFileModel;
		selectorAccessor: #file;
		label: 'BibTeX File';
		beEditable;
		yourself
]

{ #category : #testing }
CPBibFilePage class >> isAbstract [
	"Be recognized by Pier as a valid type of structure to be added to the wiki"
	^false
]

{ #category : #accessing }
CPBibFilePage >> bibList [
	self isExpired ifTrue: [ self loadBibList ].
	^ bibList
]

{ #category : #accessing }
CPBibFilePage >> error [
	^ error
]

{ #category : #accessing }
CPBibFilePage >> file [
	<ignoreForCoverage>
	^ file
]

{ #category : #accessing }
CPBibFilePage >> file: aFileModel [
	file := aFileModel.
	self loadBibList.
]

{ #category : #initialization }
CPBibFilePage >> initialize [
	super initialize.
	timestamp := 0.
	error := 'The bibtex file has not been defined. Please edit this page and define it. '
]

{ #category : #accessing }
CPBibFilePage >> isExpired [
	^ self isValid and: [file modificationTime > timestamp]
]

{ #category : #testing }
CPBibFilePage >> isValid [
	^ bibList notNil

]

{ #category : #testing }
CPBibFilePage >> loadBibList [
	bibList := nil.
	error := ''.
	(file filePath endsWith: '.bib') 
		ifTrue: 
			[ file exists 
				ifTrue: 
					[ timestamp := file modificationTime.
					bibList := CPBibList from: file contents ]
				ifFalse: [ error := file filePath , ' does not exist. ' ] ]
		ifFalse: [ error := file filePath , ' does not appear to be a bibtex file. ' ]
]

{ #category : #querying }
CPBibFilePage >> modificationTimePrintString [
	<ignoreForCoverage>
	^ (DateAndTime fromSeconds: timestamp) printString
]

{ #category : #accessing }
CPBibFilePage >> timestamp [
	^ timestamp
]

{ #category : #accessing }
CPBibFilePage >> viewComponentClass [
	<ignoreForCoverage>
	^ CPBibFileView
]
