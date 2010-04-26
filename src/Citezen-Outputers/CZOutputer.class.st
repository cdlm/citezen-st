Class {
	#name : #CZOutputer,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'lastOutput',
		'outputStream',
		'separators',
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
CZOutputer >> getOutputFor: aSet [
	(fileName isNil) 
		ifTrue: [ outputStream := WriteStream on: String new ]
		ifFalse: [ outputStream := FileStream newFileNamed: fileName ].

	[self visitSet: aSet.
		
	 lastOutput := outputStream contents] 
		ensure: [
			outputStream close.
			outputStream := nil ].
	
	^ lastOutput 
	
]

{ #category : #'as yet unclassified' }
CZOutputer >> initialize [
	super initialize.
	fileName := nil.
	separators := #()
]

{ #category : #'as yet unclassified' }
CZOutputer >> separators: aCollection [
	separators := aCollection 
]

{ #category : #'as yet unclassified' }
CZOutputer >> setOutputFile: path [	
	fileName := path
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
CZOutputer >> visitSet: aSet [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZOutputer >> visitString: aCZString [
	self subclassResponsibility 
]
