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

It allows to specifie some rules (e.g. tell that the key has to be a 7-character-long word) with the messages addRule: aBlock and addRule: aBlock named: aString.
A rule is a block with one parameter: a CZEntry.

You can check your file with these 3 lines:
checker := CZChecker new.
checker fileToParse: '/Users/.../file.bib'.
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
		'index'
	],
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZChecker >> addRule: aBlock [
	self addRule: aBlock named: '' 
]

{ #category : #'as yet unclassified' }
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
		on: Error do: [ "self checkBibtexBlock: aString"
			errorStream nextPutAll: 'Error : Syntax error in:'; cr; nextPutAll: aString; cr; cr ].
	
	bibset ifNotNil: [ 
		(bibset macros notEmpty) 
			ifTrue: [ 
				macros add: ((bibset macros at: 1) -> aString).
				macrosUsage at: ((bibset macros at: 1) key) put: false ].
		(bibset entries notEmpty) 
			ifTrue: [ 
				(bibset entries at: 1) scope: CZSet standardDefinitions.
				entries add: ((bibset entries at: 1) -> aString) ]	
	]
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
	
	macros := OrderedCollection new.
	macrosUsage := Dictionary new.
	entries := OrderedCollection new.
	keys := Dictionary new.
	
	errorStream := WriteStream on: String new.
	[eof] whileFalse: [ self bibtexBlockToCZEntry: self getBibtexBlock ].

	macros addAll: ((CZSet standardDefinitions macros) collect: [ :each | each -> 'If you read it, there is a bug in Citezen!' ]).
	
	"Don't display that some month macros are defined but not used"
	(CZSet standardDefinitions macros) do: [ :each | macrosUsage at: each key put: true ].
	
	newEntries := OrderedCollection new.
	macroKeys := macros collect: [ :each | each key key ].

	entryKeys := entries collect: [ :each | each key key ].
	
	index := 0.
	entries do: [ :assoc |
		toBeInclude := true.	
		error := false.
		
		index := index + 1.
		
		"checks if the type of the entry is a correct bibtex type"
		(self checkBibtexType: assoc key)
			ifFalse: [ 
				error := true.
				toBeInclude := false ].
			
		newFields := OrderedCollection new.
		fieldKeys := OrderedCollection new.
		assoc key fields do: [ :field |
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
		assoc key fields: newFields.
		
		"checks if the entry contains all the fields needed by it's type"
		((typeFieldsMatching at: (assoc key type)) value: (assoc key fields collect: [ :each | each key ]))
			ifFalse: [
				errorStream nextPutAll: 'Error: Entry does not contain all needed fields'; cr.
				error := true.
				toBeInclude := false ].
		
		"checks if the key is unique and changes it if it's not"
		keys at: assoc key key put: ((keys at: assoc key key ifAbsent: 0) + 1).
		((keys at: assoc key key) > 1)
			ifTrue: [ | key |
				key := assoc key key.
				assoc key key: '###',(assoc key key, '_',(keys at: assoc key key) asString,'###' ).
				errorStream nextPutAll: 'Warning: duplicate key: ', key, ' changed to: ', assoc key key; cr.
		error := true ].
		
		"checks if the entry respects all the rules"	
		rules do: [ :rule |
			(rule value value: assoc key)
				ifFalse: [
					errorStream nextPutAll: 'Error : entry does not respect the rule: ', rule key; cr.
					error := true.
					toBeInclude := false ] ].	
		
		"displays the errors and creates the collection with safe entries"
		error ifTrue: [ 
			errorStream nextPut: Character tab; nextPutAll: 'for :'; cr; nextPutAll: assoc value; cr.
			toBeInclude 
				ifTrue: [ 
					newEntries add: assoc key.
					errorStream nextPutAll: '(There are only warnings, the entry is not deleted)'; cr; cr ]
				ifFalse: [
					errorStream nextPutAll: '(There are errors, the entry is deleted)'; cr; cr ]
		]
	].
	entries := newEntries.

	"removes unused macros"
	newMacros := OrderedCollection new.
	macros do: [ :assoc | 
		(macrosUsage at: assoc key key)
			ifFalse: [ errorStream nextPutAll: 'Unused macro:'; cr; nextPutAll: assoc value; cr; cr ]
			ifTrue: [  newMacros add: assoc ]	
	].
	macros := newMacros.
	
	errorStream close.
	
	^ self errorString
]

{ #category : #'as yet unclassified' }
CZChecker >> errorString [
	^ errorStream contents trimRight 
]

{ #category : #'as yet unclassified' }
CZChecker >> fileToParse: aString [
	fileContent := (FileStream readOnlyFileNamed: aString) contents copyReplaceAll: String lf with: String cr.
	eof := false
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
		
		 at: #incolletion put: [ :fields | | ret |
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
