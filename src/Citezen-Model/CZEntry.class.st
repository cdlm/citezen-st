"
A bibliographic entry representing a single document or unit published work.

A BibTeX entry: 

@misc{barr10a,
	title = {Comment example}
}

3 informations: 
- ""misc"" is the TYPE of the entry
- ""barr10a"" is the KEY of the entry
- ""title = {Comment example}"" is a FIELD

So, a BibTeX entry respects this template:
@type{key,
	key = value,
	key = value,
	...
}

Most useful messages are:
- at: aSymbol -> returns the CZField for the field aSymbol
- at: aSymbol put: aValue  -> creates a CZField containing aValue and puts it at the key aSymbol
- fields and fields: aCollection -> getter & setter for the field collection
- hasField: aSymbol -> returns true/false if the entry has/has not a field with key=aSymbol
- key and key: aSymbol -> getter & setter for the key
- type and type: aSymbol aSymbol -> getter & setter for the key

These entries are stored in CZSet>>entries.
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
		'neededFieldsDictionary',
		'optionalFieldsDictionary'
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

{ #category : #cleanup }
CZEntry class >> fieldKeysToRemove [

	^ #(#'date-added' #'date-modified' #'bdsk-url-1' #'bdsk-url-2' )
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
			
	optionalFieldsDictionary := Dictionary new.
	
	optionalFieldsDictionary 
		at: #article put: #(volume number pages month note key),self inriaFields;
		at: #book put: #(volume series address edition month note key),self inriaFields;
		at: #booklet put: #(author howpublished address month year note key),self inriaFields;
		at: #conference put: #(editor pages organization publisher address month note key),self inriaFields;
		at: #inbook put: #(volume series address edition month note key),self inriaFields;
		at: #incollection put: #(editor pages organization publisher address month note key),self inriaFields;
		at: #inproceedings put: #(editor series pages organization publisher address month note key),self inriaFields;
		at: #manual put: #(author, organization, address, edition, month, year, note, key),self inriaFields;
		at: #mastersthesis put: #(address month note key),self inriaFields;
		at: #misc put: #(author title howpublished month year note key),self inriaFields;
		at: #phdthesis put: #(aaddress month note key),self inriaFields;
		at: #proceedings put: #(editor publisher organization address month note key),self inriaFields;
		at: #techreport put: #(type number address month note key),self inriaFields;
		at: #unpublished put: #(month year key),self inriaFields
		
	
]

{ #category : #metadata }
CZEntry class >> initializeNeededFields [
	"self initializeNeededFields"
	neededFieldsDictionary := Dictionary new.
	
	neededFieldsDictionary 
		at: #article put: {
			CZPool author.
			CZPool title.
			CZPool journal.
			CZPool year. };
		at: #book put: {
			CZPool author .
			CZPool editor .
			CZPool title .
			CZPool publisher .
			CZPool year. };
		at: #booklet put: { CZPool title };
		at: #conference put: {
			CZPool author.
			CZPool title.
			CZPool booktitle.
			CZPool year. };
		at: #inbook put: {
			CZPool author.
			CZPool editor.
			CZPool title. 
			CZPool chapter.
			CZPool pages.
			CZPool publisher.
			CZPool year. };
		at: #incollection put: {
			CZPool author.
			CZPool title.
			CZPool booktitle.
			CZPool year. };
		at: #inproceedings put: {
			CZPool author.
			CZPool title.
			CZPool booktitle.
			CZPool year. };
		at: #manual put: { CZPool title };
		at: #mastersthesis put: {
			CZPool author.
			CZPool title.
			CZPool school.
			CZPool year. };
		at: #misc put: #();
		at: #phdthesis put: {
			CZPool author.
			CZPool title.
			CZPool school.
			CZPool year. };
		at: #proceedings put: {
			CZPool title. 
			CZPool year. };
		at: #techreport put: {
			CZPool author.
			CZPool title.
			CZPool institution.
			CZPool year. };
		at: #unpublished put: {
			CZPool author.
			CZPool title.
			CZPool note. }.

	^ neededFieldsDictionary 
		
	
]

{ #category : #metadata }
CZEntry class >> inproceedings [
	^ #inproceedings
]

{ #category : #'instance creation' }
CZEntry class >> inriaFields [
	^ #(hal keywords annote aeresstatus aeres selectif labo inria impactfactor rate x-editorial-board x-proceedings x-international-audience x-pays x-invited-conference x-scientific-popularization )
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
CZEntry class >> privateFields [
	"privateFields is used to determine the fields that should be removed from our extended bib to offer a public bib"
	"Would be probably better to say that private is everything that is not public"
	
	^ #(hal keywords annote aeresstatus aeres selectif labo inria rate #'x-editorial-board' #'x-proceedings' #'x-international-audience' #'x-pays' #'x-invited-conference' #'x-scientific-popularization' #'x-language'  #'peerreview' #'hal-id' #Cvs)
]

{ #category : #metadata }
CZEntry class >> proceedings [
	^ #proceedings
]

{ #category : #metadata }
CZEntry class >> requiredFieldsFor: aSymbol [

	^ neededFieldsDictionary at: aSymbol ifAbsent: #()
]

{ #category : #metadata }
CZEntry class >> techreport [
	^ #techreport
]

{ #category : #metadata }
CZEntry class >> test [
	"self test"
	^  { CZPool author . CZPool title . CZPool journal . CZPool title }

]

{ #category : #metadata }
CZEntry class >> test2 [
	"self test"
	^  CZPool author
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

{ #category : #'add/remove' }
CZEntry >> addField: aCZField [
	fields add: aCZField.
	aCZField scope: self
]

{ #category : #'add/remove' }
CZEntry >> addFields: aCollection [
	fields addAll: aCollection.
	aCollection do: [:each | each scope: self]

]

{ #category : #bibset }
CZEntry >> addToBibSet: aCZSet [
	aCZSet addEntry: self
]

{ #category : #accessing }
CZEntry >> at: aSymbol [
	^ self at: aSymbol ifAbsent: [CZField undefined: aSymbol]
]

{ #category : #accessing }
CZEntry >> at: aSymbol ifAbsent: aBlock [
	| index |
	index := fields findFirst: [:each | each key = aSymbol].
	^ index = 0
		ifTrue: [aBlock value]
		ifFalse: [fields at: index]
]

{ #category : #accessing }
CZEntry >> at: aSymbol put: aValue [ 
	fields removeAllSuchThat: [:each | each key = aSymbol].
	fields add: ((CZField key: aSymbol rawValue: aValue)
				scope: self;
				yourself)
]

{ #category : #'predefined accessing' }
CZEntry >> author [

	^ self at: #author
]

{ #category : #'add/remove' }
CZEntry >> clean [
	
 	self class fieldKeysToRemove
		do: [:each | (self hasFieldWithKey: each)
						ifTrue: [self removeFieldWithKey: each]]
]

{ #category : #enumerating }
CZEntry >> do: aBlock [
	fields do: aBlock
]

{ #category : #enumerating }
CZEntry >> fieldSortedFollowingKeys: aCol [
	"Returns a collection of fields as specified by the keys given in aCol, if a key is not present skip it."
	| col |
	col := OrderedCollection new: aCol size.
	aCol do: [:each | 
				| res |
				res := self at: each ifAbsent: nil.
				res ifNotNil: [col add: res] ].
	^ col
]

{ #category : #accessing }
CZEntry >> fields [
	^ fields 
]

{ #category : #accessing }
CZEntry >> fields: aCollection [
	fields := aCollection 
]

{ #category : #accessing }
CZEntry >> hasField: aSymbol [
	^ fields anySatisfy: [:each | each key = aSymbol]
]

{ #category : #accessing }
CZEntry >> hasFieldWithKey: aSymbol [
	^ fields anySatisfy: [:each | each key = aSymbol]
]

{ #category : #initialize }
CZEntry >> initialize [
	fields := OrderedCollection new
]

{ #category : #'entry type testing' }
CZEntry >> isArticle [

	^ self type = self class article
]

{ #category : #'entry type testing' }
CZEntry >> isBook [

	^ self type = #book
]

{ #category : #'entry type testing' }
CZEntry >> isBooklet [

	^ self type = #booklet
]

{ #category : #'entry type testing' }
CZEntry >> isConference [

	^ self type = #conference
]

{ #category : #'entry type testing' }
CZEntry >> isInBook [

	^ self type = #inbook
]

{ #category : #'entry type testing' }
CZEntry >> isInCollection [

	^ self type = #inCollection
]

{ #category : #'entry type testing' }
CZEntry >> isInProceedings [

	^ self type = #inproceedings
]

{ #category : #'entry type testing' }
CZEntry >> isManual [

	^ self type = #manual
]

{ #category : #'entry type testing' }
CZEntry >> isMastersThesis [

	^ self type = #mastersthesis
]

{ #category : #'entry type testing' }
CZEntry >> isMisc [

	^ self type = #misc
]

{ #category : #'entry type testing' }
CZEntry >> isPhDThesis [

	^ self type = #phdthesis
]

{ #category : #'team utils' }
CZEntry >> isPharoPub [
	
	| keys |
	keys := (self at: #keywords) value.
	^ '*Pharo*' match: keys
]

{ #category : #'entry type testing' }
CZEntry >> isProceedings [

	^ self type = #proceedings
]

{ #category : #'team utils' }
CZEntry >> isTeamEntry [
	
	| author |
	
	author := self author value.
	^ #( '*Ducasse*S*' '*Denker*M*' '*Anquetil*N*' '*Pollet*D*' '*Abdeen*H*' '*Laval*J*' '*Peirs*R*' '*Falleri*' '*Denier*S*' '*Hora*'
		'*Casaccio*G*' '*Martinez-Peck*' '*Uquillas*' '*Arnaud*J*B*' '*Bhatti*U*' '*Fernandes*H*' '*Razavizadeh*A*' ) anySatisfy: [ :each | each match: author ]
]

{ #category : #'entry type testing' }
CZEntry >> isTechReport [

	^ self type = #techreport
]

{ #category : #'entry type testing' }
CZEntry >> isUnpublished [

	^ self type = #unpublished
]

{ #category : #'add/remove' }
CZEntry >> keepFields: aCollectionOfFieldKeys [
	
	self fields copy
		do: [:each | (aCollectionOfFieldKeys includes: each key)
						ifFalse: [self removeField: each ]]
	
]

{ #category : #accessing }
CZEntry >> key [
	^ key
]

{ #category : #accessing }
CZEntry >> key: aSymbol [
	key := aSymbol
]

{ #category : #accessing }
CZEntry >> macroReferences [
	"returns all fields of this entry that have a macro as value"
	^ fields select: [:each | each rawValue isSymbol]
]

{ #category : #bibset }
CZEntry >> moveToBibSet: aCZSet [
	self scope ifNotNilDo: [:it |
		"pull references if necessary"
		it removeEntry: self].
	aCZSet addEntry: self
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

{ #category : #'add/remove' }
CZEntry >> removeField: aCZField [

	fields remove: aCZField 
]

{ #category : #'add/remove' }
CZEntry >> removeFieldWithKey: aSymbol [

	 fields := fields reject: [:each | each key = aSymbol  ]
]

{ #category : #'add/remove' }
CZEntry >> removeFields: aCollectionOfFieldKeys [

	aCollectionOfFieldKeys
		do: [:each |  self removeFieldWithKey: each ]
	
]

{ #category : #accessing }
CZEntry >> size [
	^ fields size
]

{ #category : #enumerating }
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

{ #category : #'predefined accessing' }
CZEntry >> title [

	^ self at: CZPool title
]

{ #category : #accessing }
CZEntry >> type [
	^ type
]

{ #category : #initialize }
CZEntry >> type: aSymbol [
	type := aSymbol
]

{ #category : #'predefined accessing' }
CZEntry >> url [

	^ self at: #url
]

{ #category : #'predefined accessing' }
CZEntry >> year [

	^ self at: CZPool year 
]
