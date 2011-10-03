"
A CZBibSetGatherer is collecting entries that are contained in a document.
It is handy to build for example the bibtex file associated with a given document (html page).


 CZBibSetGatherer bibsetFrom: 
"
Class {
	#name : #CZBibSetGatherer,
	#superclass : #CZDocumentVisitor,
	#instVars : [
		'bibset'
	],
	#category : #'Citezen-Outputers'
}

{ #category : #'instance creation' }
CZBibSetGatherer class >> bibsetFrom: aCZDocument [

	^ (self new collectFrom: aCZDocument) bibset
]

{ #category : #'public interface' }
CZBibSetGatherer >> bibset [

	^ bibset
]

{ #category : #'public interface' }
CZBibSetGatherer >> collectFrom: aCZDocument [

	self visitDocument: aCZDocument
]

{ #category : #initialize }
CZBibSetGatherer >> initialize [

	super initialize.
	bibset := CZSet withStandardDefinitions.
]

{ #category : #visiting }
CZBibSetGatherer >> visitEntry: anEntry [
	
	bibset addEntry: anEntry.
]

{ #category : #visiting }
CZBibSetGatherer >> visitScript: aCZScript [

	aCZScript generate.
	aCZScript generatingCollection do: [:each | each key acceptVisitor: self]
	
]
