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
		'macrosUsage'
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
			ifTrue: [ entries add: ((bibset entries at: 1) -> aString) ]	
	]
]

{ #category : #'as yet unclassified' }
CZChecker >> bibtexTypes [
	^ #(article book booklet conference inbook incollection inproceedings manual mastersthesis misc phsthesis proceedings techreport unpublished)
]

{ #category : #'as yet unclassified' }
CZChecker >> checkBibtexBlock: aString [
	| string initChar endChar count countCountAtZero |
	
	string := aString deepCopy.
	
	(string first = $@)
		ifTrue: [ string := string allButFirst ]
		ifFalse: [ self error: '@ missing in ', aString ].
		
	[ string first isLetter ] whileTrue: [ string := string allButFirst ].

	string := string trimBoth.
	((string first = ${) | (string first = $()) 
		ifTrue: [ initChar := string first. string := string allButFirst ]
		ifFalse: [ self error: '{ or (' ].
	
	(initChar = ${)
		ifTrue: [ endChar := $} ]
		ifFalse: [ endChar := $) ].
	count := 1.
	
	countCountAtZero := 0.
	string do: [ :char |
		(char = initChar) ifTrue: [ count := count + 1 ].
		(char = endChar) ifTrue: [ count := count - 1 ].
		(count = 0) ifTrue: [ countCountAtZero := countCountAtZero + 1 ] ].
	
	(countCountAtZero > 1) ifTrue: [ self error: 'Two entries -> @' ]
	
		
	
]

{ #category : #'as yet unclassified' }
CZChecker >> checks [
	| collection |
	
	entries := OrderedCollection new.
	
	errorStream := WriteStream on: String new.
	[eof] whileFalse: [ self bibtexBlockToCZEntry: self getBibtexBlock ].

	"checks if the entries types are valid bibtex types"
	collection := OrderedCollection new.
	entries do: [ :assoc | 
		(self bibtexTypes includes: assoc key type asLowercase)
			ifTrue: [ collection add: assoc ]
			ifFalse: [ errorStream nextPutAll: 'Error : Bad entry type for :'; cr; nextPutAll: assoc value; cr; cr ]].
	entries := collection.
	
	"removes fields with empty value"
	entries do: [ :assoc | 
		collection := OrderedCollection new.
		assoc key fields do: [ :field |
			(field value = '')
				ifFalse: [ collection add: field ]
				ifTrue: [ errorStream nextPutAll: 'Warning : Remove field: ', field key, ' in :'; cr; nextPutAll: assoc value; cr; cr ] ].
		assoc key fields: collection ].
	
	"removes empty entries"
	collection := OrderedCollection new.
	entries do: [ :assoc |
		(assoc key fields size = 0)
			ifFalse: [ collection add: assoc ]
			ifTrue: [ errorStream nextPutAll: 'Warning : Remove empty entry:'; cr; nextPutAll: assoc value; cr; cr ] ].
	entries := collection.
	
	"removes entries which don't have all the fields needed by their types"
	collection := OrderedCollection new.
	entries do: [ :assoc |
		((typeFieldsMatching at: (assoc key type)) value: (assoc key fields collect: [ :each | each key ]))
			ifTrue: [ collection add: assoc ]
			ifFalse: [ errorStream nextPutAll: 'Error : This entry does not contain all needed fields:'; cr; nextPutAll: assoc value; cr; cr ] ].
	entries := collection.
	
	"checks and corrects duplicate entry keys"
	entries do: [ :assoc | 
		keys at: assoc key key put: ((keys at: assoc key key ifAbsent: 0) + 1).
		((keys at: assoc key key) > 1)
			ifTrue: [ 
				assoc key key: '###',(assoc key key, '_',(keys at: assoc key key) asString,'###' ).
				errorStream nextPutAll: 'Warning: duplicate key changed to: ',assoc key key,' in:'; cr; nextPutAll: assoc value; cr; cr] ].

	"removes entries which don't match with the rules"
	rules do: [ :rule |
		collection := OrderedCollection new.
		entries do: [ :assoc | 
			(rule value value: assoc key)
				ifTrue: [ collection add: assoc ] 
				ifFalse: [ errorStream nextPutAll: 'Error : entry does not respect the rule: ', rule key, ' in:'; cr; nextPutAll: assoc value; cr; cr ] ].
		
		entries := collection ].
]

{ #category : #'as yet unclassified' }
CZChecker >> checks2 [
	| newEntries newFields newMacros toBeInclude error |
	
	macros := OrderedCollection new.
	macrosUsage := Dictionary new.
	entries := OrderedCollection new.
	
	errorStream := WriteStream on: String new.
	[eof] whileFalse: [ self bibtexBlockToCZEntry: self getBibtexBlock ].

	newEntries := OrderedCollection new.
	
	entries do: [ :assoc |
		toBeInclude := true.	
		error := false.
		
		"checks if the type of the entry is a correct bibtex type"
		(self bibtexTypes includes: assoc key type asLowercase)
			ifFalse: [ 
				errorStream nextPutAll: 'Error: Bad entry type'; cr.
				error := true.
				toBeInclude := false ].
			
		newFields := OrderedCollection new.
		assoc key fields do: [ :field |
			"checks the macros referenced in the entry"
			(field valueClass = CZMacroReference)
				ifTrue: [ macrosUsage at: field rawValue put: true ].
			(field valueClass = CZCompositeValue)
				ifTrue: [ field valueObject do: [ :each | 
					(each class = CZMacroReference)
						ifTrue: [ macrosUsage at: each notExpanded put: true ] ] ].
				
			"remove the empty fields"
			(field value = '')
				ifFalse: [ newFields add: field ]
				ifTrue: [ 
					errorStream nextPutAll: 'Warning: Removes empty field: ', field key; cr.
					error := true ] ].
		assoc key fields: newFields.
		
		"checks if the entry is empty"
		(assoc key fields size = 0)
			ifTrue: [ 
				errorStream nextPutAll: 'Error: Entry is empty'; cr.
				error := true.
				toBeInclude := false ].
		
		"checks if the entry contains all the fiels needed by it's type"
		((typeFieldsMatching at: (assoc key type)) value: (assoc key fields collect: [ :each | each key ]))
			ifFalse: [
				errorStream nextPutAll: 'Error: Entry does not contain all needed fields'; cr.
				error := true.
				toBeInclude := false ].
		
		"checks if the key is unique and change it if it's not"
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

	"removes unused macros"
	newMacros := OrderedCollection new.
	macros do: [ :assoc | 
		(macrosUsage at: assoc key key)
			ifFalse: [ errorStream nextPutAll: 'Unused macro:'; cr; nextPutAll: assoc value; cr; cr ]
			ifTrue: [  newMacros add: assoc ]	
	].
	macros := newMacros 
	
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

	^ (block contents) trimBoth
]

{ #category : #'as yet unclassified' }
CZChecker >> getBibtexBlock2 [
	| block |
	
	self flag: 'DEPRECATED'.
	eof ifFalse: [
		block := WriteStream on: String new.
	
		(fileContent isEmpty)
			ifFalse: [
				fileContent := fileContent allButFirst.
				block nextPut: $@.
	
				fileContent 
					detect: [ :char |
						(char = $@) 
							ifTrue: [ true ]
							ifFalse: [ block nextPut: char. fileContent := fileContent allButFirst. false ]	]
					ifNone: [ eof := true ]
			 ].

	^ block contents trimBoth 
	].

	^ nil
]

{ #category : #'as yet unclassified' }
CZChecker >> initialize [
	super initialize.
	
	parser := CZBibParser.
	rules := OrderedCollection new.
	keys := Dictionary new.
	typeFieldsMatching := Dictionary new.
	self initializeTypeFieldsMatching.

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
