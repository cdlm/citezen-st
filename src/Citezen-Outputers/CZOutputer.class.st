"
CZOutputer is an abstract class (all the visit*: messages are self subclassResponsibility).

It is a visitor, which can visit all the elements of a CZDocument.

It defines 3 messages:
- setOutputFile: aString -> gives the path for the field which will contain the result
- getLastOutput -> returns the last output as a String
- getOutputFor: aCZDocument -> opens the stream on the specified path (or, if setOutputFile: wasn't call, on String new) and generates the document

Note that the document is responsible of filtering fields that should not be considered.

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
		'authorDisplay'
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

{ #category : #'as yet unclassified' }
CZOutputer >> getLastOutput [
	^ lastOutput 
]

{ #category : #'as yet unclassified' }
CZOutputer >> getOutputFor: aCZDocument [
	(fileName isNil) 
		ifTrue: [ outputStream := WriteStream on: String new ]
		ifFalse: [ outputStream := FileStream newFileNamed: fileName ].

	[self visitDocument: aCZDocument.
		
	 lastOutput := outputStream contents trimBoth] 
		ensure: [
			outputStream close.
			outputStream := nil ].
	
	^ lastOutput 
	
]

{ #category : #'as yet unclassified' }
CZOutputer >> setAuthorDisplayOption: aSymbol [
	authorDisplay := aSymbol
]

{ #category : #'as yet unclassified' }
CZOutputer >> setOutputFile: aString [	
	fileName := aString
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitComment: aCZCommentElement [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitCompositeValue: aCZCompositeValue [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitDocument: aCZDocument [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitEntry: anEntry [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitField: aField [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitInteger: aCZInteger [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitMacroReference: aCZMacroReference [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitPeople: aCZPeople [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitScript: aCZScript [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitSet: aSet [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitString: aCZString [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitTitle: aCZTitleElement [
	self subclassResponsibility 
]
