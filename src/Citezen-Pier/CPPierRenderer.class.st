"
Should render a CZEntry in Pier wiki format, complete with abstract and links, for use in new items.

To be completed.
"
Class {
	#name : #CPPierRenderer,
	#superclass : #BibRenderer,
	#instVars : [
		'stream'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'as yet unclassified' }
CPPierRenderer class >> htmlOutOfLatexString: aString [
	^ CPHtmlRenderer htmlOutOfLatexString: aString
]

{ #category : #'as yet unclassified' }
CPPierRenderer >> cleansTabsAndLineFeeds: aString [
	aString copyReplaceAll: String lf, String cr, String tab with: String space.
	^ aString
]

{ #category : #'as yet unclassified' }
CPPierRenderer >> contents [
	^ stream contents
]

{ #category : #'as yet unclassified' }
CPPierRenderer >> initialize [
	stream := WriteStream on: String new.
]

{ #category : #'as yet unclassified' }
CPPierRenderer >> text: aString [
	aString ifNil: [^ self].
	stream nextPutAll: (self class htmlOutOfLatexString: (self cleansTabsAndLineFeeds: aString asString))
]

{ #category : #'visiting-phrases' }
CPPierRenderer >> visitFieldRef: aFieldRef [
	| field format re url |
	field := currentEntry at: aFieldRef fieldName.
	field ifNil: [^ self].
	
	self flag: 'This method is a mess. We need to generate the abstract as well for the Blog.'.
	
	format := self formatFor: field.
	(field key = #title and: [currentEntry hasField: #url])
		ifTrue: [
			self text: '*';
				visit: format;
				text: '>';
				text: (currentEntry at: #url) value;
				text: '*' ]
		ifFalse: [ 
			re := '\\url\{([^}]*)}' asRegexIgnoringCase .
			(field key = #note and: [re search: field rawValue])
				ifTrue: [
					url := (self class htmlOutOfLatexString: (re subexpression: 2)).
					self text: '*', url, '*'
					]
				ifFalse: [self visit: format] ]
]
