Class {
	#name : #CZOutputer,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'lastOutput',
		'outputStream',
		'lastEntryVisited',
		'defaultSeparator'
	],
	#classInstVars : [
		'blackList'
	],
	#category : #'Citezen-Outputers'
}

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
		
	 lastOutput := outputStream contents] 
		ensure: [
			outputStream close.
			outputStream := nil ].
	
	^ lastOutput 
	
]

{ #category : #'as yet unclassified' }
CZOutputer >> setOutputFile: path [	
	fileName := path
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
