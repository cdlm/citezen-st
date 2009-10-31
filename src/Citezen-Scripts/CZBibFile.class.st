"
A CZBibFile is way to get a list of bibentries.

CPBibFile on the contrary get a list of entry but not parsed.
In the future we should probably refactor the two. 

Comment of CPBibFile
	""The key class is BibFile, which points to a local bib file (e.g., scg.bib). It keeps track of the timestamp and reloads the file whenever it changes. It splits the file into a BibList of BibEntry objects. Each BibEntry holds the text of a bibtext entry, and lazily parses it only if needed (i.e., for rendering). BibFileView generates the interface for ad hoc queries.""
"
Class {
	#name : #CZBibFile,
	#superclass : #Object,
	#instVars : [
		'bibFile',
		'bibList',
		'errorString',
		'file',
		'timestamp'
	],
	#category : #'Citezen-Scripts'
}

{ #category : #'instance creation' }
CZBibFile class >> fileName: aString [
	"self fileName:  'lse.bib'"
	^ self new file: aString
]

{ #category : #accessing }
CZBibFile >> bibList [
	self isExpired ifTrue: [ self loadBibList ].
	^ bibList
]

{ #category : #accessing }
CZBibFile >> errorString [
	^ errorString 
]

{ #category : #accessing }
CZBibFile >> file [
	<ignoreForCoverage>
	^ file
]

{ #category : #accessing }
CZBibFile >> file: aFileName [
	
	file := aFileName.
	self loadBibList.
]

{ #category : #'initialize-release' }
CZBibFile >> initialize [
	super initialize.
	timestamp := 0.
	errorString := 'The bibtex file has not been defined.'
]

{ #category : #'initialize-release' }
CZBibFile >> invariant [
	^ self file notNil and: [self isValid]
]

{ #category : #testing }
CZBibFile >> isExpired [
	^ self isValid and: [file modificationTime > timestamp]
]

{ #category : #testing }
CZBibFile >> isValid [
	^ bibList notNil
]

{ #category : #action }
CZBibFile >> loadBibList [
	bibList := nil.
	file := (FileDirectory default readOnlyFileNamed:  file).
	timestamp := self modificationTime.
	bibList := CZBibParser parse: file contents.
	
	"CPBibFile lazzy creation"
	"bibList := CPBibList from: file contents."
				
]

{ #category : #accessing }
CZBibFile >> modificationTime [
	"time the entry was last modified"
	^ (FileDirectory directoryEntryFor: self file name) modificationTime
]

{ #category : #action }
CZBibFile >> modificationTimePrintString [

	^ (DateAndTime fromSeconds: timestamp) printString
]
