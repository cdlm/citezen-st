Class {
	#name : #CZAuthorParserTest,
	#superclass : #TestCase,
	#category : 'Citezen-Tests'
}

{ #category : #testing }
CZAuthorParserTest >> testCedillaName [
	"self debug: #testCedillaName"
	
	| authorString authors |
	authorString := 'Fran{\c c}oise Balmas'.
	authors := CZAuthorParser parse: authorString.
	self assert: authors first firstNames asArray = #('Fran{\c c}oise' ).
	self assert: authors first lastNames asArray = #('Balmas' )
]

{ #category : #testing }
CZAuthorParserTest >> testLongParticleName [
	| authorString author |
	authorString := 'Charles Louis Xavier Joseph de la Vallée Poussin'.
	author := (CZAuthorParser parse: authorString) first.
	self assert: author firstNames equals: #('Charles' 'Louis' 'Xavier' 'Joseph').
	self assert: author lastNames equals: #('Vallée' 'Poussin').
	self assert: author particles equals: #('de' 'la')
]

{ #category : #testing }
CZAuthorParserTest >> testMultiParticleName [
	| authorString author |
	authorString := 'Théodule du Cellier de Lagrange'.
	author := (CZAuthorParser parse: authorString) first.
	self assert: author firstNames asArray = #('Théodule' ).
	self assert: author lastNames asArray = #('Cellier' 'de' 'Lagrange' ).
	self assert: author particles asArray = #('du' )
]

{ #category : #testing }
CZAuthorParserTest >> testSingleAuthor [
	| authorString authors oscar |
	authorString := 'Oscar Nierstrasz'.
	authors := CZAuthorParser parse: authorString.
	self assert: authors size equals: 1.

	oscar := authors first.
	self assert: oscar firstNames size equals: 1.
	self assert: oscar firstNames first equals: 'Oscar'.
	self assert: oscar lastNames size equals: 1.
	self assert: oscar lastNames first equals: 'Nierstrasz'
]

{ #category : #testing }
CZAuthorParserTest >> testSingleAuthorComma [
	| authorString authors oscar |
	authorString := 'Nierstrasz, Oscar'.

	authors := CZAuthorParser parse: authorString.
	self assert: authors size equals: 1.

	oscar := authors first.
	self assert: oscar firstNames size equals: 1.
	self assert: oscar firstNames first equals: 'Oscar'.
	self assert: oscar lastNames size equals: 1.
	self assert: oscar lastNames first equals: 'Nierstrasz'
]

{ #category : #testing }
CZAuthorParserTest >> testSingleAuthorNoFirstName [
	| authorString authors |
	authorString := ' Nierstrasz'.
	authors := CZAuthorParser parse: authorString.
	self assert: authors first lastNames = #('Nierstrasz' )
]

{ #category : #testing }
CZAuthorParserTest >> testSingleAuthorWide [
	| authorString author |
	authorString := 'Stéphane Ducasse'.
	author := (CZAuthorParser parse: authorString) first.
	self assert: author firstNames = #('Stéphane' ).
	self assert: author lastNames = #('Ducasse' )
]

{ #category : #testing }
CZAuthorParserTest >> testTwoAuthors [
	| authorString authors |
	authorString := 'Oscar Nierstrasz and St\''ephane Ducasse'.
	authors := CZAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray = #('Oscar' ).
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz' ).
	self assert: (authors at: 2) firstNames asArray = #('St\''ephane' ).
	self assert: (authors at: 2) lastNames asArray = #('Ducasse' )
]

{ #category : #testing }
CZAuthorParserTest >> testTwoAuthorsComma [
	| authorString authors |
	authorString := 'Nierstrasz, Oscar and Ducasse, St\''ephane'.
	authors := CZAuthorParser parse: authorString.
	
	self assert: authors size equals: 2.
	self assert: authors first equals: (CZAuthor named: #('Nierstrasz') firstNames: #('Oscar')).
	self assert: authors second equals: (CZAuthor named: #('Ducasse') firstNames: #('St\''ephane')).

]
