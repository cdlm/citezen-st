Class {
	#name : #CZOutputer,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'lastOutput',
		'outputStream'
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
	fileName := nil
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
CZOutputer >> visitSet: aSet [
	self subclassResponsibility 
]
