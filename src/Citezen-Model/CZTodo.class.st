"
* apparently editor field does not contain people.


we should add the fact that if a document is given a pattern for entries then all the entries get displayed
using potentially in all the scripts associated to the document.


notExpanded either returns a string or integer

* how can we filter a list of entries out that fullfils a criteria

* gatherer from a doc to a bibset should add tests
* bibraw printer -> test
* add test for CZSet , 

* generatingCollection -> generatedCollection?
* requestBib???
* CZOutputer should be subclass of CZDocumentVisitor ?

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
		
		Should use SharedPool
			
	
"
Class {
	#name : #CZTodo,
	#superclass : #Object,
	#category : 'Citezen-Model'
}
