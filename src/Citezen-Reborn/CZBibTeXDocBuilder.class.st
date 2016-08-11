"
could be a subclass of decorated but should be turned into a strategy.
"
Class {
	#name : #CZBibTeXDocBuilder,
	#superclass : #CZDocBuilder,
	#category : #'Citezen-Reborn-DocumentBuilder'
}

{ #category : #utils }
CZBibTeXDocBuilder >> bibtexFileName [

	^ Date today yyyymmdd, 'bibtex.bib'
]

{ #category : #generate }
CZBibTeXDocBuilder >> extension [
	
	^ '-Regenerated.bib'
]

{ #category : #utils }
CZBibTeXDocBuilder >> fileName [

	^ Date today yyyymmdd, 'bibtex.bib'
]

{ #category : #utils }
CZBibTeXDocBuilder >> generatorClass [
	^ CZBibTexGenerator 
]

{ #category : #initialization }
CZBibTeXDocBuilder >> initialize [

	super initialize.
	self noHeader.
]
