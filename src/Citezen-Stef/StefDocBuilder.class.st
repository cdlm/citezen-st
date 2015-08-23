Class {
	#name : #StefDocBuilder,
	#superclass : #Object,
	#category : #'Citezen-Stef'
}

{ #category : #hackish }
StefDocBuilder >> generate [
	"self new generate"
	self latexBuilder.
	self xhtmlBuilder.
	
]

{ #category : #hackish }
StefDocBuilder >> latexBuilder [
	| builder |
	builder := CZLaTeXDocBuilder new
		fileNamed: 'rmod.bib';
		authorMatchingString: '*Ducasse*';
		french; 
		fieldOrder: #(#author 
			  #title 
			  #journal 
			  #booktitle 
			  #volume 
			  #pages 
			  #publisher  
			  #year 
			  #school
			  #impactfactor 
			  #misc); "removed doi and url since they may contain _ and the generator does not handle that well for the moment."
		setFilteringOn.
	builder generate.	
]

{ #category : #hackish }
StefDocBuilder >> xhtmlBuilder [
	"self new xhtmlBuilder"

	| builder |
	builder := CZXHTMLDocBuilder new
		fileNamed: 'rmod.bib';
		authorMatchingString: '*Ducasse*';
		french; 
		fieldOrder: #(#author 
			  #title 
			  #journal 
			  #booktitle 
			  #volume 
			  #pages 
			  #publisher  
			  #year 
			  #school
			  #impactfactor 
			  #misc
			  #url
			  #doi); "removed doi and url since they may contain _ and the generator does not handle that well for the moment."
		setFilteringOn.
	builder generate.	
]
