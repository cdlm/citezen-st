Class {
	#name : #CZBibTeXSingleAuthorDocBuilder,
	#superclass : #CZNewSingleAuthorDocBuilder,
	#category : #'Citezen-Reborn'
}

{ #category : #utils }
CZBibTeXSingleAuthorDocBuilder >> bibtexFileName [

	^ Date today yyyymmdd, 'bibtex.bib'
]

{ #category : #utils }
CZBibTeXSingleAuthorDocBuilder >> fileName [

	^ Date today yyyymmdd, 'bibtex.bib'
]

{ #category : #utils }
CZBibTeXSingleAuthorDocBuilder >> generatorClass [
	^ CZBibTexGenerator 
]
