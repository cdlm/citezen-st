"
A CZScript represents a script, which is a part of a CZDocument. In a script, you can filter the entries, sort them, choose how to display them (if the export format allows it).
So you should create a CZScript, you can give it a CZQuery (filter the entries), a CZDisplayPattern (choose the fields and the separators bewteen these field for each entry), ...
Then, you should add this script with CZDocument>>addElement: in a CZDocument.

-----

Here is an example of the creation of a script: 

CZScript new 
	query: (CZBibFieldQuery named: #annote checks: [ :value | value = 'toto' ]);
	blackList: #(barr10a);
	fieldsToRemove: #(year);
	displayOrder: #(* misc);
	displayPattern: aCZDisplayPattern;
	sortByField: #year;
	sortByKey.


All messages in the interface protocol can be used to create your script: 
- blackList: aList -> a list of entry keys ; these entries will not be in the output file (by default, this list is empty)
- displayOrder: aList -> a list of entry types which give the order to display the entries. If no order is specified, the entries will be displayed in alphabetical order of their type. You can put a star (#*) in the list as a wildcard which means ""put here all types which are not in the list"". In the example below, the displayOrder is #(* misc): it means that all will be displayed in alphabetical order, except for the misc entries, which are at the end (the default displayOrder is #(*))
- displayPattern: aCZDisplayPattern -> read CZDisplayPattern class comment (the default displayPattern make that all the fields are displayed separated by a space)
- fieldsToRemove: aList -> don't display the fields specified in the collection (by default, this list is empty)
- query: aQuery -> a query that the entries should respect. Take a look at the Citezen-Query package (by default, there is no query)
- sortByKey and reversedSortByKey, sortByType and reversedSortByType, and sortByField: aSymbol and reversedSortByField: aSymbol, add a sort option. The order is important: in the example, the entries will be sorted by the value of their fields #year, and then,  all the entries which have the same year are sorted by the value of their keys. A little tip: don't add any sort option after sortByKey because keys are unique, so no other sort option can be used after it (by default, there is no sort option)


A script can have a title. This is to make sure that we can have labelled list of entries but that 
when there is no entries we can control the display of the title (and generally avoid it).
"
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
		'defaultSeparator',
		'generatingCollection',
		'document',
		'id',
		'title'
	],
	#classInstVars : [
		'sortMatching'
	],
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZScript class >> fieldSortBlock: aSymbol [ 
	^ ([ :value | self sortByField: value fieldToSort: aSymbol ])
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
CZScript >> acceptVisitor: aVisitor [
	"self id = 'journalsScript' ifTrue: [self halt.]."
	aVisitor visitScript: self
]

{ #category : #private }
CZScript >> addSort: aSymbol reversed: aBoolean [
	
	(sortCollection includes: aSymbol) 
			ifFalse: [ sortCollection add: (aSymbol -> aBoolean) ] 
]

{ #category : #accessing }
CZScript >> bibsetInput: aCZSet [
	bibset := aCZSet.
	aCZSet scope: CZSet standardDefinitions 
]

{ #category : #accessing }
CZScript >> blackList: aList [
	blackList := (aList ifNil: [#()])
]

{ #category : #interface }
CZScript >> displayOrder: aList [

	(aList isNil not) 
		ifTrue: [
			sortCollection addFirst: (self class typeSymbol -> false).
			displayOrder := aList asOrderedCollection ]
		ifFalse: [ displayOrder := #() ]
		
		
	
]

{ #category : #interface }
CZScript >> displayPattern: aCZDisplayPattern [
	displayPattern := (aCZDisplayPattern ifNil: [ CZDisplayPattern new ])
]

{ #category : #private }
CZScript >> displayWithDisplayOrder: anArray in: aCollection [
	| dictKeyIndex keys printedKeys currentKey index aBoolean |
	
	dictKeyIndex := Dictionary new.
	1 to: anArray size do: [ :cpt | dictKeyIndex at: (anArray at: cpt) key put: cpt ].
	keys := dictKeyIndex keys asOrderedCollection.
	
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

{ #category : #private }
CZScript >> document [ 
	^ document 
]

{ #category : #private }
CZScript >> document: aCZDocument [
	document := aCZDocument 
]

{ #category : #interface }
CZScript >> fieldsToRemove: aList [
	
	fieldsToRemove :=	(aList isEmptyOrNil)
							ifTrue: [  #() ]
							ifFalse: [aList collect: [ :each | each asLowercase asSymbol ] ]
]

{ #category : #private }
CZScript >> filter [
	query isNil ifFalse: [
		bibset entries: (bibset entries select: [ :each | query value: each])]
]

{ #category : #private }
CZScript >> generate [
	self 
		bibsetInput: document requestBibset;
		removeEntries;
		removeInSubmission;
		filter;
		sort;
		generateSeparatorsAndFieldsCollection
]

{ #category : #private }
CZScript >> generateSeparatorsAndFieldsCollection [
	| separators fields entryFieldsKeys |
		
	generatingCollection := OrderedCollection new.
	
	bibset entries do: [ :entry | 
		fields := OrderedCollection new.
		separators := OrderedCollection new.

		entryFieldsKeys := entry fields 
			collect: [ :each |
				(fieldsToRemove includes: each key)
					ifTrue: [ nil ]
					ifFalse: [ each key ] ]
			thenSelect: [ :each | each isNil not ].
		
		separators add: displayPattern begin.		
		(displayPattern fields includes: #* )
			ifFalse: [ self generateSeparatorsAndFieldsWithoutWildcardEntryFieldsKey: entryFieldsKeys fields: fields separators: separators ]
			ifTrue: [ self generateSeparatorsAndFieldsWithWildcardEntryFieldsKey: entryFieldsKeys fields: fields separators: separators ].
		separators add: displayPattern end.
		
		generatingCollection add: entry -> (fields -> separators) ].

]

{ #category : #private }
CZScript >> generateSeparatorsAndFieldsWithWildcardEntryFieldsKey: entryFieldsKey fields: fields separators: separators [
	| cpt  index fieldTmp fieldsTmp |
	
	fieldsTmp := displayPattern fields.
	fieldTmp := fieldsTmp at: (index := 1).
				
	[fieldTmp = #*] whileFalse: [ 
		(entryFieldsKey includes: fieldTmp) ifTrue: [
			fields add: fieldTmp.
			separators add: (displayPattern separators at: index ifAbsent: displayPattern defaultSeparator ) ]. 
		fieldTmp := fieldsTmp at: (index := index + 1) ].

	entryFieldsKey do: [ :each | 
		(fieldsTmp includes: each) ifFalse: [
			fields add: each.
			separators add: displayPattern defaultSeparator ] ].
	separators removeLast.
	index := index + 1.
				
	index to: fieldsTmp size do: [ :each | 
		(entryFieldsKey includes: (fieldsTmp at: each)) ifTrue: [
			fields add: (fieldsTmp at: each).
			separators add: (displayPattern separators at: index ifAbsent: displayPattern defaultSeparator ) ] ].
]

{ #category : #private }
CZScript >> generateSeparatorsAndFieldsWithoutWildcardEntryFieldsKey: entryFieldsKey fields: fields separators: separators [
	| cpt |
	
	cpt := 1.
	displayPattern fields do: [ :each | 
		(entryFieldsKey includes: each)
		ifTrue: [
			fields add: each.
			separators add: (displayPattern separators at: cpt ifAbsent: displayPattern defaultSeparator) ].
		cpt := cpt +1 ]
]

{ #category : #private }
CZScript >> generatingCollection [
	^ generatingCollection 
]

{ #category : #accessing }
CZScript >> hasTitle [
	
	^ self title isNil not
]

{ #category : #accessing }
CZScript >> id [ 
	"Return the id of the script - handy to debug."
	
	^ id
]

{ #category : #accessing }
CZScript >> id: anId [
	"anId can be anything."
	
	id := anId.
]

{ #category : #initialize }
CZScript >> initialize [
	super initialize.
	
	bibset := nil.
	outputer := nil.
	blackList := #().
	fieldsToRemove := #().
	sortCollection := OrderedCollection new.
	displayOrder := #().
	displayPattern := CZDisplayPattern new.
	query := nil.

]

{ #category : #private }
CZScript >> query [ 
	^ query
]

{ #category : #interface }
CZScript >> query: aQuery [
	query := aQuery 
]

{ #category : #private }
CZScript >> removeEntries [ 
	"This method removes all the entries which match at least one of these two cases :
		- To be in the blackListBlock 
		- To have a type which is not included in the displayOrder"

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
CZScript >> removeInSubmission [


	bibset entries: ( 
		bibset entries reject: (CZFieldQuery 
									named: #keywords 
									checks: [ :value | '*insubmission*' match: value ]))

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
	sortCollection ifNotEmpty: [
		bibset entries: (self sortStartingAt: 1 value: bibset entries) ].
	

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
	self class typeSymbol isNil ifTrue: [self halt].
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

{ #category : #accessing }
CZScript >> title [
	"Return a aCZTitleElement"
	^ title
	
]

{ #category : #accessing }
CZScript >> title: aCZTitleElement [

	title := aCZTitleElement
	
]

{ #category : #accessing }
CZScript >> titleString: aString [

	title := CZTitleElement new title: aString.
	
]
