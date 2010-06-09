Class {
	#name : #CZTextOutputer,
	#superclass : #CZOutputer,
	#category : #'Citezen-Outputers'
}

{ #category : #registration }
CZTextOutputer class >> exporterEncoding [

	^ #text
]

{ #category : #'as yet unclassified' }
CZTextOutputer >> visitComment: aCZCommentElement [
	outputStream 
		nextPutAll: '(',aCZCommentElement comment,')';
		cr;
		cr
]

{ #category : #'as yet unclassified' }
CZTextOutputer >> visitCompositeValue: aCZCompositeValue [
	outputStream nextPutAll: aCZCompositeValue expanded 
]

{ #category : #'as yet unclassified' }
CZTextOutputer >> visitDocument: aCZDocument [	
	CZAccentuateCharactersParser toAccentedCharTable.
	aCZDocument elements do: [ :each | each acceptVisitor: self ]
]

{ #category : #'as yet unclassified' }
CZTextOutputer >> visitField: aField [
	aField dispatchVisitor: self
]

{ #category : #'as yet unclassified' }
CZTextOutputer >> visitInteger: aCZInteger [
	outputStream nextPutAll: aCZInteger notExpanded asString 
]

{ #category : #'as yet unclassified' }
CZTextOutputer >> visitMacroReference: aCZMacroReference [
	outputStream nextPutAll: aCZMacroReference expanded 
]

{ #category : #'as yet unclassified' }
CZTextOutputer >> visitPeople: aCZPeople [
	aCZPeople expandOption: authorDisplay.
	outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZPeople expanded)
]

{ #category : #'as yet unclassified' }
CZTextOutputer >> visitScript: aCZScript [
	| list beginList endList entry fields sep |
	
	aCZScript generate.

	aCZScript generatingCollection do: [ :assoc |
		entry := assoc key.
		fields := assoc value key.
		sep := assoc value value.
		
		outputStream nextPut: $-.
		1 to: fields size do: [ :cpt | 
			outputStream nextPutAll: (sep at: cpt).
			(entry at: (fields at: cpt)) acceptVisitor: self ].
		outputStream 
			nextPutAll: sep last;
			cr;
			cr.
	]
]

{ #category : #'as yet unclassified' }
CZTextOutputer >> visitString: aCZString [
	outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZString notExpanded)
]

{ #category : #'as yet unclassified' }
CZTextOutputer >> visitTitle: aCZTitleElement [
	outputStream 
		nextPutAll: aCZTitleElement title;
		cr;
		cr
]
