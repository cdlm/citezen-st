"
A bibliographic entry representing a single document or unit published work.
"
Class {
	#name : #CZEntry,
	#superclass : #CZScoped,
	#instVars : [
		'type',
		'key',
		'fields'
	],
	#classInstVars : [
		'fieldsDictionary'
	],
	#category : #'Citezen-Model'
}

{ #category : #metadata }
CZEntry class >> article [
	^ #article
]

{ #category : #metadata }
CZEntry class >> book [
	^ #book
]

{ #category : #metadata }
CZEntry class >> booklet [
	^ #booklet
]

{ #category : #metadata }
CZEntry class >> conference [
	^ #conference
]

{ #category : #metadata }
CZEntry class >> inbook [
	^ #inbook
]

{ #category : #metadata }
CZEntry class >> incollection [
	^ #incollection
]

{ #category : #metadata }
CZEntry class >> initialize [
	"self initialize"
	fieldsDictionary := Dictionary new.
	
	fieldsDictionary 
		at: #article put: #(author title journal year);
		at: #book put: #(author editor title publisher year);
		at: #booklet put: #(title);
		at: #conference put: #(author title booktitle year);
		at: #inbook put: #(author editor title chapter pages publisher year);
		at: #incollection put: #(author title booktitle year);
		at: #inproceedings put: #(author title booktitle year);
		at: #manual put: #(title);
		at: #mastersthesis put: #(author title school year);
		at: #misc put: #();
		at: #phdthesis put: #(author title school year);
		at: #proceedings put: #(title year);
		at: #techreport put: #(author title institution year);
		at: #unpublished put: #(author title note)
		
	
]

{ #category : #metadata }
CZEntry class >> inproceedings [
	^ #inproceedings
]

{ #category : #metadata }
CZEntry class >> manual [
	^ #manual
]

{ #category : #metadata }
CZEntry class >> mastersthesis [
	^ #mastersthesis
]

{ #category : #metadata }
CZEntry class >> misc [
	^ #misc
]

{ #category : #metadata }
CZEntry class >> phdthesis [
	^ #phdthesis
]

{ #category : #metadata }
CZEntry class >> proceedings [
	^ #proceedings
]

{ #category : #metadata }
CZEntry class >> requiredFieldsFor: aSymbol [

	^ fieldsDictionary at: aSymbol ifAbsent: #()
]

{ #category : #metadata }
CZEntry class >> techreport [
	^ #techreport
]

{ #category : #'instance creation' }
CZEntry class >> type: entryType [
	^ self new type: entryType; yourself
]

{ #category : #metadata }
CZEntry class >> types [
	^ #(article book booklet conference inbook incollection inproceedings manual mastersthesis misc phdthesis proceedings techreport unpublished)
]

{ #category : #metadata }
CZEntry class >> unpublished [
	^ #unpublished
]

{ #category : #'visitor-double dispatch' }
CZEntry >> acceptVisitor: aVisitor [
	aVisitor visitEntry: self
]

{ #category : #accessing }
CZEntry >> addFields: aCollection [
	fields addAll: aCollection.
	aCollection do: [:each | each scope: self]

]

{ #category : #bibset }
CZEntry >> addToBibSet: aBibSet [
	aBibSet addEntry: self
]

{ #category : #accessing }
CZEntry >> at: fieldName [
	^ self at: fieldName ifAbsent: [CZField undefined: fieldName]
]

{ #category : #accessing }
CZEntry >> at: fieldName ifAbsent: aBlock [
	| index |
	index := fields findFirst: [:each | each key = fieldName].
	^ index = 0
		ifTrue: [aBlock value]
		ifFalse: [fields at: index]
]

{ #category : #accessing }
CZEntry >> at: fieldName put: aValue [ 
	fields removeAllSuchThat: [:each | each key = fieldName].
	fields add: ((CZField key: fieldName rawValue: aValue)
				scope: self;
				yourself)
]

{ #category : #enumerating }
CZEntry >> do: aBlock [
	fields do: aBlock
]

{ #category : #'as yet unclassified' }
CZEntry >> equalsButDifferent: anEntry [
	"test the equality between two DIFFERENT entries"
	
	(self == anEntry) ifTrue: [ ^ false ].
	
	((key = anEntry key) and: [ (type = anEntry type) ]) ifFalse: [ ^ false ].

	(self size = anEntry size) ifFalse: [ ^ false ].

	fields do: 
		[:each | ((anEntry at: each key) rawValue = each rawValue) 
			ifFalse:
				[ ^ false ]].
	
	^ true.
]

{ #category : #'as yet unclassified' }
CZEntry >> fields [
	^ fields 
]

{ #category : #'as yet unclassified' }
CZEntry >> fields: aCollection [
	fields := aCollection 
]

{ #category : #accessing }
CZEntry >> hasField: fieldName [
	^ fields anySatisfy: [:each | each key = fieldName]
]

{ #category : #'initialize-release' }
CZEntry >> initialize [
	fields := OrderedCollection new
]

{ #category : #accessing }
CZEntry >> key [
	^ key
]

{ #category : #accessing }
CZEntry >> key: aKey [
	key := aKey
]

{ #category : #accessing }
CZEntry >> macroReferences [
	"returns all fields of this entry that have a macro as value"
	^ fields select: [:each | each rawValue isSymbol]
]

{ #category : #bibset }
CZEntry >> moveToBibSet: aBibSet [
	self scope ifNotNilDo: [:it |
		"pull references if necessary"
		it removeEntry: self].
	aBibSet addEntry: self
]

{ #category : #printing }
CZEntry >> printOn: aStream [
	aStream
		nextPut: $@;
		nextPutAll: self type;
		nextPut: $(;
		nextPutAll: self key;
		nextPut: $)
]

{ #category : #accessing }
CZEntry >> size [
	^ fields size
]

{ #category : #'as yet unclassified' }
CZEntry >> sortFields: aList [
	"Big method which do this :
		- if aBoolean is true, the fields are sorted in three times :
			-- fields which are before the wildcard
			-- fields corresponding to the wildcard
			-- fields which are after the wildcard
		- if aBoolean is false, it just takes the fields needed in the good order
	In both cases, fields which are not specified in aList are deleted (the bibset is generate for each script)"

	| fieldKeys printedKeys newFields currentField index fieldsInWilcard aBoolean |
	
	newFields := OrderedCollection new.
	currentField := aList at: (index := 1).
	fieldKeys := fields collect: [ :each | each key ].
	index := fieldsInWilcard := 0.
	aBoolean := aList includes: #*.
	
	aBoolean
		ifFalse: [ 
			aList
				do: [ :each | 
					(fieldKeys includes: each)
						ifTrue: [ newFields add: (self at: each) ] ] ]
		ifTrue: [ 
			"Before the * wildcard"
			[ currentField ~= '*' ]
				whileTrue: [ 
					(fieldKeys includes: currentField)
						ifTrue: [ 
							newFields add: (self at: currentField).
							fieldKeys remove: currentField ].
					currentField := aList at: (index := index + 1) ].	
					
			"The * wildcard"
			printedKeys := OrderedCollection new.
			fieldKeys
				do: [ :each | 
					(aList includes: each)
						ifFalse: [ 
							newFields add: (self at: each).
							printedKeys add: each.
							fieldsInWilcard := fieldsInWilcard + 1 ] ].
			fieldKeys = (fieldKeys select: [ :each | (printedKeys includes: each) not ]).	
				
			"After the * wildcard"
			index := index + 1.
			[ index > aList size ]
				whileFalse: [ 
					currentField := aList at: index.
					(fieldKeys includes: currentField)
						ifTrue: [ newFields add: (self at: currentField) ].
					index := index + 1 ] ].
			
	fields := newFields.
	^ fieldsInWilcard
]

{ #category : #accessing }
CZEntry >> type [
	^ type
]

{ #category : #'initialize-release' }
CZEntry >> type: aType [
	type := aType
]
