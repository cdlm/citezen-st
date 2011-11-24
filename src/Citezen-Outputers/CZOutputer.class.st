"
CZOutputer is an abstract class (all the visit*: messages are self subclassResponsibility).
It is a visitor, which can visit all the elements of a CZDocument.

It defines 3 messages:
	- setOutputFile: aString -> gives the path for the field which will contain the result
	- getLastOutput -> returns the last output as a String
	- getOutputFor: aCZDocument -> opens the stream on the specified path (or, if setOutputFile: wasn't call, on String new) and generates the document

Note that the document is responsible of filtering fields that should not be considered.

I could be a subclass of CZBibVisitor and I should probably be migrated there.
Now this is not clear. 

Stef
"
Class {
	#name : #CZOutputer,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'lastOutput',
		'outputStream',
		'lastEntryVisited',
		'authorDisplay',
		'blackListedFields',
		'fieldSeparator'
	],
	#pools : [
		'CZPool'
	],
	#classInstVars : [
		'blackList'
	],
	#category : #'Citezen-Outputers'
}

{ #category : #registration }
CZOutputer class >> exporterEncoding [

	^ self subclassResponsibility
]

{ #category : #accessing }
CZOutputer >> blackListedFields [

	^ blackListedFields
]

{ #category : #accessing }
CZOutputer >> blackListedFields: aFieldKeyCollection [

	blackListedFields := aFieldKeyCollection
]

{ #category : #accessing }
CZOutputer >> contents [
	^  outputStream contents trimBoth
]

{ #category : #visiting }
CZOutputer >> emitEntryFooter: anEntry [
]

{ #category : #visiting }
CZOutputer >> emitEntryHeader: anEntry [
	"Add to the outputStream a header for the correponding anEntry if needed."
]

{ #category : #accessing }
CZOutputer >> entriesToString: aCollection [
	outputStream := String new writeStream.
	aCollection do: [:each | 
		self visitEntry: each] separatedBy: [outputStream lf].
	outputStream close.
	^ outputStream contents
]

{ #category : #accessing }
CZOutputer >> entryToString: aCZEntry [
	outputStream := String new writeStream.
	self visitEntry: aCZEntry.
	outputStream close.
	^ outputStream contents
]

{ #category : #accessing }
CZOutputer >> fieldSeparator [ 

	^ fieldSeparator 
]

{ #category : #accessing }
CZOutputer >> fieldSeparator: aCharacter [

	fieldSeparator := aCharacter
]

{ #category : #accessing }
CZOutputer >> getLastOutput [
	^ lastOutput 
]

{ #category : #accessing }
CZOutputer >> getOutputFor: aCZDocument [
	self initializeOutputStream.
	[self visitDocument: aCZDocument.		
	 lastOutput := self contents] 
		ensure: 
			[ outputStream close.
			outputStream := nil ].
	^ lastOutput 
	
]

{ #category : #initialize }
CZOutputer >> initialize [

	super initialize.
	blackListedFields := #().
	fieldSeparator := $, .
]

{ #category : #initialize }
CZOutputer >> initializeOutputStream [
	self flag: #fixme.
	"what a fuck?" 
	"why do we have this logic - sd"
	(fileName isNil) 
		ifTrue: [ outputStream := String new writeStream ]
		ifFalse: [ outputStream := FileStream newFileNamed: fileName ].
	
]

{ #category : #accessing }
CZOutputer >> setAuthorDisplayOption: aSymbol [
	authorDisplay := aSymbol
]

{ #category : #accessing }
CZOutputer >> setOutputFile: aString [	
	fileName := aString
]

{ #category : #visiting }
CZOutputer >> visitComment: aCZCommentElement [
	self subclassResponsibility 
]

{ #category : #visiting }
CZOutputer >> visitCompositeValue: aCZCompositeValue [
	self subclassResponsibility
]

{ #category : #visiting }
CZOutputer >> visitDocument: aCZDocument [
	
	aCZDocument elements do: [ :each | each acceptVisitor: self ]
]

{ #category : #visiting }
CZOutputer >> visitEntry: anEntry [
	self emitEntryHeader: anEntry.
	(anEntry fields reject: [ :aField | (blackListedFields includes: aField key)])
		do: [ :each | each acceptVisitor: self ]
		separatedBy: [ outputStream nextPut: self fieldSeparator; lf ].
	self emitEntryFooter: anEntry
]

{ #category : #visiting }
CZOutputer >> visitField: aField [
	self subclassResponsibility 
]

{ #category : #visiting }
CZOutputer >> visitInteger: aCZInteger [
	outputStream nextPutAll: aCZInteger notExpanded asString 
]

{ #category : #visiting }
CZOutputer >> visitMacroReference: aCZMacroReference [
	self subclassResponsibility 
]

{ #category : #visiting }
CZOutputer >> visitPeople: aCZPeople [
	self subclassResponsibility 
]

{ #category : #visiting }
CZOutputer >> visitScript: aCZScript [

	| list beginList endList entry fields sep |
	aCZScript generate.	
	aCZScript generatingCollection isEmpty ifTrue: [^self].
	
	aCZScript hasTitle
		ifTrue: [aCZScript title acceptVisitor: self].
		
	outputStream nextPutAll: '\begin{itemize}'; lf.
	
	aCZScript generatingCollection do: [ :assoc |
		entry := assoc key.
		fields := assoc value key.
		sep := assoc value value.
		
		"This part sucks! why this is not in the visitEntry?"
		
		outputStream nextPutAll: '\pub'.
		1 to: fields size do: [ :cpt | 
			outputStream nextPutAll: (sep at: cpt).
			(entry at: (fields at: cpt)) acceptVisitor: self ].
		outputStream nextPutAll: sep last; lf ].
	
	outputStream nextPutAll: '\end{itemize}'; lf; lf.

]

{ #category : #visiting }
CZOutputer >> visitSet: aSet [
	self subclassResponsibility 
]

{ #category : #visiting }
CZOutputer >> visitString: aCZString [

	outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZString notExpanded)
]

{ #category : #visiting }
CZOutputer >> visitTitle: aCZTitleElement [
	
	outputStream 
		nextPutAll: '\section{';
		nextPutAll: aCZTitleElement title;
		nextPutAll: '}';
		lf;
		lf
]
