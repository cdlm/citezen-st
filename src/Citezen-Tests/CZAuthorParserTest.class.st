Class {
	#name : #CZAuthorParserTest,
	#superclass : #TestCase,
	#category : #'Citezen-Tests'
}

{ #category : #testing }
CZAuthorParserTest >> testAuthorCommaSingle [
	| authorString authors |
	authorString := 'Nierstrasz, Oscar'.
	authors := CZAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray = #('Oscar' ).
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz' )
]

{ #category : #testing }
CZAuthorParserTest >> testAuthorCommaTwoAuthors [
	| authorString authors |
	authorString := 'Nierstrasz, Oscar and Ducasse, St\''ephane'.
	authors := CZAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray = #('Oscar' ).
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz' ).
	self assert: (authors at: 2) firstNames asArray = #('St\''ephane' ).
	self assert: (authors at: 2) lastNames asArray = #('Ducasse' )
]

{ #category : #testing }
CZAuthorParserTest >> testAuthorSingle [
	| authorString authors |
	authorString := 'Oscar Nierstrasz'.
	authors := CZAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray = #('Oscar' ).
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz' )
]

{ #category : #testing }
CZAuthorParserTest >> testAuthorSingleNoFirstName [
	| authorString authors |
	authorString := ' Nierstrasz'.
	authors := CZAuthorParser parse: authorString.
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz' )
]

{ #category : #testing }
CZAuthorParserTest >> testCedillaName [
	"self debug: #testCedillaName"
	
	| authorString authors |
	authorString := 'Fran{\c c}oise Balmas'.
	authors := CZAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray = #('Fran{\c c}oise' ).
	self assert: (authors at: 1) lastNames asArray = #('Balmas' )
]

{ #category : #testing }
CZAuthorParserTest >> testLongParticleName [
	| authorString author |
	authorString := 'Charles Louis Xavier Joseph de la Vallée Poussin'.
	author := (CZAuthorParser parse: authorString) first.
	self 
		assert: author firstNames asArray = #('Charles' 'Louis' 'Xavier' 'Joseph' ).
	self assert: author lastNames asArray = #('Vallée' 'Poussin' ).
	self assert: author particles asArray = #('de' 'la' )
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
	"self debug: #testSingleAuthor"
	
	| authorString authors |
	authorString := 'Stéphane Ducasse'.
	authors := CZAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray = #('Stéphane' ).
	self assert: (authors at: 1) lastNames asArray = #('Ducasse' )
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
