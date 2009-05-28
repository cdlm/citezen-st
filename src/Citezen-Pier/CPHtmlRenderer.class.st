"
I render bibliographic entries to HTML using Seaside's canvas.

NB. Both BibHtmlRenderer and the canvas know about the stream, so using #setStream: after #html: will break stuff.

I am a clone of CZHtmlRender (by Damien Pollet) in the Citezen-Seaside package.

CHANGES:
- Fixed latexToHtmlReplacements to handle chars in curly braces
- Added a number of further latex translation
- Added activation of urls within notes

"
Class {
	#name : #CPHtmlRenderer,
	#superclass : #BibRenderer,
	#instVars : [
		'html'
	],
	#classInstVars : [
		'latexToHtmlReplacements'
	],
	#category : #'Citezen-Pier'
}

{ #category : #'class initialization' }
CPHtmlRenderer class >> addAccentReplacements [
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
		 at: '\cc' put: '&ccedil;';
		 at: '\c c' put: '&ccedil;';
		 at: '\c{c}' put: '&ccedil;';
		 at: '\c C' put: '&Ccedil;';
		 at: '\c{C}' put: '&Ccedil;';
		 at: '\ae' put: '&aelig;';
		 at: '\AE' put: '&AElig;';
		 at: '\oe' put: '&oelig;';
		 at: '\OE' put: '&OElig;';
		 at: '\ss' put: '&szlig;';
		 at: '\/o' put: '&oslash;';
		 at: '\/O' put: '&Oslash;';
		 at: '\''c' put: '&#263;';
		 at: '\v{C}' put: '&#268;';
		 at: '\v{c}' put: '&#269;';
		 at: '\vC' put: '&#268;';
		 at: '\vc' put: '&#269;';
		 at: '$\pi$' put: '&pi;';
		 at: '$\lambda$' put: '&lambda;';
		 at: '$\sim$' put: '~';
		 at: '\-' put: '';
		 at: '\_' put: '_';
		 at: '\#' put: '#';
		 at: '\$' put: '$';
		 at: '---' put: '&mdash;';
		 at: '--' put: '&mdash;'
]

{ #category : #'class initialization' }
CPHtmlRenderer class >> addBracedAccentReplacements [
	| re newkey |
	re := '(\\\W)(\w)' asRegex.
	latexToHtmlReplacements keys
		do: [:key | (re matches: key)
				ifTrue: [newkey := (re subexpression: 2)
								, '{'
								, (re subexpression: 3) , '}'.
					latexToHtmlReplacements
						at: newkey
						put: (latexToHtmlReplacements at: key)]]
]

{ #category : #'instance creation' }
CPHtmlRenderer class >> html: anHtmlCanvas [
	^ (self new)
		html: anHtmlCanvas;
		yourself
]

{ #category : #conversion }
CPHtmlRenderer class >> htmlOutOfLatexString: aString [
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
CPHtmlRenderer class >> initialize [
	super initialize.
	self initializeLatexToHtmlReplacements
]

{ #category : #'class initialization' }
CPHtmlRenderer class >> initializeLatexToHtmlReplacements [
	"self initializeLatexToHtmlReplacements"
	latexToHtmlReplacements := Dictionary new.
	self addAccentReplacements.
	self addBracedAccentReplacements.
]

{ #category : #accessing }
CPHtmlRenderer >> contents [
	^ self html document stream contents
]

{ #category : #accessing }
CPHtmlRenderer >> currentEntryUrl [
	^ ('\s+' asRegex split: (currentEntry at: #url) value) first
]

{ #category : #accessing }
CPHtmlRenderer >> html [
	^ html ifNil: [
		html := WAStaticHtmlCanvas document:
			(WAHtmlStreamDocument new stream: (String new writeStream))]
]

{ #category : #accessing }
CPHtmlRenderer >> html: anHtmlCanvas [
	html := anHtmlCanvas
]

{ #category : #rendering }
CPHtmlRenderer >> text: aString [
	aString ifNil: [^ self].
	self html html:
		(self class htmlOutOfLatexString: aString)
]

{ #category : #'visiting-bibsets' }
CPHtmlRenderer >> visitEntry: anEntry [
	self html anchor name: anEntry key.
	super visitEntry: anEntry
]

{ #category : #'visiting-phrases' }
CPHtmlRenderer >> visitFieldRef: aFieldRef [
	| field format re url |
	field := currentEntry at: aFieldRef fieldName.
	field ifNil: [^ self].
	
	format := self formatFor: field.
	(field key = #title and: [currentEntry hasField: #url])
		ifTrue: [
			self html anchor
				url: self currentEntryUrl;
				with: [self visit: format]]
		ifFalse: [ 
			re := '\\url\{([^}]*)}' asRegexIgnoringCase .
			(field key = #note and: [re search: field rawValue])
				ifTrue: [
					url := (self class htmlOutOfLatexString: (re subexpression: 2)).
					self html anchor
						url: url;
						with: url
					]
				ifFalse: [self visit: format] ]
]

{ #category : #'visiting-phrases' }
CPHtmlRenderer >> visitNamedPhrase: aPhrase [
	self html span
		class: aPhrase name;
		with: [super visitNamedPhrase: aPhrase]
]
