"
Obviously, visits all elements of the document and writes their BibTeX equivalent on the output stream.
"
Class {
	#name : #CZBibtexOutputer,
	#superclass : #CZOutputer,
	#category : #'Citezen-Outputers'
}

{ #category : #'as yet unclassified' }
CZBibtexOutputer class >> exporterEncoding [

	^ #bib
]

{ #category : #'as yet unclassified' }
CZBibtexOutputer >> visitComment: aCZCommentElement [
	outputStream 
		nextPutAll: '@comment { ';
		nextPutAll: aCZCommentElement comment;
		nextPutAll: ' }';
		cr;
		cr
]

{ #category : #'as yet unclassified' }
CZBibtexOutputer >> visitCompositeValue: aCZCompositeValue [
	aCZCompositeValue do: 
		[ :each | each acceptVisitor: self] separatedBy: [ outputStream nextPutAll: ' # ' ].
]

{ #category : #'as yet unclassified' }
CZBibtexOutputer >> visitDocument: aCZDocument. [	
	aCZDocument originalBibset macros do: [ :each | 
		outputStream nextPutAll: '@string {'.
		each acceptVisitor: self.
		outputStream nextPut: $}; cr; cr.
	].

	aCZDocument elements do: [ :each | each acceptVisitor: self ]
]

{ #category : #'as yet unclassified' }
CZBibtexOutputer >> visitEntry: anEntry [	
	anEntry fields do: [ :each |
		each acceptVisitor: self.
		(each == (anEntry fields at: anEntry size))
			ifFalse: [outputStream nextPut: $,; cr]]

]

{ #category : #'as yet unclassified' }
CZBibtexOutputer >> visitField: aField [
	outputStream 
		nextPutAll: '  ';
		nextPutAll: aField key;
		nextPutAll: ' = '.
	aField dispatchVisitor: self
]

{ #category : #'as yet unclassified' }
CZBibtexOutputer >> visitInteger: aCZInteger [
	outputStream nextPutAll: aCZInteger notExpanded asString 
]

{ #category : #'as yet unclassified' }
CZBibtexOutputer >> visitMacroReference: aCZMacroReference [
	outputStream nextPutAll: aCZMacroReference notExpanded 
]

{ #category : #'as yet unclassified' }
CZBibtexOutputer >> visitPeople: aCZPeople [
	aCZPeople expandOption: CZPeople displayNormalizedName.
	outputStream 
		nextPutAll: '{ ';
		nextPutAll: aCZPeople notExpanded;
		nextPutAll: ' }'
]

{ #category : #'as yet unclassified' }
CZBibtexOutputer >> visitScript: aCZScript [
	| list beginList endList entry fields sep |

	aCZScript generate.
	
	aCZScript generatingCollection do: [ :assoc |
		entry := assoc key.
		fields := assoc value key.
		sep := assoc value value.
		
		outputStream 
			nextPut: $@;
			nextPutAll: entry type;
			nextPutAll: ' {';
			nextPutAll: entry key;
			nextPut: $,;
			cr.
		1 to: fields size do: [ :cpt | 
			outputStream 
				cr;
				nextPutAll: '  '.
			(entry at: (fields at: cpt)) acceptVisitor: self.
			(cpt = fields size) ifFalse: [ outputStream nextPut: $, ] ].
		outputStream
			cr; 
			nextPutAll: '}';
			cr;
			cr
	].

]

{ #category : #'as yet unclassified' }
CZBibtexOutputer >> visitSet: aSet [	
	lastEntryVisited := 0.
	
	aSet macros do: [ :each | 
		outputStream nextPutAll: '@string {'.
		each acceptVisitor: self.
		outputStream nextPut: $}; cr; cr.
		].
	
	aSet entries do: [ :each | 
		outputStream nextPut: $@;
			nextPutAll: each type;
			nextPutAll: ' {';
			nextPutAll: each key;
			nextPut: $,; cr.
		each acceptVisitor: self.
		outputStream cr; nextPut: $}; cr; cr.].
	
]

{ #category : #'as yet unclassified' }
CZBibtexOutputer >> visitString: aCZString [
	outputStream 
		nextPutAll: '{ ';
		nextPutAll: aCZString notExpanded; 
		nextPutAll: ' }'
]

{ #category : #'as yet unclassified' }
CZBibtexOutputer >> visitTitle: aCZTitleElement [
	"does nothing"
]