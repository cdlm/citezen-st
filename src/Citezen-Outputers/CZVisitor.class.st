Class {
	#name : #CZVisitor,
	#superclass : #Object,
	#instVars : [
		'outputStream'
	],
	#category : #'Citezen-Outputers'
}

{ #category : #'as yet unclassified' }
CZVisitor >> getLastOutput [
	^ outputStream contents
]

{ #category : #'as yet unclassified' }
CZVisitor >> getOutputFor: aSet [
	outputStream reset.
	self visitSet: aSet.
	
	^ outputStream contents 
]

{ #category : #'as yet unclassified' }
CZVisitor >> initialize [
	super initialize.
	outputStream := WriteStream on: String new
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
