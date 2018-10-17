"
I'm responsible for building document. I work on a bib set and once all the filtering is done. 
I have a title and sections and for example, HTML subclasses also point to a bib file. 
My sections are built out of queries over the bibset that I use. 
I define many queries over my working bibset. 
I use visitors such as CZBibTexGenerator (such as subclasses of CZFileFormatGenerator) to render my elements. 


Implementation notes.

- workingSet is a private field. The public API is to use bibset: to specify the bib set to work with

"
Class {
	#name : #CZDocBuilder,
	#superclass : #Object,
	#instVars : [
		'doc',
		'authorMatchingString',
		'originalBibSet',
		'workingBibSet',
		'localization',
		'noEmptySection',
		'shouldFilterNonPublic',
		'keysOfBlackListedEntries',
		'fieldOrder',
		'workingDirectory'
	],
	#category : 'Citezen-Reborn-DocumentBuilder'
}

{ #category : #queries }
CZDocBuilder >> PhDAndHabilitationQuery [
	^ CZQuery PhDAndHabilitation
]

{ #category : #building }
CZDocBuilder >> addElement: anElement [

	doc add: anElement
]

{ #category : #building }
CZDocBuilder >> addEntitledSection: aString withBibEntries: entries [
	self
		addSection:
			(CZSection new
				title: (CZString new setValue: aString);
				items:
					(CZSet new
						addAll: entries;
						yourself) yourself)
]

{ #category : #building }
CZDocBuilder >> addFooter [

	
]

{ #category : #building }
CZDocBuilder >> addHeader [
]

{ #category : #building }
CZDocBuilder >> addSection: aSection [

	doc add: aSection
]

{ #category : #building }
CZDocBuilder >> addSectionFromQuery: aQuery withTitle: aString [
	"Adding a section just add a section and a list of entries following it.
	By default, empty sections are not created and entries are sorted to get more recent on the top. Pay attention that the items of a section are a new group of items. "

	| entries |
	entries := workingBibSet select: aQuery.
	noEmptySection & entries size isZero
		ifTrue: [ ^ self ].
	entries sortByDateReverse.
	self addEntitledSection: aString withBibEntries: entries
]

{ #category : #building }
CZDocBuilder >> addTitle: aTitle [

	doc add: aTitle
]

{ #category : #'configuration public api' }
CZDocBuilder >> allowEmptySections [
	"It can be useful for document or bibfile debugging purposes to see the empty section of a document. By default it is turn off. "
	noEmptySection := false
]

{ #category : #'utility-queries' }
CZDocBuilder >> annotationWithType: aString [

	^  CZFieldQuery 
			named: #annote 
			checks: [ :value | aString match: value ]
]

{ #category : #accessing }
CZDocBuilder >> authorMatchingString [

	^ authorMatchingString
]

{ #category : #'public api' }
CZDocBuilder >> authorMatchingString: aString [

	authorMatchingString := aString
]

{ #category : #queries }
CZDocBuilder >> authorQuery [

	^ CZFieldQuery 
		named: #author 
		checks: [ :value | self authorMatchingString match: value ]
]

{ #category : #'public api' }
CZDocBuilder >> bibset: aBibSet [
	"We copy the original to be sure that we can always refer to it, even if we destructively change the working set."
	originalBibSet := aBibSet.
	aBibSet scope: CZSet standardDefinitions.
	workingBibSet := aBibSet copy
]

{ #category : #queries }
CZDocBuilder >> bookChapterQuery [
	^ CZQuery bookChapter
]

{ #category : #queries }
CZDocBuilder >> bookQuery [
	^ CZQuery book
]

{ #category : #queries }
CZDocBuilder >> bookletQuery [
	^ CZQuery booklet
]

{ #category : #'public api' }
CZDocBuilder >> build [
	"Build the current document: filter entities that not desirable and build the document body."
	
	self filter.
	self buildBody.
]

{ #category : #'public api' }
CZDocBuilder >> buildBody [
	"empty hook"
]

{ #category : #initialize }
CZDocBuilder >> defaultFieldOrder [

	^ #(#author #title #chapter #journal #booktitle #volume #pages #publisher #school #year #url #doi).

]

{ #category : #initialize }
CZDocBuilder >> defaultKeysOfBlackListedEntries [ 

	^ #()
]

{ #category : #queries }
CZDocBuilder >> deliverableQuery [
	^ CZQuery deliverable
]

{ #category : #'configuration public api' }
CZDocBuilder >> doNotAllowEmptySections [
	
	noEmptySection := true
]

{ #category : #'public api' }
CZDocBuilder >> document [
	"public API"
	^ doc
]

{ #category : #queries }
CZDocBuilder >> editorQuery [
	^ CZQuery editor
	
]

{ #category : #'configuration public api' }
CZDocBuilder >> english [

	localization english
]

{ #category : #'configuration public api' }
CZDocBuilder >> fieldOrder: aCol [
	"To specify the order and fields that should be displayed, for example, 
	#(#author #title #chapter #journal #booktitle #volume #pages #publisher #school #year #url #doi)."

	fieldOrder := aCol
]

{ #category : #'public api' }
CZDocBuilder >> fileNamed: aStringDotBib [
	"Parser and set the bib file."
	self onStream: (workingDirectory resolve: aStringDotBib) readStream
]

{ #category : #building }
CZDocBuilder >> filter [
	"Filter insubmission and other blacklisted entries"

	self shouldFilterNonPublic
		ifFalse: [ ^ self ].
	workingBibSet := workingBibSet reject: self inSubmissionQuery.
	workingBibSet := workingBibSet
		reject: [ :each | keysOfBlackListedEntries includes: each key ]
]

{ #category : #'configuration public api' }
CZDocBuilder >> french [

	localization french
]

{ #category : #queries }
CZDocBuilder >> inSubmissionQuery [
	^ CZQuery inSubmission
]

{ #category : #initialize }
CZDocBuilder >> initialize [
	super initialize.
	workingDirectory := FileSystem disk workingDirectory.

	doc := self rootDocumentClass new.
	self authorMatchingString: '*'.
	localization := self localizationClass new.
	self english.
	self fieldOrder: self defaultFieldOrder.
	self doNotAllowEmptySections.
	self setFilteringOn.
	self keysOfBlackListedEntries: self defaultKeysOfBlackListedEntries
]

{ #category : #queries }
CZDocBuilder >> internationalConferenceQuery [

	^ (self annotationWithType:  '*internationalconference*') AND: (self topConferenceQuery) NOT
]

{ #category : #queries }
CZDocBuilder >> internationalJournalQuery [

	^ (CZFieldQuery 
			named: #annote 
			checks: [ :value | '*internationaljournal*' match: value ])
]

{ #category : #queries }
CZDocBuilder >> internationalWorkshopQuery [
	^ CZQuery internationalWorkshop
]

{ #category : #queries }
CZDocBuilder >> invited [
	^ CZQuery invited
]

{ #category : #queries }
CZDocBuilder >> invitedPaperQuery [

	^ self annotationWithType:  '*invited*'
]

{ #category : #queries }
CZDocBuilder >> invitedQuery [

	^ self annotationWithType:  '*invited*'
]

{ #category : #queries }
CZDocBuilder >> journalQuery [
	^ CZQuery journal
]

{ #category : #accessing }
CZDocBuilder >> keysOfBlackListedEntries [
	"Returns the list of entities (identfied via their bib key) that should not be taken into account when building a document."
	
	^ keysOfBlackListedEntries
]

{ #category : #'public api' }
CZDocBuilder >> keysOfBlackListedEntries: aCol [ 

	keysOfBlackListedEntries := aCol
]

{ #category : #hooks }
CZDocBuilder >> localizationClass [
	^ CZLocalisation
]

{ #category : #queries }
CZDocBuilder >> nationalConferenceQuery [
	"pay attention not to put a star else internationalconference will be matched too"

	^ CZQuery nationalConference
]

{ #category : #queries }
CZDocBuilder >> nationalJournalQuery [
	^ CZQuery nationalJournal
]

{ #category : #queries }
CZDocBuilder >> nationalWorkshopQuery [
	^ CZQuery nationalWorkshop
]

{ #category : #'public api' }
CZDocBuilder >> onStream: aStream [

	| bibset2 |
	bibset2 := CZBibParser parse: aStream contents.
	bibset2 scope: CZSet standardDefinitions.
	self bibset: bibset2
	
]

{ #category : #queries }
CZDocBuilder >> periodicalQuery [
	^ CZQuery periodical
]

{ #category : #hooks }
CZDocBuilder >> rootDocumentClass [
	^ CZDoc
]

{ #category : #'configuration public api' }
CZDocBuilder >> setFilteringOff [

	shouldFilterNonPublic := false
]

{ #category : #'configuration public api' }
CZDocBuilder >> setFilteringOn [
	"to filter private entries and others insubmissions"
	
	shouldFilterNonPublic := true
]

{ #category : #language }
CZDocBuilder >> setLanguage: aSymbol [
	"right now only english and french are managed."
	| language |
	language := (#(english french) includes: aSymbol) 
		ifFalse: [ #english ]
		ifTrue: [ aSymbol ].
	self perform: aSymbol
]

{ #category : #testing }
CZDocBuilder >> shouldFilterNonPublic [

	^ shouldFilterNonPublic
]

{ #category : #queries }
CZDocBuilder >> teamEntryQuery [
	^ CZQuery teamEntry
]

{ #category : #queries }
CZDocBuilder >> technicalReportQuery [
	^ CZQuery techreport
]

{ #category : #queries }
CZDocBuilder >> toolDemoQuery [
	^ CZQuery toolDemo
]

{ #category : #queries }
CZDocBuilder >> topConferenceQuery [
	^ CZQuery topConference
]

{ #category : #queries }
CZDocBuilder >> vulgarisationQuery [
	^ CZQuery vulgarisation
]

{ #category : #accessing }
CZDocBuilder >> workingBibSet [ 
	
	^ workingBibSet
]

{ #category : #accessing }
CZDocBuilder >> workingDirectory: aWorkingDirectory [ 
	
	workingDirectory := aWorkingDirectory
]
