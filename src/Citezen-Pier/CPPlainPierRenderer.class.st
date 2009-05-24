"
Should render a CZEntry in Pier wiki format, complete with abstract and links, for use in new items.

To be completed.
"
Class {
	#name : #CPPlainPierRenderer,
	#superclass : #BibRenderer,
	#instVars : [
		'stream'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'instance creation' }
CPPlainPierRenderer class >> forField: aFieldSelector [
	^ self new library: (CPBibPhraseFieldLibrary forField: aFieldSelector); yourself
]

{ #category : #conversion }
CPPlainPierRenderer class >> htmlOutOfLatexString: aString [
	^ CPHtmlRenderer htmlOutOfLatexString: aString
]

{ #category : #'as yet unclassified' }
CPPlainPierRenderer >> cleanWhiteSpace: aString [ 
	^ '\s+' asRegex 
		copy: aString
		replacingMatchesWith: ' '
]

{ #category : #accessing }
CPPlainPierRenderer >> contents [
	^ stream contents
]

{ #category : #initialization }
CPPlainPierRenderer >> initialize [
	stream := WriteStream on: String new.
]

{ #category : #rendering }
CPPlainPierRenderer >> text: aString [ 
	aString ifNil: [ ^ self ].
	stream nextPutAll: (self class htmlOutOfLatexString: (self cleanWhiteSpace: aString asString))
]
