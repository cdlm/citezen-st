"
I am a Pier Structure that points to a bibtex file. I am located at a fixed url.

I read the file and split it up into strings represented individual [CZPier]BibEntry bibtex entries. The entries are parsed lazily, only when they are actually needed.

I remember the timestamp of the last time the file was read. Every time I am accessed, I check the timestamp, and reload the file only if I have been invalidated.

I can be queried, yielding a BibList of BibEntry instances.
"
Class {
	#name : #CZPierBibFile,
	#superclass : #PRStructure,
	#instVars : [
		'file',
		'timestamp',
		'bibList',
		'error'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #'accessing-description' }
CZPierBibFile class >> descriptionFile [
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
CZPierBibFile class >> isAbstract [
	"Be recognized by Pier as a valid type of structure to be added to the wiki"
	^false
]

{ #category : #accessing }
CZPierBibFile >> bibList [
	self isExpired ifTrue: [ self loadBibList ].
	^ bibList
]

{ #category : #accessing }
CZPierBibFile >> error [
	^ error
]

{ #category : #accessing }
CZPierBibFile >> file [
	^ file
]

{ #category : #accessing }
CZPierBibFile >> file: aFileModel [
	file := aFileModel.
	self loadBibList.
]

{ #category : #querying }
CZPierBibFile >> filterRegex: aRegex [
	^ bibList filterRegex: aRegex
]

{ #category : #initialization }
CZPierBibFile >> initialize [
	super initialize.
	timestamp := 0.
	error := 'The bibtex file has not been defined. Please edit this page and define it. '
]

{ #category : #accessing }
CZPierBibFile >> isExpired [
	^ self isValid and: [file modificationTime > timestamp]
]

{ #category : #testing }
CZPierBibFile >> isValid [
	^ bibList notNil

]

{ #category : #testing }
CZPierBibFile >> loadBibList [
	bibList := nil.
	(file filePath endsWith: '.bib')
		ifTrue: [file exists
				ifTrue: [timestamp := file modificationTime.
					bibList := CZPierBibList from: file contents]
				ifFalse: [error := file filePath , ' does not exist. ']]
		ifFalse: [error := file filePath , ' does not appear to be a bibtex file. ']
]

{ #category : #querying }
CZPierBibFile >> modificationTimePrintString [
	^ (DateAndTime fromSeconds: timestamp) printString
]

{ #category : #querying }
CZPierBibFile >> query: aRegexString [
	^ self filterRegex: aRegexString asRegex

]

{ #category : #accessing }
CZPierBibFile >> timestamp [
	^ timestamp
]

{ #category : #accessing }
CZPierBibFile >> viewComponentClass [
	^ CZPierBibFileView
]
