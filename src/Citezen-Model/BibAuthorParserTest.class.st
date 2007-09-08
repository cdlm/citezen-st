Class {
	#name : #BibAuthorParserTest,
	#superclass : #TestCase,
	#category : #'Citezen-Tests'
}

{ #category : #testing }
BibAuthorParserTest >> testAuthorCommaSingle [
	| authorString authors |
	authorString := 'Nierstrasz, Oscar'.
	authors := BibAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray= #('Oscar').
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz')
]

{ #category : #testing }
BibAuthorParserTest >> testAuthorCommaTwoAuthors [
	| authorString authors |
	authorString := 'Nierstrasz, Oscar and Ducasse, St\''ephane'.
	authors :=  BibAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray= #('Oscar').
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz').
	self assert: (authors at: 2) firstNames asArray= #('St\''ephane').
	self assert: (authors at: 2) lastNames asArray = #('Ducasse').
]

{ #category : #testing }
BibAuthorParserTest >> testAuthorSingle [
	| authorString authors |
	authorString := 'Oscar Nierstrasz'.
	authors :=  BibAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray= #('Oscar').
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz')
]

{ #category : #testing }
BibAuthorParserTest >> testAuthorSingleNoFirstName [
	| authorString authors |
	authorString := ' Nierstrasz'.
	authors := BibAuthorParser parse: authorString.
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz')
]

{ #category : #testing }
BibAuthorParserTest >> testLongParticleName [
	| authorString author |
	authorString := 'Charles Louis Xavier Joseph de la Vallée Poussin'.
	author :=  (BibAuthorParser parse: authorString) first.
	self assert: author firstNames asArray = #('Charles' 'Louis' 'Xavier' 'Joseph').
	self assert: author lastNames asArray = #('Vallée' 'Poussin').
	self assert: author particles asArray = #('de' 'la')
]

{ #category : #testing }
BibAuthorParserTest >> testMultiParticleName [
	| authorString author |
	authorString := 'Théodule du Cellier de Lagrange'.
	author :=  (BibAuthorParser parse: authorString) first.
	self assert: author firstNames asArray = #('Théodule').
	self assert: author lastNames asArray = #('Cellier' 'de' 'Lagrange').
	self assert: author particles asArray = #('du')
]

{ #category : #testing }
BibAuthorParserTest >> testTwoAuthors [
	| authorString authors |
	authorString := 'Oscar Nierstrasz and St\''ephane Ducasse'.
	authors :=  BibAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray= #('Oscar').
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz').
	self assert: (authors at: 2) firstNames asArray= #('St\''ephane').
	self assert: (authors at: 2) lastNames asArray = #('Ducasse').
]
