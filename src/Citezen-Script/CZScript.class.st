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
	^ (aCollection 
			groupBy: [ :each | (each at: aSymbol) rawValue ] 
			having: [ :each | ((each at:1) at: aSymbol) class ~= CZUndefinedField ]
		) associations 
]

{ #category : #'as yet unclassified' }
CZScript class >> sortByKey: aCollection [
	^ (aCollection 
			groupBy: [ :each | each key] 
			having: [ :each | true ]
		) associations 
]

{ #category : #'as yet unclassified' }
CZScript class >> sortByType: aCollection [
	^ (aCollection 
			groupBy: [ :each | each type] 
			having: [ :each | true ]
		) associations
]

{ #category : #'as yet unclassified' }
CZScript class >> typeSymbol [
	^ '_type' asSymbol
]

{ #category : #private }
CZScript >> addSort: aSymbol reversed: aBoolean [
	(aSymbol isNil not) ifTrue: [
		(sortCollection includes: aSymbol) not ifTrue: [
			sortCollection add: (aSymbol -> aBoolean) ] ]
]

{ #category : #private }
CZScript >> bibsetInput: aCZSet [
	bibset := aCZSet.
	aCZSet scope: CZSet standardDefinitions 
]

{ #category : #interface }
CZScript >> blackList: aList [
	blackList := (aList ifNil: [#()])
]

{ #category : #private }
CZScript >> defaultOutputPath [
	^ 'default.bib'
]

{ #category : #interface }
CZScript >> defaultSeparator: aString [

	(aString isNil not)
		ifTrue: [
			(separatorsCollection isNil not) ifTrue: [
				separatorsCollection do: [ :each | 
					each at: 1 put: aString. each at: (each size) put: aString]].
	
			defaultSeparator := aString. ]
		ifFalse: [ defaultSeparator := '']
]

{ #category : #interface }
CZScript >> displayOrder: aList [
	| collection |
	
	(aList isNil not) 
		ifTrue: [
			sortCollection addFirst: (self class typeSymbol -> false).
			collection := aList asOrderedCollection.
			displayOrder := collection ]
		ifFalse: [ displayOrder := #() ]
		
		
	
]

{ #category : #interface }
CZScript >> displayPattern: aCZDisplayPattern [
	displayPattern := (aCZDisplayPattern ifNil: [CZDisplayPattern new field: #*])
]

{ #category : #private }
CZScript >> displayWithDisplayOrder: anArray in: aCollection [
	| dictKeyIndex keys printedKeys currentKey index aBoolean |
	
	dictKeyIndex := Dictionary new.
	1 to: anArray size do: [ :cpt | dictKeyIndex at: (anArray at: cpt) key put: cpt ].
	keys := dictKeyIndex keys.
	
	currentKey := displayOrder at: (index := 1).
	aBoolean := displayOrder includes: #*.
	
	aBoolean
		ifFalse: [ keys do: [ :each | aCollection addAll: (anArray at: (dictKeyIndex at: each)) value ] ]
		ifTrue: [ 
			"Before the * wildcard"
			[ currentKey ~= '*' ]
				whileTrue: [ 
					(keys includes: currentKey)
						ifTrue: [ 
							aCollection addAll: (anArray at: (dictKeyIndex at: currentKey)) value.
							keys remove: currentKey ].
					currentKey := displayOrder at: (index := index + 1) ].	
			
			"The * wildcard"
			printedKeys := OrderedCollection new.
			keys
				do: [ :each | 
					(displayOrder includes: each)
						ifFalse: [ 
							aCollection addAll: (anArray at: (dictKeyIndex at: each)) value.
							printedKeys add: each ] ].
			keys := keys select: [ :each | (printedKeys includes: each) not ].	
				
			"After the * wildcard"
			index := index + 1.
			[ index > displayOrder size ]
				whileFalse: [ 
					currentKey := displayOrder at: index.
					(keys includes: currentKey)
						ifTrue: [ aCollection addAll: (anArray at: (dictKeyIndex at: currentKey)) value ].
					index := index + 1 ] ]
]

{ #category : #interface }
CZScript >> exportAsBib [
	self exportType: self class bibExporterEncoding
]

{ #category : #interface }
CZScript >> exportAsHtml [
	self exportType: self class htmlExporterEncoding
]

{ #category : #private }
CZScript >> exportType: aString [
	outputer := (self class matchType: aString) new
]

{ #category : #interface }
CZScript >> fieldsToRemove: aList [
	fieldsToRemove := (aList ifNil: [ #() ])
]

{ #category : #private }
CZScript >> filter [
	(query isNil not) ifTrue: [
		bibset entries: (bibset entries select: [ :each | query value: each])]
]

{ #category : #interface }
CZScript >> generate [
	self 
		removeEntries;
		filter;
		sort;
		removeFields.
	
	^ (outputer ifNil: [ (self class defaultOutputer) new])
		separators: separatorsCollection;
		setOutputFile: outputFile;
		getOutputFor: bibset
]

{ #category : #initialization }
CZScript >> initialize [
	super initialize.
	
	bibset := nil.
	outputer := nil.
	blackList := #().
	fieldsToRemove := #().
	sortCollection := OrderedCollection new.
	displayOrder := #().
	displayPattern := CZDisplayPattern new field: #*.
	query := nil.
	defaultSeparator := ' '.

]

{ #category : #interface }
CZScript >> inputFile: path [
	bibset := CZBibParser parse: ((FileStream readOnlyFileNamed: path) contents).
	bibset scope: CZSet standardDefinitions 
]

{ #category : #interface }
CZScript >> outputFile: path [
	outputFile := path
]

{ #category : #interface }
CZScript >> query: aQuery [
	query := aQuery 
]

{ #category : #private }
CZScript >> removeEntries [ 
	"This method removes all the entries which match at least one of these two cases :
		- To be in the blackListBlock 
		- To have a type whiwh is not include in the displayOrder"

	| trueBlock blackListBlock displayOrderBlock condition |

	trueBlock := [ :entry | true ].
	blackListBlock := 
		((blackList isEmptyOrNil) 
			ifTrue: [ trueBlock ]	
			ifFalse: [[ :entry | (blackList includes: entry key) not ]]).
	displayOrderBlock := 
		(((displayOrder isEmptyOrNil) | (displayOrder includes: #*)) 
			ifTrue: [ trueBlock ] 
			ifFalse: [[ :entry | displayOrder includes: entry type ]]).
	
	condition := [ :entry | (blackListBlock value: entry) & (displayOrderBlock value: entry) ].
	
	bibset entries: ( 
		bibset entries select: [ :each | 
			condition value: each ]).
		

]

{ #category : #private }
CZScript >> removeFields [
	"Remove all fields listed in fieldsToRemove from all the entries"
	
	| newEntries |
	newEntries := OrderedCollection new.
	
	bibset entries do: [ :each | each removeFields: fieldsToRemove ]
]

{ #category : #interface }
CZScript >> reversedSortByField: aSymbol [
	self addSort: aSymbol reversed: true
]

{ #category : #interface }
CZScript >> reversedSortByKey [
	self addSort: (self class keySymbol) reversed: true
]

{ #category : #interface }
CZScript >> reversedSortByType [
	self addSort: (self class typeSymbol) reversed: true
]

{ #category : #private }
CZScript >> sort [
	"Big method which do this :
		- First, if there is at least on element in the sortCollection, the entries are sorted
		- Then, the separatorsCollection is created and the fields are sorted in all the entries. A few details :
			-- First we search the * wildcard in the displayPattern
			-- Then the separators are divided in two collections : before and after the wildcard ; the 'after' collection is empty if there is no wildcard
			-- The last step is to iterate on the entries, sort them, then create the collections of separators for these entries, and fill them"

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
	
	(hasWildcard) 
		ifTrue: [ 
			(fieldsBeforeWildcard + 2) to: (displayPattern separators size) do: [ :each | afterWildcard add: (displayPattern separators at: each) ]. 
	
			bibset entries do: [ :each | 
				fieldsInWilcard := each sortFields: displayPattern fields.
				tempSeparatorsCollection := OrderedCollection new.
				tempSeparatorsCollection addAll: beforeWildcard.
				(fieldsInWilcard - 1)timesRepeat: [ tempSeparatorsCollection add: defaultSeparator ].
				tempSeparatorsCollection addAll: afterWildcard .
				separatorsCollection add: tempSeparatorsCollection]]
		ifFalse: [
			bibset entries do: [ :each | 
				fieldsInWilcard := each sortFields: displayPattern fields.
				separatorsCollection add: (OrderedCollection new addAll: beforeWildcard; yourself)]]
]

{ #category : #interface }
CZScript >> sortByField: aSymbol [
	self addSort: aSymbol reversed: false
]

{ #category : #interface }
CZScript >> sortByKey [
	self addSort: (self class keySymbol) reversed: false
]

{ #category : #interface }
CZScript >> sortByType [
	self addSort: (self class typeSymbol) reversed: false
]

{ #category : #private }
CZScript >> sortStartingAt: anIndex value: value [
	"Recursive method which do this :
		- First, we look for a sort block and compute it with value
		- Then 
			-- The collection returned by the block is sorted, can be reverted
			-- If there is another sort option in sortCollection, then recursive call
		- If anIndex = 1 and if there is a displayOrder, call displayWithDisplayOrder:in:"

	| sortAssociation anArray sortedValues |

	sortAssociation := sortCollection at: anIndex. 
	anArray := (self class matchSort: sortAssociation key) value: value.
	
	anArray sort.
	(sortAssociation value) ifTrue: [
		anArray := anArray reversed ].
	
	(anIndex < sortCollection size)
		ifTrue: [
			anArray do: [ :each |  
				each value: (self sortStartingAt: (anIndex+1) value: (each value)) ] ].
			
	sortedValues := OrderedCollection new.
	
	(anIndex = 1 & (displayOrder isEmptyOrNil not))
		ifTrue: [ self displayWithDisplayOrder: anArray in: sortedValues ]
		ifFalse: [ anArray do: 
			[ :each | sortedValues addAll: (each value) ]].
	
	^ sortedValues 

]
