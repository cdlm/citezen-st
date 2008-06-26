Class {
	#name : #CZBibEntryHtmlRenderer,
	#superclass : #BibTextRenderer,
	#instVars : [
		'html'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #'as yet unclassified' }
CZBibEntryHtmlRenderer class >> html: anHtmlCanvas [
	^ (self new)
		html: anHtmlCanvas;
		yourself
]

{ #category : #'as yet unclassified' }
CZBibEntryHtmlRenderer class >> htmlOutOfLatexString: aString [

	| text |
	text _ aString asString reject: [:each | each = ${ or: [each = $}]].

	text _ text copyReplaceAll: '\''e' with: '&eacute;' asTokens: false.
	text _ text copyReplaceAll: '\^i' with: '&icirc;' asTokens: false.
	text _ text copyReplaceAll: '\^\i' with: '&icirc;' asTokens: false.

	^text
]

{ #category : #accessing }
CZBibEntryHtmlRenderer >> contents [
	^ self html document stream contents
]

{ #category : #accessing }
CZBibEntryHtmlRenderer >> html [
	^html
]

{ #category : #accessing }
CZBibEntryHtmlRenderer >> html: aHtmlCanvas [
	html _ aHtmlCanvas.
	self setStream: html document stream
]

{ #category : #'visitor-double dispatch' }
CZBibEntryHtmlRenderer >> visitBibSet: aBibSet [
	aBibSet do: [:each |
		self html listItem
			class: 'entry';
			with: [self visit: each]
	]
]

{ #category : #'visiting-bibsets' }
CZBibEntryHtmlRenderer >> visitEntry: anEntry [
	self render: (self phraseFor: anEntry) for: anEntry
]

{ #category : #'visitor-double dispatch' }
CZBibEntryHtmlRenderer >> visitFieldRef: aFieldRef [
	| text |
	text _ (currentEntry at: aFieldRef fieldName) value.
	text := self class htmlOutOfLatexString: text.
	
	(aFieldRef fieldName = 'title' and: [currentEntry hasField: 'url'])
		ifTrue: [self html anchor url: (currentEntry at: 'url') value; with: text]
		ifFalse: [self html html: text.]
]

{ #category : #'visitor-double dispatch' }
CZBibEntryHtmlRenderer >> visitLiteralPhrase: aPhrase [
	self html text: (aPhrase text reject: [:each | each = ${ or: [each = $}]])
]

{ #category : #'visitor-double dispatch' }
CZBibEntryHtmlRenderer >> visitNamedPhrase: aPhrase [ 
	self html span
		class: aPhrase name;
		with: [super visitNamedPhrase: aPhrase]
]
