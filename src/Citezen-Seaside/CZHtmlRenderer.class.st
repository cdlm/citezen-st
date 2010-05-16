"
Render bibliographic entries to HTML using Seaside's canvas.

NB. Both BibHtmlRenderer and the canvas know about the stream, so using #setStream: after #html: will break stuff.
"
Class {
	#name : #CZHtmlRenderer,
	#superclass : #BibRenderer,
	#instVars : [
		'html'
	],
	#classInstVars : [
		'latexToHtmlReplacements'
	],
	#category : #'Citezen-Seaside'
}

{ #category : #'instance creation' }
CZHtmlRenderer class >> html: anHtmlCanvas [
	^ (self new)
		html: anHtmlCanvas;
		yourself
]

{ #category : #conversion }
CZHtmlRenderer class >> htmlOutOfLatexString: aString [
	"Probably could use a TeX to unicode TextConverter?
	
	Removing the curly braces last enforces accents like {\c c} instead of \c{c}. I think it makes more sense than the reverse since curly braces are also used to group stuff and prevent BibTeX to tamper with it."
	| text |
	text := aString asString.
	latexToHtmlReplacements keysAndValuesDo: [:pattern :replacement |
		text := text copyReplaceAll: pattern with: replacement asTokens: false ].
	text := text reject: [:each | each = ${ or: [each = $}]].
	^text
]

{ #category : #'class initialization' }
CZHtmlRenderer class >> initialize [
	super initialize.
	self initializeLatexToHtmlReplacements
]

{ #category : #'class initialization' }
CZHtmlRenderer class >> initializeLatexToHtmlReplacements [
	" self initializeLatexToHtmlReplacements "
	latexToHtmlReplacements := Dictionary new.
	latexToHtmlReplacements at: '\''a' put: '&aacute;';
		 at: '\''e' put: '&eacute;';
		 at: '\''i' put: '&iacute;';
		 at: '\''\i' put: '&iacute;';
		 at: '\''o' put: '&oacute;';
		 at: '\''u' put: '&uacute;';
		 at: '\''y' put: '&yacute;';
		 at: '\''A' put: '&Aacute;';
		 at: '\''E' put: '&Eacute;';
		 at: '\''I' put: '&Iacute;';
		 at: '\''O' put: '&Oacute;';
		 at: '\''U' put: '&Uacute;';
		 at: '\''Y' put: '&Yacute;';
		 at: '\^a' put: '&acirc;';
		 at: '\^e' put: '&ecirc;';
		 at: '\^i' put: '&icirc;';
		 at: '\^\i' put: '&icirc;';
		 at: '\^o' put: '&ocirc;';
		 at: '\^u' put: '&ucirc;';
		 at: '\^y' put: '&ycirc;';
		 at: '\^A' put: '&Acirc;';
		 at: '\^E' put: '&Ecirc;';
		 at: '\^I' put: '&Icirc;';
		 at: '\^O' put: '&Ocirc;';
		 at: '\^U' put: '&Ucirc;';
		 at: '\^Y' put: '&Ycirc;';
		 at: '\`a' put: '&agrave;';
		 at: '\`e' put: '&egrave;';
		 at: '\`i' put: '&igrave;';
		 at: '\`\i' put: '&igrave;';
		 at: '\`o' put: '&ograve;';
		 at: '\`u' put: '&ugrave;';
		 at: '\`y' put: '&ygrave;';
		 at: '\`A' put: '&Agrave;';
		 at: '\`E' put: '&Egrave;';
		 at: '\`I' put: '&Igrave;';
		 at: '\`O' put: '&Ograve;';
		 at: '\`U' put: '&Ugrave;';
		 at: '\`Y' put: '&Ygrave;';
		 at: '\"a' put: '&auml;';
		 at: '\"e' put: '&euml;';
		 at: '\"i' put: '&iuml;';
		 at: '\"\i' put: '&iuml;';
		 at: '\"o' put: '&ouml;';
		 at: '\"u' put: '&uuml;';
		 at: '\"y' put: '&yuml;';
		 at: '\"A' put: '&Auml;';
		 at: '\"E' put: '&Euml;';
		 at: '\"I' put: '&Iuml;';
		 at: '\"O' put: '&Ouml;';
		 at: '\"U' put: '&Uuml;';
		 at: '\"Y' put: '&Yuml;';
		 at: '\~n' put: '&ntilde;';
		 at: '\~N' put: '&Ntilde;';
		 at: '\c c' put: '&ccedil;';
		 at: '\c{c}' put: '&ccedil;';
		 at: '{\c c}' put: '&ccedil;';
		 at: '\c C' put: '&Ccedil;';
		 at: '\c{C}' put: '&Ccedil;';
		 at: '{\c C}' put: '&Ccedil;';
		 at: '\ae' put: '&aelig;';
		 at: '\AE' put: '&AElig;';
		 at: '\oe' put: '&oelig;';
		 at: '\OE' put: '&OElig;';
		 at: '\ss' put: '&szlig;';
		 at: '\&' put: '&amp;';
		 at: '--' put: '&ndash;';
		 at: '---' put: '&mdash;'
]

{ #category : #accessing }
CZHtmlRenderer >> contents [
	^ self html document stream contents
]

{ #category : #accessing }
CZHtmlRenderer >> html [
	^ html
]

{ #category : #accessing }
CZHtmlRenderer >> html: anHtmlCanvas [
	html := anHtmlCanvas
]

{ #category : #rendering }
CZHtmlRenderer >> render: anObject [
	WAHtmlCanvas builder render: [ :builder |
		self html: builder.
		super render: anObject ]
]

{ #category : #rendering }
CZHtmlRenderer >> text: aString [
	aString ifNil: [^ self].
	self html html:
		(self class htmlOutOfLatexString: aString)
]

{ #category : #'visiting-bibsets' }
CZHtmlRenderer >> visitBibSet: aBibSet [
	aBibSet do: [:each |
		self html listItem
			class: 'entry';
			with: [self visit: each]
	]
]

{ #category : #'visiting-bibsets' }
CZHtmlRenderer >> visitEntry: anEntry [
	self html anchor name: anEntry key.
	super visitEntry: anEntry
]

{ #category : #'visiting-phrases' }
CZHtmlRenderer >> visitFieldRef: aFieldRef [
	| field format |
	field := currentEntry at: aFieldRef fieldName.
	field ifNil: [^ self].
	
	format := self formatFor: field.
	(field key = #title and: [currentEntry hasField: #url])
		ifTrue: [
			self html anchor
				url: (currentEntry at: #url) value;
				with: [self visit: format]]
		ifFalse: [ self visit: format ]
]

{ #category : #'visiting-phrases' }
CZHtmlRenderer >> visitNamedPhrase: aPhrase [ 
	self html span
		class: aPhrase name;
		with: [super visitNamedPhrase: aPhrase]
]
