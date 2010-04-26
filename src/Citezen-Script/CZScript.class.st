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
		'query',
		'displayPattern',
		'separatorsCollection',
		'defaultSeparator'
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
CZScript class >> htmlExporterEncoding [
	^ #html
]

{ #category : #'as yet unclassified' }
CZScript class >> initializeExportTypeMatching [
	exportTypeMatching := Dictionary new.
	exportTypeMatching 
		add: (self bibExporterEncoding) -> CZRawOutputer;
		add: (self htmlExporterEncoding) -> CZHtmlOutputer 
		
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
CZScript >> defaultSeparator: aString [
	self halt. 
	(separatorsCollection isNil not) ifTrue: [
		separatorsCollection do: [ :each | 
			each at: 1 put: aString. each at: (each size) put: aString]].
	
	defaultSeparator := aString.

]

{ #category : #'as yet unclassified' }
CZScript >> displayOrder: aList [
	| collection |
	sortCollection addFirst: self class typeSymbol.
	collection := aList asOrderedCollection.
"	(collection includes: #*) ifFalse: [ collection add: #* ]."
	displayOrder := collection
		
	
]

{ #category : #'as yet unclassified' }
CZScript >> displayPattern: aCZDisplayPattern [
"	(aCZDisplayPattern fields includes: #*) ifFalse: [ aCZDisplayPattern field: #* ]."
	displayPattern := aCZDisplayPattern 
]

{ #category : #'as yet unclassified' }
CZScript >> displayWithDisplayOrder: aDictionary in: aCollection [
	| keys printedKeys currentKey index aBoolean |
	keys := aDictionary keys.
	currentKey := displayOrder at: (index := 1).
	aBoolean := displayOrder includes: #*. 
	
	aBoolean
		ifFalse: [ 
			aDictionary keys
				do: [ :each | 
					(displayOrder includes: each)
						ifTrue: [ aCollection addAll: (aDictionary at: each) ] ] ]
		ifTrue: [ 
			"Before the * wildcard"
			[ currentKey ~= '*' ]
				whileTrue: [ 
					(keys includes: currentKey)
						ifTrue: [ 
							aCollection addAll: (aDictionary at: currentKey).
							keys remove: currentKey ].
					currentKey := displayOrder at: (index := index + 1) ].	"The * wildcard"
			printedKeys := OrderedCollection new.
			keys
				do: [ :each | 
					(displayOrder includes: each)
						ifFalse: [ 
							aCollection addAll: (aDictionary at: each).
							printedKeys add: each ] ].
			keys := keys select: [ :each | (printedKeys includes: each) not ].	"After the * wildcard"
			index := index + 1.
			[ index > displayOrder size ]
				whileFalse: [ 
					currentKey := displayOrder at: index.
					(keys includes: currentKey)
						ifTrue: [ aCollection addAll: (aDictionary at: currentKey) ].
					index := index + 1 ] ]
]

{ #category : #'as yet unclassified' }
CZScript >> exportAsBib [
	self exportType: self class bibExporterEncoding
]

{ #category : #'as yet unclassified' }
CZScript >> exportAsHtml [
	self exportType: self class htmlExporterEncoding
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
	
	(outputer ifNil: [ (self class defaultOutputer) new])
		separators: separatorsCollection;
		setOutputFile: (outputFile ifNil: [ self defaultOutputPath ]);
		getOutputFor: bibset
]

{ #category : #'as yet unclassified' }
CZScript >> initialize [
	super initialize.
	
	bibset := nil.
	outputer := nil.
	outputFile := self defaultOutputPath.
	blackList := #().
	fieldsToRemove := #().
	sortCollection := OrderedCollection new.
	displayOrder := nil.
	displayPattern := nil.
	query := nil.
	defaultSeparator := ' '.

]

{ #category : #'as yet unclassified' }
CZScript >> inputFile: path [
	bibset := CZBibParser parse: ((FileStream readOnlyFileNamed: path) contents).
	bibset scope: CZSet standardDefinitions 
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
	| fieldsBeforeWildcard beforeWildcard afterWildcard fieldsInWilcard tempSeparatorsCollection hasWildcard|
	
	"Sort entries by type"
	(sortCollection isEmpty)
		ifFalse: [
			bibset entries: (self sortStartingAt: 1 value: bibset entries)].
	
	"Sort fields and create the separators collection"
	separatorsCollection := OrderedCollection new.	
	fieldsBeforeWildcard := 0.
	hasWildcard := true.
	displayPattern fields detect: [ :each | (each = #*)
		ifFalse: [ fieldsBeforeWildcard := fieldsBeforeWildcard + 1. false ]
		ifTrue: [ true ]] ifNone: [ hasWildcard  := false ].
		
	beforeWildcard := OrderedCollection new.
	afterWildcard := OrderedCollection new.
	1 to: (fieldsBeforeWildcard + 1) do: [ :each | beforeWildcard add: (displayPattern separators at: each) ].
	
	(hasWildcard) ifTrue:[ 
		(fieldsBeforeWildcard + 2) to: (displayPattern separators size) do: [ :each | afterWildcard add: (displayPattern separators at: each) ]]. 
	
	(displayPattern isNil)
		ifFalse: [
			bibset entries do: [ :each | 
				fieldsInWilcard := each sortFields: displayPattern fields.
				tempSeparatorsCollection := OrderedCollection new.
				tempSeparatorsCollection addAll: beforeWildcard.
				(hasWildcard) ifTrue: [
					(fieldsInWilcard - 1)timesRepeat: [ tempSeparatorsCollection add: defaultSeparator ].
					tempSeparatorsCollection addAll: afterWildcard ].
				separatorsCollection add: tempSeparatorsCollection]].
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
