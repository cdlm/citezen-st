Class {
	#name : #CZRawOutputer,
	#superclass : #CZOutputer,
	#category : #'Citezen-Outputers'
}

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitComment: aCZCommentElement [
	outputStream 
		nextPutAll: '@comment { ';
		nextPutAll: aCZCommentElement comment;
		nextPutAll: ' }';
		cr;
		cr
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitCompositeValue: aCZCompositeValue [
	aCZCompositeValue do: 
		[ :each | each acceptVisitor: self] separatedBy: [ outputStream nextPutAll: ' # ' ].
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitDocument: aCZDocument [
	aCZDocument originalBibset macros do: [ :each | 
		outputStream nextPutAll: '@string {'.
		each acceptVisitor: self.
		outputStream nextPut: $}; cr; cr.
		].

	aCZDocument elements do: [ :each | each acceptVisitor: self ]
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitEntry: anEntry [	
	anEntry fields do: [ :each |
		each acceptVisitor: self.
		(each == (anEntry fields at: anEntry size))
			ifFalse: [outputStream nextPut: $,; cr]]

]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitField: aField [
	outputStream 
		nextPutAll: '  ';
		nextPutAll: aField key;
		nextPutAll: ' = '.
	aField dispatchVisitor: self
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitInteger: aCZInteger [
	outputStream nextPutAll: aCZInteger notExpanded asString 
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitMacroReference: aCZMacroReference [
	outputStream nextPutAll: aCZMacroReference notExpanded 
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitPeople: aCZPeople [
	outputStream 
		nextPutAll: '{ ';
		nextPutAll: aCZPeople notExpanded;
		nextPutAll: ' }'
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitScript: aCZScript [
	| list beginList endList entry fields sep |

	aCZScript generate.
	
	aCZScript generatingCollection do: [ :assoc |
		entry := assoc key.
		fields := assoc value key.
		sep := assoc value value.
		
		outputStream 
			nextPut: $@;
			nextPutAll: entry type;
			nextPutAll: ' {'.
		1 to: fields size do: [ :cpt | 
			outputStream 
				cr;
				nextPutAll: '  '.
			(entry at: (fields at: cpt)) acceptVisitor: self ].
		outputStream
			cr; 
			nextPutAll: '}';
			cr;
			cr
	].

]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitSet: aSet [	
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
CZRawOutputer >> visitString: aCZString [
	outputStream 
		nextPutAll: '{ ';
		nextPutAll: aCZString notExpanded; 
		nextPutAll: ' }'
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitTitle: aCZTitleElement [
	"does nothing"
]
