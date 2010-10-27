"
CZChecker is a class helping you to check your BibTeX files.
It will check:
- Syntax errors
- Bad entry types
- Undefined macros
- Blank fields
- Duplicate fields
- Needed fields (depending on the type)
- Keys are unique
- All the rules you defined 

It allows to specifie some rules (e.g. tell that the key has to be a 7-character-long word) with the messages addRule: aBlock and addRule: aBlock named: aString.
A rule is a block with one parameter: a CZEntry.

You can check your file with these 3 lines:
checker := CZChecker new.
checker checkFile: '/Users/.../file.bib'.
checker checks.
If you compute it with ""print it"", you'll see the errors.
If you don't print it, you can do at anytime by doing ""print it"" on that:
checker errorString.
"
Class {
	#name : #CZChecker,
	#superclass : #Object,
	#instVars : [
		'fileContent',
		'rules',
		'eof',
		'parser',
		'errorStream',
		'entries',
		'typeFieldsMatching',
		'keys',
		'macros',
		'macrosUsage',
		'bibtexTypes',
		'macroKeys',
		'fieldKeys',
		'entryKeys',
		'index',
		'warnings'
	],
	#category : #'Citezen-Checking'
}

{ #category : #'as yet unclassified' }
CZChecker class >> basicRmodChecker [
	| checker |
	checker := self new.
	
	checker addRule: CZRmodKeyRule new.
	
	^ checker
]

{ #category : #'as yet unclassified' }
CZChecker class >> isWrittenByRModMember: aCZEntry [
	| authorField |
	
	(aCZEntry hasField: #author) ifFalse: [ ^ false ].
	authorField := (aCZEntry at: #author) value.
	^ #('*ducasse*' '*pollet*' '*laval*') anySatisfy: [ :each | each match: authorField ]
]

{ #category : #'as yet unclassified' }
CZChecker class >> rmodChecker [
	| checker |
	checker := self new.
	
	CZRmodRule allSubclassesDo: [ :each | checker addRule: each new ].
	
	^ checker
]

{ #category : #interface }
CZChecker >> addRule: aCZRule [
	(aCZRule isNil)
		ifFalse: [ rules add: aCZRule ]
]

{ #category : #interface }
CZChecker >> addRule: aBlock named: aString [
	| name |
	(aString isEmptyOrNil)
		ifTrue: [ name := 'rule', rules size asString ]
		ifFalse: [ name := aString ].
	
	((aBlock isNil not) & (aString isNil not))
		ifTrue: [ rules add: (name -> aBlock) ]
]

{ #category : #'as yet unclassified' }
CZChecker >> bibtexBlockToCZEntry: aString [
	| bibset |
	
	[ bibset := parser parse: aString.]
		on: Error do: [
			errorStream nextPutAll: 'Error : Syntax error in:'; cr; nextPutAll: aString; cr; cr ].
	
	bibset ifNotNil: [ 
		(bibset macros notEmpty) 
			ifTrue: [ 
				macros add: ((bibset macros at: 1)).
				macrosUsage at: ((bibset macros at: 1) key) put: false ].
		(bibset entries notEmpty) 
			ifTrue: [ 
				(bibset entries at: 1) scope: CZSet standardDefinitions.
				entries add: ((bibset entries at: 1)) ]	
	]
]

{ #category : #interface }
CZChecker >> checkBibset: aCZSet [
	macros := OrderedCollection new.
	macrosUsage := Dictionary new.
	entries := OrderedCollection new.
	errorStream := WriteStream on: String new.

	macros addAll: aCZSet macros.
	entries addAll: aCZSet entries.

	^ self checks

]

{ #category : #'as yet unclassified' }
CZChecker >> checkBibtexType: aCZEntry [
	(bibtexTypes includes: aCZEntry type asLowercase)
		ifFalse: [ 
			errorStream nextPutAll: 'Error: Bad entry type'; cr.
			^ false].
	^ true
]

{ #category : #'as yet unclassified' }
CZChecker >> checkDuplicateField: aCZField [
	(fieldKeys includes: aCZField key)
		ifTrue: [ 
			errorStream nextPutAll: 'Warning: Removes duplicate field: ', aCZField key; cr.
			^ false ].
	
	fieldKeys add: aCZField key.
	^ true
]

{ #category : #'as yet unclassified' }
CZChecker >> checkEmptyField: aCZField [
	(aCZField value = '')
		ifTrue: [ 
			errorStream nextPutAll: 'Warning: Removes empty field: ', aCZField key; cr.
			^ false ].
	
	^ true
]

{ #category : #interface }
CZChecker >> checkEntry: aCZEntry [
	^ self checkBibset: (CZSet new addEntry: aCZEntry)

]

{ #category : #interface }
CZChecker >> checkFile: aString [
	macros := OrderedCollection new.
	macrosUsage := Dictionary new.
	entries := OrderedCollection new.

	fileContent := (FileStream readOnlyFileNamed: aString) contents copyReplaceAll: String lf with: String cr.
	eof := false.

	errorStream := WriteStream on: String new.
	[eof] whileFalse: [ self bibtexBlockToCZEntry: self getBibtexBlock ].
	self halt.
	^ self checks

]

{ #category : #'as yet unclassified' }
CZChecker >> checkMacroReferenced: aCZField [
	| macroSymbols error |
	
	macroSymbols := OrderedCollection new.
	(aCZField valueClass = CZMacroReference)
		ifTrue: [ 
			macrosUsage at: aCZField rawValue put: true.
			macroSymbols add: aCZField rawValue ]
		ifFalse: [ (aCZField valueClass = CZCompositeValue)
			ifTrue: [ aCZField rawValue do: [ :each | 
				(each class = CZMacroReference)
					ifTrue: [ 
						macrosUsage at: each notExpanded put: true.
						macroSymbols add: each notExpanded ] ] ] ].
	
	error := false.	
	macroSymbols do: [ :each |
		(macroKeys includes: each)
			ifFalse: [ 
				errorStream nextPutAll: 'Warning: Removes field: ', aCZField key, ' references this undefined macro: ', each; cr.
				error := true ] ].
	
	^ error not
]

{ #category : #'as yet unclassified' }
CZChecker >> checks [
	| newEntries newFields newMacros toBeDeleted toBeInclude error |
	
	keys := Dictionary new.

	macros addAll: (CZSet standardDefinitions macros).
	
	"Don't display that some month macros are defined but not used"
	(CZSet standardDefinitions macros) do: [ :each | macrosUsage at: each key put: true ].
	
	newEntries := OrderedCollection new.
	macroKeys := macros collect: [ :each | each key ].

	entryKeys := entries collect: [ :each | each key ].
	
	index := 0.
	entries do: [ :entry |
		toBeInclude := true.	
		error := false.
		
		index := index + 1.
		
		"checks if the type of the entry is a correct bibtex type"
		(self checkBibtexType: entry)
			ifFalse: [ 
				error := true.
				toBeInclude := false ].
			
		newFields := OrderedCollection new.
		fieldKeys := OrderedCollection new.
		entry fields do: [ :field |
			toBeDeleted := false.
			
			"checks the macros referenced in the entry and removes fields with undefined macros"
			(self checkMacroReferenced: field)
				ifFalse: [ toBeDeleted := true ].
			
			toBeDeleted ifFalse: [	
				"removes empty fields"
				(self checkEmptyField: field)
					ifFalse: [ toBeDeleted := true ] ].

			"removes duplicate fields"
			(self checkDuplicateField: field)
				ifFalse: [ toBeDeleted := true ].
				
			toBeDeleted 
				ifFalse: [ newFields add: field ] 
				ifTrue: [ error := true ]
		].
		entry fields: newFields.
		
		"checks if the entry contains all the fields needed by it's type"
		((typeFieldsMatching at: (entry type)) value: (entry fields collect: [ :each | each key ]))
			ifFalse: [
				errorStream nextPutAll: 'Error: Entry does not contain all needed fields'; cr.
				error := true.
				toBeInclude := false ].
		
		"checks if the key is unique and changes it if it's not"
		"keys at: entry key put: ((keys at: entry key ifAbsent: 0) + 1).
		((keys at: entry key) > 1)
			ifTrue: [ | key |
				key := entry key.
				entry key: '###',(entry key, '_',(keys at: entry key) asString,'###' ).
				errorStream nextPutAll: 'Warning: duplicate key: ', key, ' changed to: ', entry key; cr.
		error := true ]."
		
		"checks if the entry respects all the rules"	
		rules do: [ :rule |
			"(rule value value: entry)"
			(rule check: entry)
				ifFalse: [
					errorStream nextPutAll: 'Error : entry does not respect the rule: ', rule explanation; cr.
					error := true.
					toBeInclude := false ] ].	
		
		"displays the errors and creates the collection with safe entries"
		error ifTrue: [
			((toBeInclude not) | (warnings & toBeInclude))
			ifTrue: [
				errorStream 
					nextPut: Character tab; 
					nextPutAll: 'for :'; 
					cr;
					nextPutAll: "assoc value; "(CZBibtexOutputer new entryToBibtexString: entry);
					cr.
			].
			toBeInclude 
				ifTrue: [
					warnings ifTrue: [
						newEntries add: entry.
						errorStream nextPutAll: '(There are only warnings, the entry is not deleted)'; cr; cr ] ]
				ifFalse: [
					errorStream nextPutAll: '(There are errors, the entry is deleted)'; cr; cr ]
		]
	].
	entries := newEntries.

	"removes unused macros"
	newMacros := OrderedCollection new.
	macros do: [ :macro | 
		(macrosUsage at: macro key)
			ifFalse: [ errorStream nextPutAll: 'Unused macro:'; cr; nextPutAll: macro; cr; cr ]
			ifTrue: [  newMacros add: macro ]	
	].
	macros := newMacros.
	
	errorStream close.
	
	Smalltalk at: #Console ifPresent: [ :console | console print: (self errorString copyReplaceAll: String cr with: String crlf) ].
	
	^ self errorString
]

{ #category : #'as yet unclassified' }
CZChecker >> errorString [
	^ errorStream contents trimRight ifEmpty: [ 'No error' ]
]

{ #category : #'as yet unclassified' }
CZChecker >> getBibtexBlock [
	| block end change braces parentheses |
	
	block := WriteStream on: ByteString new.
	change := end := false.
	braces := parentheses := 0.
	
	(eof) ifFalse: [
		[(fileContent isEmpty) | end] whileFalse: [
			block nextPut: fileContent first.
			(fileContent first = ${)
				ifTrue: [ braces := braces + 1. change := true ].
			(fileContent first = $()
				ifTrue: [ parentheses := parentheses + 1. change := true ].
			(fileContent first = $})
				ifTrue: [ braces := braces - 1 ].
			(fileContent first = $))
				ifTrue: [ parentheses := parentheses - 1 ].
			
			(change) ifTrue: [
				((parentheses = 0) & (braces = 0))
					ifTrue: [ end := true ] ]. 
			
			fileContent := fileContent allButFirst.
		]	
	].

	fileContent := fileContent trimRight.
	fileContent ifEmpty: [ eof := true ].

	^ (block contents) trimBoth
]

{ #category : #'as yet unclassified' }
CZChecker >> initialize [
	super initialize.
	
	parser := CZBibParser.
	rules := OrderedCollection new.
	typeFieldsMatching := Dictionary new.
	warnings := true.
	self initializeTypeFieldsMatching.
	self initializeBibtexTypes.

]

{ #category : #'as yet unclassified' }
CZChecker >> initializeBibtexTypes [
	bibtexTypes := #(article book booklet conference inbook incollection inproceedings manual mastersthesis misc phdthesis proceedings techreport unpublished)
]

{ #category : #'as yet unclassified' }
CZChecker >> initializeTypeFieldsMatching [

	typeFieldsMatching 
		at: #article put: [ :fields | | ret |
			ret := true.
			#(author title journal year) do: [ :each |
				(fields includes: each) 
					ifFalse: [ ret := false ] ]. 
			ret ];
	
		at: #book put: [ :fields | | ret |
			ret := true.
			((fields includes: #author) | (fields includes: #editor))
				ifFalse: [ ret := false ].
			#(title publisher year) do: [ :each |
				(fields includes: each) 
					ifFalse: [ ret := false ] ].
			ret ];

		at: #booklet put: [ :fields | 
			fields includes: #title ];

		at: #conference put: [ :fields | | ret |
			ret := true.
			#(author title booktitle year) do: [ :each |
				(fields includes: each) 
					ifFalse: [ ret := false ] ]. 
			ret ];
	
		at: #inbook put: [ :fields | | ret |
			ret := true.
			((fields includes: #author) | (fields includes: #editor))
				ifFalse: [ ret := false ].
			((fields includes: #chapter) | (fields includes: #pages))
				ifFalse: [ ret := false ].
			#(title publisher year) do: [ :each |
				(fields includes: each) 
					ifFalse: [ ret := false ] ].
			ret ];
		
		 at: #incollection put: [ :fields | | ret |
			ret := true.
			#(author title booktitle year) do: [ :each |
				(fields includes: each)
					ifFalse: [ ret := false ] ].
			ret ];

			at: #inproceedings put: [ :fields | | ret |
				ret := true.
				#(author title booktitle year) do: [ :each |
					(fields includes: each)
						ifFalse: [ ret := false ] ].
				ret ];

			at: #manual put: [ :fields |
				fields includes: #title ];

			at: #mastersthesis put: [ :fields | | ret |
				ret := true.
				#(author title school year) do: [ :each |
					(fields includes: each)
						ifFalse: [ ret := false ] ].
				ret ];

			at: #misc put: [ :fields |
				true ];

			at: #phdthesis put: [ :fields | | ret |
				ret := true.
				#(author title school year) do: [ :each |
					(fields includes: each)
						ifFalse: [ ret := false ] ].
				ret ];

			at: #proceedings put: [ :fields | | ret |
				ret := true.
				#(title year) do: [ :each |
					(fields includes: each)
						ifFalse: [ ret := false ] ].
				ret ];

			at: #techreport put: [ :fields | | ret |
				ret := true.
				#(author title institution year) do: [ :each |
					(fields includes: each)
						ifFalse: [ ret := false ] ].
				ret ];

			at: #unpublished put: [ :fields | | ret |
				ret := true.
				#(author title note) do: [ :each |
					(fields includes: each)
						ifFalse: [ ret := false ] ].
				ret ]
]

{ #category : #interface }
CZChecker >> notOnlyWarnings [
	warnings := false
]
