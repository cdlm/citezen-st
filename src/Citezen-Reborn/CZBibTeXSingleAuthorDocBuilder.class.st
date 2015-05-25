Class {
	#name : #CZBibTeXSingleAuthorDocBuilder,
	#superclass : #CZDecoratedDocBuilder,
	#category : #'Citezen-Reborn'
}

{ #category : #utils }
CZBibTeXSingleAuthorDocBuilder >> bibtexFileName [

	^ Date today yyyymmdd, 'bibtex.bib'
]

{ #category : #'as yet unclassified' }
CZBibTeXSingleAuthorDocBuilder >> extension [
	
	^ '-Full.bib'
]

{ #category : #utils }
CZBibTeXSingleAuthorDocBuilder >> fileName [

	^ Date today yyyymmdd, 'bibtex.bib'
]

{ #category : #utils }
CZBibTeXSingleAuthorDocBuilder >> generatorClass [
	^ CZBibTexGenerator 
]
