"
I am a Pier Structure that points to a bibtex file. I am located at a fixed url.

I read the file and split it up into strings represented individual CZPierBibEntry bibtex entries. The entries are parsed lazily, only when they are actually needed.

I remember the timestamp of the last time the file was read. Every time I am accessed, I check the timestamp, and reload the file only if I have been invalidated.

I can be queried, yielding a CZPierBibList of CZPierBibEntry instances.
"
Class {
	#name : #CZPierBibFile,
	#superclass : #PRStructure,
	#instVars : [
		'file',
		'loadedFile',
		'timestamp',
		'bibList'
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
	^ bibList
]

{ #category : #accessing }
CZPierBibFile >> file [
	^ file
]

{ #category : #accessing }
CZPierBibFile >> file: aFileModel [
	file := aFileModel
]

{ #category : #initialization }
CZPierBibFile >> initialize [
	super initialize.
	timestamp := 0.
]

{ #category : #testing }
CZPierBibFile >> isValid [
	file = loadedFile
		ifTrue: [(file notNil
					and: [file modificationTime > timestamp])
				ifTrue: [self loadFile]]
		ifFalse: [self loadFile].
	^ loadedFile notNil
]

{ #category : #testing }
CZPierBibFile >> loadFile [
	"Postcondition: file = loadedFile or: [loadedFile isNil]"
	loadedFile := nil.
	bibList := nil.
	(file filePath endsWith: '.bib')
		ifTrue: [file exists
				ifTrue: [timestamp := file modificationTime.
					bibList := CZPierBibList from: file contents.
					loadedFile := file]]
]

{ #category : #querying }
CZPierBibFile >> query: aString [
	^ bibList query: aString
]

{ #category : #accessing }
CZPierBibFile >> viewComponentClass [
	^ CZPierBibFileView
]
