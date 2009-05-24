"
I am a Pier Structure that points to a bibtex file. I am located at a fixed url.

I read the file and split it up into strings represented individual [CP]BibEntry bibtex entries. The entries are parsed lazily, only when they are actually needed.

I remember the timestamp of the last time the file was read. Every time I am accessed, I check the timestamp, and reload the file only if I have been invalidated.

I can be queried, yielding a QueryResult pointing to a BibList of BibEntry instances.
"
Class {
	#name : #CPBibFile,
	#superclass : #PRStructure,
	#instVars : [
		'file',
		'timestamp',
		'bibList',
		'maxResults',
		'errorString'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'accessing-description' }
CPBibFile class >> descriptionFile [
	<ignoreForCoverage>
	^ MAFileDescription new
		componentClass: MAServerFileChooserComponent;
		priority: 10;
		kind: MAReferenceFileModel;
		selectorAccessor: #file;
		label: 'BibTeX File';
		beEditable;
		yourself
]

{ #category : #'accessing-description' }
CPBibFile class >> descriptionMaxResults [
	<ignoreForCoverage>
	^ MANumberDescription new
		comment: 'The maximum number of results to return from a query';
		accessor: #maxResults;
		label: 'Max # results';
		priority: 100;
		default: CPQuerySpec defaultMaxResults;
		beInteger;
		bePositive;
		beEditable;
		yourself
]

{ #category : #testing }
CPBibFile class >> isAbstract [
	"Be recognized by Pier as a valid type of structure to be added to the wiki"
	^false
]

{ #category : #accessing }
CPBibFile class >> singleInstanceOrNil [
	<ignoreForCoverage>
	^ self allInstances ifNotEmptyDo: [: all | all size = 1 ifTrue: [all first]].
]

{ #category : #accessing }
CPBibFile >> bibList [
	self isExpired ifTrue: [ self loadBibList ].
	^ bibList
]

{ #category : #accessing }
CPBibFile >> errorString [
	^ errorString 
]

{ #category : #accessing }
CPBibFile >> file [
	<ignoreForCoverage>
	^ file
]

{ #category : #accessing }
CPBibFile >> file: aFileModel [
	file := aFileModel.
	self loadBibList.
]

{ #category : #initialization }
CPBibFile >> initialize [
	super initialize.
	timestamp := 0.
	errorString := 'The bibtex file has not been defined. Please edit this page and define it. '
]

{ #category : #testing }
CPBibFile >> invariant [
	^ self file notNil and: [self maxResults isInteger] and: [self isValid]
]

{ #category : #testing }
CPBibFile >> isExpired [
	^ self isValid and: [file modificationTime > timestamp]
]

{ #category : #testing }
CPBibFile >> isValid [
	^ bibList notNil
]

{ #category : #loading }
CPBibFile >> loadBibList [
	bibList := nil.
	errorString := ''.
	(file filePath endsWith: '.bib') 
		ifTrue: 
			[ file exists 
				ifTrue: 
					[ timestamp := file modificationTime.
					bibList := CPBibList from: file contents ]
				ifFalse: [ errorString := file filePath , ' does not exist. ' ] ]
		ifFalse: 
			[ errorString := file filePath , ' does not appear to be a bibtex file. ' ]
]

{ #category : #accessing }
CPBibFile >> maxResults [
	<ignoreForCoverage>
	^ maxResults
]

{ #category : #accessing }
CPBibFile >> maxResults: anObject [
	<ignoreForCoverage>
	maxResults := anObject
]

{ #category : #querying }
CPBibFile >> modificationTimePrintString [
	<ignoreForCoverage>
	^ (DateAndTime fromSeconds: timestamp) printString
]

{ #category : #querying }
CPBibFile >> query: queryString [ 
	^ CPQuerySpec default
			queryString: queryString;
			bibFile: self;
			queryResult
]

{ #category : #querying }
CPBibFile >> queryCaseSensitive: queryString [ 
	^ CPQuerySpec default
			queryString: queryString;
			caseSensitive: true;
			bibFile: self;
			queryResult
]

{ #category : #accessing }
CPBibFile >> timestamp [
	^ timestamp
]

{ #category : #accessing }
CPBibFile >> viewComponentClass [
	<ignoreForCoverage>
	^ CPBibFileView
]
