Class {
	#name : #BibAuthorParserTest,
	#superclass : #TestCase,
	#category : #'Citezen-Tests'
}

{ #category : #tests }
BibAuthorParserTest >> testAuthorCommaSingle [
	| authorString authors |
	authorString := 'Nierstrasz, Oscar'.
	authors := BibAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray= #('Oscar').
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz')
]

{ #category : #tests }
BibAuthorParserTest >> testAuthorCommaTwoAuthors [
	| authorString authors |
	authorString := 'Nierstrasz, Oscar and Ducasse, St\''ephane'.
	authors :=  BibAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray= #('Oscar').
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz').
	self assert: (authors at: 2) firstNames asArray= #('St\''ephane').
	self assert: (authors at: 2) lastNames asArray = #('Ducasse').
]

{ #category : #tests }
BibAuthorParserTest >> testAuthorSingle [
	| authorString authors |
	authorString := 'Oscar Nierstrasz'.
	authors :=  BibAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray= #('Oscar').
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz')
]

{ #category : #tests }
BibAuthorParserTest >> testAuthorSingleNoFirstName [
	| authorString authors |
	authorString := ' Nierstrasz'.
	authors := BibAuthorParser parse: authorString.
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz')
]

{ #category : #tests }
BibAuthorParserTest >> testLongParticleName [
	| authorString author |
	authorString := 'Charles Louis Xavier Joseph de la Vallée Poussin'.
	author :=  (BibAuthorParser parse: authorString) first.
	self assert: author firstNames asArray = #('Charles' 'Louis' 'Xavier' 'Joseph').
	self assert: author lastNames asArray = #('Vallée' 'Poussin').
	self assert: author particles asArray = #('de' 'la')
]

{ #category : #tests }
BibAuthorParserTest >> testMultiParticleName [
	| authorString author |
	authorString := 'Théodule du Cellier de Lagrange'.
	author :=  (BibAuthorParser parse: authorString) first.
	self assert: author firstNames asArray = #('Théodule').
	self assert: author lastNames asArray = #('Cellier' 'de' 'Lagrange').
	self assert: author particles asArray = #('du')
]

{ #category : #tests }
BibAuthorParserTest >> testTwoAuthors [
	| authorString authors |
	authorString := 'Oscar Nierstrasz and St\''ephane Ducasse'.
	authors :=  BibAuthorParser parse: authorString.
	self assert: (authors at: 1) firstNames asArray= #('Oscar').
	self assert: (authors at: 1) lastNames asArray = #('Nierstrasz').
	self assert: (authors at: 2) firstNames asArray= #('St\''ephane').
	self assert: (authors at: 2) lastNames asArray = #('Ducasse').
]
