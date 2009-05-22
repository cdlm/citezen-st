Class {
	#name : #CPWhatsNew,
	#superclass : #PRWidget,
	#instVars : [
		'timestamp',
		'modificationTime',
		'queryResult'
	],
	#category : #'Citezen-Pier'
}

{ #category : #constants }
CPWhatsNew class >> archiveDir [
	^ '/home/scg/scg.unibe.ch/web/archive'
]

{ #category : #accessing }
CPWhatsNew class >> descriptionBibFile [
	^ PRStructureDescription new
		addCondition: (MACondition selector: #isKindOf: argument: CPBibFile)
			labelled: 'Select an existing Bib File';
		accessor: #bibFile;
		label: 'Bib File';
		priority: 10;
		beEditable;
		beRequired;
		yourself
]

{ #category : #constants }
CPWhatsNew class >> evolvingObjects [
	"There shoould be at least 4 newer pdfs than this one"
	^ '/home/scg/scg.unibe.ch/web/archive/papers/Deza08bEvolvingObjects.pdf'
]

{ #category : #constants }
CPWhatsNew class >> glamour [
	"The last pdf added to the old feed"
	^ '/home/scg/scg.unibe.ch/web/archive/masters/Bung09a.pdf'
]

{ #category : #accessing }
CPWhatsNew class >> groupLabel [
	^ 'Pier Bibliography'
]

{ #category : #accessing }
CPWhatsNew class >> isAbstract [
	^ false
]

{ #category : #accessing }
CPWhatsNew class >> label [
	^ 'What''s new blog'
]

{ #category : #accessing }
CPWhatsNew >> bibFile [
	^ self read: #descriptionBibFile
]

{ #category : #seaside }
CPWhatsNew >> children [
	^ Array with: queryResult
]

{ #category : #initialization }
CPWhatsNew >> initialize [
	super initialize.
	self initializeTimestamp.
]

{ #category : #initialization }
CPWhatsNew >> initializeTimestamp [
	"for testing"
	timestamp := (Rio new: self class evolvingObjects) modificationTime.
	"timestamp := (Rio new: self class glamour) modificationTime."
]

{ #category : #seaside }
CPWhatsNew >> renderContentOn: html [ 
	html form: 
		[ html submitButton
			text: 'update';
			callback: [ queryResult := self whatsNew ].
		html submitButton
			text: 'reset timeStamp';
			callback: [ self initializeTimestamp. queryResult := nil ] ].
	queryResult ifNotNil: [ html render: queryResult ]
]

{ #category : #initialization }
CPWhatsNew >> updateTimestamp [
	timestamp := TimeStamp now.
]

{ #category : #evaluation }
CPWhatsNew >> whatsNew [
	| lastTimestamp pdfs newFilenames entries |
	lastTimestamp := timestamp.
	self updateTimestamp.
	pdfs := (Rio new: self class archiveDir) beRecursive select: 
		[ :pdf |  pdf isFile 
			and: [ pdf fileName endsWith: '.pdf' ]
			and: [ pdf modificationTime > lastTimestamp ] ].
	newFilenames := pdfs collect: [ :pdf | pdf fileName ].
	entries := self bibFile bibList entries select: 
		[ :entry | 
		newFilenames anySatisfy: [ :fileName | entry containsKeyword: fileName ] ].
	^ CPQueryResult new
		querySpec: (CPQuerySpec default bibFile: self bibFile);
		bibList: (CPBibList entries: entries)
]
