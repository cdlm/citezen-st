Class {
	#name : #CZVisitor,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'lastOutput',
		'outputStream'
	],
	#category : #'Citezen-Outputers'
}

{ #category : #'as yet unclassified' }
CZVisitor >> getLastOutput [
	^ lastOutput 
]

{ #category : #'as yet unclassified' }
CZVisitor >> getOutputFor: aSet [
	(fileName isNil) 
		ifTrue: [ outputStream := WriteStream on: String new ]
		ifFalse: [ outputStream := FileStream newFileNamed: fileName ].

	self visitSet: aSet.
	
	lastOutput := outputStream contents.
	outputStream close.
	outputStream := nil.
	
	^ lastOutput 
	
]

{ #category : #'as yet unclassified' }
CZVisitor >> initialize [
	super initialize.
	fileName := nil
]

{ #category : #'as yet unclassified' }
CZVisitor >> setOutputFile: path [	
	fileName := path
]

{ #category : #'as yet unclassified' }
CZVisitor >> visitEntry: anEntry [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZVisitor >> visitField: aField [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
CZVisitor >> visitSet: aSet [
	self subclassResponsibility 
]
