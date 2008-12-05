Class {
	#name : #CZBibList,
	#superclass : #PRStructure,
	#instVars : [
		'file',
		'urls',
		'entries',
		'filteringKeyword'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #testing }
CZBibList class >> canBeParentOf: aStructureClass [
	^ aStructureClass includesBehavior: CZBibEntry
]

{ #category : #'accessing-descriptions' }
CZBibList class >> descriptionContainer [
	^ (super descriptionContainer)
		addCondition: [:memento |
			[ memento cache
				at: self descriptionEntries
				put: (self entriesFromMemento: memento).
				true
			] on: SmaCCParserError do: [false] ]
		labelled: 'Files and Urls must be BibTex databases';
		yourself
]

{ #category : #'accessing-descriptions' }
CZBibList class >> descriptionEntries [
	^ MAFileDescription new
		selectorAccessor: #entries;
		componentClass: nil;
		yourself

]

{ #category : #'accessing-descriptions' }
CZBibList class >> descriptionFile [
	^ MAFileDescription new
		comment: 'The .bib file to render.';
		componentClass: MAServerFileChooserComponent;
		kind: MAReferenceFileModel;
		selectorAccessor: #file;
		label: 'BibTeX File';
		beEditable;
		yourself
]

{ #category : #'accessing-descriptions' }
CZBibList class >> descriptionFilteringKeyword [
	^ MAStringDescription new
		selectorAccessor: #filteringKeyword;
		label: 'Filtering keyword';
		priority: 1000;
		beEditable;
		yourself
]

{ #category : #'accessing-descriptions' }
CZBibList class >> descriptionUrls [
	^ MAMemoDescription new
		selectorAccessor: #urls;
		priority: 1000;
		label: 'Urls';
		beEditable;
		yourself
]

{ #category : #private }
CZBibList class >> entriesFromMemento: aMemento [
	| entries |
	entries := OrderedCollection new.
	(aMemento cache at: self descriptionFile ifAbsent: [nil]) ifNotNilDo: [:file | 
			(file directory fileExists: file filename) ifTrue: [ 
				entries add: (self parseEntriesFromString: file contents) ]].
	(aMemento cache at: self descriptionUrls ifAbsent: [nil]) ifNotNilDo: [:urls |
			(urls findTokens: String crlf) do: [:each | entries add:
				(self parseEntriesFromString: (HTTPSocket httpGet: each)
					contents) ] ].
	^ entries
]

{ #category : #testing }
CZBibList class >> isAbstract [
	^false
]

{ #category : #private }
CZBibList class >> parseEntriesFromFile: aFileModel [
	^ CZBibParser parse: aFileModel readStream
]

{ #category : #private }
CZBibList class >> parseEntriesFromString: aString [
	^ CZBibParser parse: aString asString
]

{ #category : #accessing }
CZBibList >> entries [
	^ entries ifNil: [self resetEntries]
]

{ #category : #accessing }
CZBibList >> entries: aCollection [
	| selectedEntries |
	
	self resetEntries.
	
	selectedEntries := aCollection.

	(self filteringKeyword notNil and: [self filteringKeyword notEmpty]) ifTrue: [
		selectedEntries := aCollection collect: [:eachSet |
			eachSet select: [:each |
				(each hasField: 'keywords') and: [
					((each at: 'keywords') value findTokens: (Array with: Character space with: Character cr with: Character lf)) includes: self filteringKeyword.
				].
			]
		].
	].
	selectedEntries do: [:each | self entries merge: each].
	self rebuildChildren
]

{ #category : #accessing }
CZBibList >> file [
	^file
]

{ #category : #accessing }
CZBibList >> file: aFileModel [
	file := aFileModel
]

{ #category : #accessing }
CZBibList >> filteringKeyword [
	^filteringKeyword
]

{ #category : #accessing }
CZBibList >> filteringKeyword: aString [
	filteringKeyword := aString
]

{ #category : #accessing }
CZBibList >> rebuildChildren [
	self removeDecoration: self childrenDecoration.
	entries do: [:each | | page pagetitle |
		page := self childrenDecoration at: each key ifAbsent: [
					self addChild: (CZBibEntry named: each key)].
		pagetitle := (each at: 'title') value.
		pagetitle := CZHtmlRenderer halt htmlOutOfLatexString: pagetitle.
		page title: pagetitle.
		(each hasField: 'keywords') ifTrue:[
			page tags: ((each at: 'keywords') value findTokens: Character space).
		].
		page entry: each.
	]

]

{ #category : #accessing }
CZBibList >> resetEntries [
	^ entries := CZSet new withStandardDefinitions
]

{ #category : #accessing }
CZBibList >> urls [

	^urls
]

{ #category : #accessing }
CZBibList >> urls: aCRSeparatedList [
	urls := aCRSeparatedList
]

{ #category : #accessing }
CZBibList >> viewComponentClass [
	^ CZBibListHtmlView
]
