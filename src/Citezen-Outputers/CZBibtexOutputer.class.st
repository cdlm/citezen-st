"
Obviously, visits all elements of the document and writes their BibTeX equivalent on the output stream.
"
Class {
	#name : #CZBibtexOutputer,
	#superclass : #CZOutputer,
	#category : #'Citezen-Outputers'
}

{ #category : #registration }
CZBibtexOutputer class >> exporterEncoding [

	^ #bib
]

{ #category : #conversion }
CZBibtexOutputer >> entryToBibtexString: aCZEntry [
	outputStream := String new writeStream.
	self visitEntry: aCZEntry.
	outputStream close.
	^ outputStream contents
	
]

{ #category : #conversion }
CZBibtexOutputer >> macroToBibtexString: aCZField [
	outputStream :=  String new writeStream.
	self visitMacro: aCZField.
	outputStream close.
	^ outputStream contents
	
]

{ #category : #visiting }
CZBibtexOutputer >> visitComment: aCZCommentElement [
	outputStream 
		nextPut: $#;
		nextPutAll: aCZCommentElement comment;
		lf
]

{ #category : #visiting }
CZBibtexOutputer >> visitCompositeValue: aCZCompositeValue [
	aCZCompositeValue do: 
		[ :each | each acceptVisitor: self] separatedBy: [ outputStream nextPutAll: ' # ' ].
]

{ #category : #visiting }
CZBibtexOutputer >> visitDocument: aCZDocument. [	
	aCZDocument originalBibset macros do: [ :each | 
		outputStream nextPutAll: '@string{'.
		each acceptVisitor: self.
		outputStream nextPut: $}; lf.].
	outputStream lf.
	aCZDocument elements do: [ :each | each acceptVisitor: self ]
	


]

{ #category : #visiting }
CZBibtexOutputer >> visitEntry: anEntry [
	outputStream  
		nextPut: $@;
		nextPutAll: anEntry type;
		nextPut: ${;
		nextPutAll: anEntry key;
		nextPut: $,;
		lf.
		
	(anEntry fields reject: [ :aField | (blackListedFields includes: aField key)])
		do: [ :each | each acceptVisitor: self ]
		separatedBy: [ outputStream nextPut: $,; lf ].
		
	outputStream 
		lf;
		nextPut: $}

]

{ #category : #visiting }
CZBibtexOutputer >> visitField: aField [

	outputStream 
		nextPutAll: '  ';
		nextPutAll: aField key;
		nextPutAll: ' = '.
	aField dispatchVisitor: self
]

{ #category : #visiting }
CZBibtexOutputer >> visitInteger: aCZInteger [
	outputStream nextPutAll: aCZInteger notExpanded asString 
]

{ #category : #visiting }
CZBibtexOutputer >> visitMacro: aCZField [
	outputStream nextPutAll: '@string{'.
	self visitField: aCZField. 
	outputStream nextPutAll: ' }'
]

{ #category : #visiting }
CZBibtexOutputer >> visitMacroReference: aCZMacroReference [
	outputStream nextPutAll: aCZMacroReference notExpanded 
]

{ #category : #visiting }
CZBibtexOutputer >> visitPeople: aCZPeople [
	aCZPeople displayNormalizedName.
	outputStream 
		nextPut: ${;
		nextPutAll: aCZPeople notExpanded;
		nextPut: $}
]

{ #category : #visiting }
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
			lf.
		1 to: fields size do: [ :cpt | 
			outputStream 
				lf;
				nextPutAll: '  '.
			(entry at: (fields at: cpt)) acceptVisitor: self.
			(cpt = fields size) ifFalse: [ outputStream nextPut: $, ] ].
		outputStream
			lf; 
			nextPutAll: '}';
			lf;
			lf
	].

]

{ #category : #visiting }
CZBibtexOutputer >> visitSet: aSet [	
	lastEntryVisited := 0.
	
	aSet macros do: [ :each | 
		outputStream nextPutAll: '@string {'.
		each acceptVisitor: self.
		outputStream nextPut: $}; lf ].
	outputStream lf.
	aSet entries do: [ :each | 
		each acceptVisitor: self.
		outputStream lf; lf ].
	
]

{ #category : #visiting }
CZBibtexOutputer >> visitString: aCZString [
	outputStream 
		nextPut: ${;
		nextPutAll: aCZString notExpanded; 
		nextPut: $}
]

{ #category : #visiting }
CZBibtexOutputer >> visitTitle: aCZTitleElement [
	"does nothing"
]
