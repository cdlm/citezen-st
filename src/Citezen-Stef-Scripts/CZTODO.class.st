"
notExpanded either returns a string or integer

* gatherer from a doc to a bibset should add tests
* bibraw printer -> test
* added bibfield selection in Outputter
* generatingCollection -> generatedCollection?

* requestBib???
* CZOutputer should be subclass of CZDocumentVisitor

* should check that   - BibTeX -> '@comment{Here is my comment}' is a valid entry.  probably it is.
* introduce setter for used fields (replace field at: #author but field author: 
* introduce key: as instance creation for entry
	instead of (CZentry type: #article) key:
			or (CZentry type: CZEntry article) key:
	-> CZEntry typeArticle key: 
	
* stef footer/header
* script to split author and nonauthors
* rmod report
* do not use copyTwoLevel 
* there is a redundancy between 
	CZEntry initialize and CZChecker>>initializeTypeFieldsMatching

Rewrite 
	[ :fields | | ret |
			ret := true.
			#(author title journal year) do: [ :each |
				(fields includes: each) 
					ifFalse: [ ret := false ] ]. 
			ret ];
	probably using anySatisfy	
		
types
	^ #(article book booklet conference inbook incollection inproceedings manual mastersthesis misc phdthesis proceedings techreport unpublished)
could be inferred from the class list of the methods			
	
"
Class {
	#name : #CZTODO,
	#superclass : #Object,
	#category : #'Citezen-Stef-Scripts'
}