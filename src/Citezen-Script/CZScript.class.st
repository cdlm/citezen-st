Class {
	#name : #CZScript,
	#superclass : #Object,
	#instVars : [
		'bibset',
		'outputer',
		'outputFile',
		'blackList',
		'fieldsToRemove',
		'sortCollection',
		'displayOrder',
		'query'
	],
	#classInstVars : [
		'exportTypeMatching',
		'sortMatching'
	],
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZScript class >> bibExporterEncoding [
	^ #bib
]

{ #category : #'as yet unclassified' }
CZScript class >> defaultExportType [ 
	^ self bibExporterEncoding 
]

{ #category : #'as yet unclassified' }
CZScript class >> defaultOutputer [ 
	^ self matchType: self defaultExportType 
]

{ #category : #'as yet unclassified' }
CZScript class >> fieldSortBlock: aSymbol [ 
	^ ([ :value | self sortByField: value fieldToSort: aSymbol ])
]

{ #category : #'as yet unclassified' }
CZScript class >> initializeExportTypeMatching [
	exportTypeMatching := Dictionary new.
	exportTypeMatching 
		add: (self bibExporterEncoding) -> CZRawOutputer 
]

{ #category : #'as yet unclassified' }
CZScript class >> initializeSortMatching [
	sortMatching := Dictionary new.
	sortMatching 
		add: (self typeSymbol) -> [ :value | self sortByType: value ];
		add: (self keySymbol) -> [ :value | self sortByKey: value]
]

{ #category : #'as yet unclassified' }
CZScript class >> keySymbol [
	^ '_key' asSymbol
]

{ #category : #'as yet unclassified' }
CZScript class >> matchSort: aSymbol [
	sortMatching ifNil: [ self initializeSortMatching ].
	^ sortMatching at: aSymbol ifAbsent: [ self fieldSortBlock: aSymbol ]
]

{ #category : #'as yet unclassified' }
CZScript class >> matchType: aString [
	exportTypeMatching ifNil: [ self initializeExportTypeMatching ].
	^ exportTypeMatching at: aString ifAbsent: self defaultExportType
]

{ #category : #'as yet unclassified' }
CZScript class >> sortByField: aCollection fieldToSort: aSymbol [
	^ aCollection groupBy: [ :each | each at: aSymbol ] having: [ :each | true ]
]

{ #category : #'as yet unclassified' }
CZScript class >> sortByKey: aCollection [
	^ aCollection groupBy: [ :each | each key] having: [ :each | true ]
]

{ #category : #'as yet unclassified' }
CZScript class >> sortByType: aCollection [
	^ aCollection groupBy: [ :each | each type] having: [ :each | true ]
]

{ #category : #'as yet unclassified' }
CZScript class >> typeSymbol [
	^ '_type' asSymbol
]

{ #category : #'as yet unclassified' }
CZScript >> blackList: aList [
	blackList := aList 
]

{ #category : #'as yet unclassified' }
CZScript >> defaultOutputPath [
	^ 'default.bib'
]

{ #category : #'as yet unclassified' }
CZScript >> displayOrder: aList [
	| collection |
	sortCollection addFirst: self class typeSymbol.
	collection := aList asOrderedCollection.
	(collection includes: #*) ifFalse: [ collection add: #* ].
	displayOrder := collection
		
	
]

{ #category : #'as yet unclassified' }
CZScript >> displayWithDisplayOrder: aDictionary in: aCollection [
	| keys printedKeys currentKey index|
	
	keys := aDictionary keys.
	currentKey := displayOrder at: (index := 1).
	
	"Before the * wildcard"
	[currentKey ~= '*'] whileTrue: 
		[ (keys includes: currentKey) ifTrue:
			[ aCollection addAll: (aDictionary at: currentKey).
			  keys remove: currentKey ].
		 	currentKey := displayOrder at: (index := index + 1) ].
	
	"The * wildcard"
	printedKeys := OrderedCollection new.	
	keys do: [ :each | (displayOrder includes: each) 
		ifFalse: [ 
			aCollection addAll: (aDictionary at: each).
			printedKeys add: each ]].
	keys := (keys select: [ :each | (printedKeys includes: each) not]).
	
	"After the * wildcard"
	index := index + 1.
	[index > displayOrder size] whileFalse: [
		currentKey := displayOrder at: index.
		(keys includes: currentKey) ifTrue: 
			[ aCollection addAll: (aDictionary at: currentKey)].
		index := index + 1
	]
	
]

{ #category : #'as yet unclassified' }
CZScript >> exportAsBib [
	self exportType: self class bibExporterEncoding
]

{ #category : #'as yet unclassified' }
CZScript >> exportType: aString [
	outputer := (self class matchType: aString) new
]

{ #category : #'as yet unclassified' }
CZScript >> fieldsToRemove: aList [
	fieldsToRemove := aList 
]

{ #category : #'as yet unclassified' }
CZScript >> filter [
	(query isNil not) ifTrue: [
		bibset entries: (bibset entries select: [ :each | query value: each])]
]

{ #category : #'as yet unclassified' }
CZScript >> generate [
	self 
		remove;
		filter;
		sort.
	
	(outputer ifNil: [ self class defaultOutputer ])
		setOutputFile: (outputFile ifNil: [ self defaultOutputPath ]);
		getOutputFor: bibset
]

{ #category : #'as yet unclassified' }
CZScript >> initialize [
	bibset := nil.
	outputer := nil.
	outputFile := self defaultOutputPath.
	blackList := #().
	sortCollection := OrderedCollection new.
	displayOrder := nil.
	query := nil.

]

{ #category : #'as yet unclassified' }
CZScript >> inputFile: path [
	bibset := CZBibParser parse: ((FileStream readOnlyFileNamed: path) contents)
]

{ #category : #'as yet unclassified' }
CZScript >> outputFile: path [
	outputFile := path
]

{ #category : #'as yet unclassified' }
CZScript >> query: aQuery [
	query := aQuery 
]

{ #category : #'as yet unclassified' }
CZScript >> remove [ 
	| newEntries |
	newEntries := OrderedCollection new.
	
	bibset entries do: [ :each | 
		(blackList includes: each key) 
			ifFalse: [ newEntries add: (each removeFields: fieldsToRemove) ]].
		
	bibset entries: newEntries 
]

{ #category : #'as yet unclassified' }
CZScript >> sort [
	(sortCollection isEmpty)
		ifFalse: [
			bibset entries: (self sortStartingAt: 1 value: bibset entries)].
		
]

{ #category : #'as yet unclassified' }
CZScript >> sortByField: aSymbol [
	(sortCollection includes: self class typeSymbol) not ifTrue: [
		sortCollection add: aSymbol]
]

{ #category : #'as yet unclassified' }
CZScript >> sortByKey [
	(sortCollection includes: self class typeSymbol) not ifTrue: [
		sortCollection add: self class keySymbol]
]

{ #category : #'as yet unclassified' }
CZScript >> sortByType [
	(sortCollection includes: self class typeSymbol) not ifTrue: [
		sortCollection add: self class typeSymbol]
]

{ #category : #'as yet unclassified' }
CZScript >> sortStartingAt: anIndex value: value [
	| dictionary collection keys |
	dictionary := (self class matchSort: (sortCollection at: anIndex)) value: value.
	
	(anIndex < sortCollection size)
		ifTrue: [
			dictionary keys
			  do: [ :key | 
				dictionary  
					at: (key)
					put: (self sortStartingAt: (anIndex+1) value: (dictionary at: (key))) ]].
			
	collection := OrderedCollection new.
	keys := dictionary keysSortedSafely.
	
	(anIndex = 1 & (displayOrder isNil not))
		ifTrue: [ self displayWithDisplayOrder: dictionary in: collection ]
		ifFalse: [ keys do: 
			[ :each | collection addAll: (dictionary at: each) ]].
	
	^ collection asOrderedCollection

]
