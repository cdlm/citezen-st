"
A CZDocumentVisitor is a visitor that walks over CZDocument (as well as CZBibsets to be confirmed)
"
Class {
	#name : #CZDocumentVisitor,
	#superclass : #Object,
	#instVars : [
		'fileName',
		'lastOutput',
		'outputStream',
		'lastEntryVisited',
		'defaultSeparator',
		'authorDisplay'
	],
	#category : #'Citezen-Outputers'
}

{ #category : #visiting }
CZDocumentVisitor >> visitComment: aCZCommentElement [
	
]

{ #category : #visiting }
CZDocumentVisitor >> visitCompositeValue: aCZCompositeValue [
]

{ #category : #visiting }
CZDocumentVisitor >> visitDocument: aCZDocument [
	aCZDocument elements do: [ :each | each acceptVisitor: self ]
]

{ #category : #visiting }
CZDocumentVisitor >> visitEntry: anEntry [
	
]

{ #category : #visiting }
CZDocumentVisitor >> visitField: aField [
]

{ #category : #visiting }
CZDocumentVisitor >> visitInteger: aCZInteger [
]

{ #category : #visiting }
CZDocumentVisitor >> visitPeople: aCZPeople [
]

{ #category : #visiting }
CZDocumentVisitor >> visitScript: aCZScript [
]

{ #category : #visiting }
CZDocumentVisitor >> visitSet: aCZSet [

	aCZSet entries do: [:each | each acceptVisitor: self]
]

{ #category : #visiting }
CZDocumentVisitor >> visitTitle: aCZTitleElement [
	"does nothing"
]
