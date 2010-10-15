"
Obviously, visits all elements of the document and writes their text equivalent on the output stream.
"
Class {
	#name : #CZTextOutputer,
	#superclass : #CZOutputer,
	#category : #'Citezen-Outputers'
}

{ #category : #registration }
CZTextOutputer class >> exporterEncoding [

	^ #text
]

{ #category : #visiting }
CZTextOutputer >> visitComment: aCZCommentElement [
	outputStream 
		nextPutAll: '(',aCZCommentElement comment,')';
		lf;
		lf
]

{ #category : #visiting }
CZTextOutputer >> visitCompositeValue: aCZCompositeValue [
	outputStream nextPutAll: aCZCompositeValue expanded 
]

{ #category : #visiting }
CZTextOutputer >> visitDocument: aCZDocument [
	aCZDocument elements do: [ :each | each acceptVisitor: self ]
]

{ #category : #visiting }
CZTextOutputer >> visitField: aField [
	aField dispatchVisitor: self
]

{ #category : #visiting }
CZTextOutputer >> visitInteger: aCZInteger [
	outputStream nextPutAll: aCZInteger notExpanded asString 
]

{ #category : #visiting }
CZTextOutputer >> visitMacroReference: aCZMacroReference [
	outputStream nextPutAll: aCZMacroReference expanded 
]

{ #category : #visiting }
CZTextOutputer >> visitPeople: aCZPeople [
	aCZPeople expandOption: authorDisplay.
	outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZPeople expanded)
]

{ #category : #visiting }
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
			lf;
			lf.
	]
]

{ #category : #visiting }
CZTextOutputer >> visitString: aCZString [
	outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZString notExpanded)
]

{ #category : #visiting }
CZTextOutputer >> visitTitle: aCZTitleElement [
	outputStream 
		nextPutAll: aCZTitleElement title;
		lf;
		lf
]
