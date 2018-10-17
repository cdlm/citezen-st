"
could be a subclass of decorated but should be turned into a strategy.
"
Class {
	#name : #CZBibTeXDocBuilder,
	#superclass : #CZBodyDocBuilder,
	#category : 'Citezen-Reborn-DocumentBuilder'
}

{ #category : #utils }
CZBibTeXDocBuilder >> bibtexFileName [

	^ Date today yyyymmdd, 'bibtex.bib'
]

{ #category : #'public API' }
CZBibTeXDocBuilder >> buildBody [
	
	| allSelectedEntries |
	allSelectedEntries := CZSet new.
	self bodySpecification
		do: [ :each |  
				allSelectedEntries addAll: (workingBibSet select: (self perform: (each, #Query) asSymbol))  
				].
	allSelectedEntries sortByAuthor.
	self addElement: allSelectedEntries.
					
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
