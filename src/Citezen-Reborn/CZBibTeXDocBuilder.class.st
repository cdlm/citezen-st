"
To convert back a document into a bib file.
"
Class {
	#name : #CZBibTeXDocBuilder,
	#superclass : #CZDecoratedDocBuilder,
	#category : #'Citezen-Reborn-DocumentBuilder'
}

{ #category : #utils }
CZBibTeXDocBuilder >> bibtexFileName [

	^ Date today yyyymmdd, 'bibtex.bib'
]

{ #category : #generate }
CZBibTeXDocBuilder >> extension [
	
	^ '-Full.bib'
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
