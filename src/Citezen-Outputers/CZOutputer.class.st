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
		'defaultSeparator',
		'authorDisplay',
		'blackListedFields'
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
]

{ #category : #initialize }
CZOutputer >> initializeOutputStream [
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
	self subclassResponsibility 
]

{ #category : #visiting }
CZOutputer >> visitField: aField [
	self subclassResponsibility 
]

{ #category : #visiting }
CZOutputer >> visitInteger: aCZInteger [
	self subclassResponsibility 
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
	self subclassResponsibility
]

{ #category : #visiting }
CZOutputer >> visitSet: aSet [
	self subclassResponsibility 
]

{ #category : #visiting }
CZOutputer >> visitString: aCZString [
	self subclassResponsibility 
]

{ #category : #visiting }
CZOutputer >> visitTitle: aCZTitleElement [
	self subclassResponsibility 
]
