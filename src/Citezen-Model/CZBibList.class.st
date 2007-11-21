Class {
	#name : #CZBibList,
	#superclass : #PRStructure,
	#instVars : [
		'file',
		'urls',
		'entries'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #'as yet unclassified' }
CZBibList class >> canBeParentOf: aStructureClass [
	^ aStructureClass includesBehavior: CZBibEntry
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
CZBibList class >> descriptionUrls [
	^ MAMemoDescription new
		selectorAccessor: #urls;
		priority: 1000;
		label: 'Urls';
		beEditable;
		yourself
]

{ #category : #'as yet unclassified' }
CZBibList class >> isAbstract [
	^false
]

{ #category : #accessing }
CZBibList >> addChildrenFromString: aString [
	
	|  page pagetitle |

	entries := (CZBibParser parseStream: aString readStream ascii) withStandardDefinitions.

	entries do: [:each |
		page := self childrenDecoration at: each key ifAbsent: [
					self addChild: (CZBibEntry named: each key)].
		pagetitle := (each at: 'title') value.
		pagetitle := CZBibEntryHtmlRenderer htmlOutOfLatexString: pagetitle.
		page title: pagetitle.
		(each hasField: 'keywords') ifTrue:[
			page tags: ((each at: 'keywords') value findTokens: Character space).
		].
		page entry: each.
	]

]

{ #category : #accessing }
CZBibList >> entries [

	^entries ifNil: [entries := CZSet new]
]

{ #category : #accessing }
CZBibList >> file [
	^file
]

{ #category : #accessing }
CZBibList >> file: aFileModel [
	file := aFileModel.
	file ifNotNil: [self addChildrenFromString: file].
]

{ #category : #accessing }
CZBibList >> urls [

	^urls
]

{ #category : #accessing }
CZBibList >> urls: aCRSeparatedList [

	urls := aCRSeparatedList.
	self urls ifNotNil: [
		(self urls findTokens: String crlf) do: [:eachUrl |
			[self addChildrenFromString: (HTTPSocket httpGet: eachUrl)]
				on: SmaCCParserError 
				do: [ :err | err resignalAs: (MAConditionError description: self class descriptionUrls signal: eachUrl) ].
		]
	].

]

{ #category : #accessing }
CZBibList >> viewComponentClass [
	^ CZBibListHtmlView
]
