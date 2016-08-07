"
testing the builder
"
Class {
	#name : #CZDocBuilderTest,
	#superclass : #TestCase,
	#instVars : [
		'bibset'
	],
	#category : #'Citezen-Reborn-DocumentBuilder'
}

{ #category : #'examples for tests' }
CZDocBuilderTest class >> Abde08a [
	"self  Abde08a"
^
(CZBibParser parse: 
'
@inproceedings{Abde08a,
author = {Hani Abdeen and Ilham Alloui and St\''ephane Ducasse and Damien Pollet and Mathieu Suen},
title = {Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships},
booktitle = {European Conference on Software Maintenance and Reengineering (CSMR)},
pages = {213--222},
publisher = {IEEE Computer Society Press},
year = 2008,
acceptnum = {24},
accepttotal = {87}
}

'
)  
]

{ #category : #'examples for tests' }
CZDocBuilderTest class >> Abde10a [
	"self  Abde10a"
^
(CZBibParser parse: 
'@article{Abde10a,
	Aeres = {ACL},
	Aeresstatus = {aeres12},
	Annote = {internationaljournal},
	Author = {Hani Abdeen and St\''ephane Ducasse and Damien Pollet and Ilham Alloui},
	Doi = {10.1016/j.infsof.2010.07.005},
	Hal-Id = {inria-00531496},
	Impactfactor = {ISI impact factor 1.821 (2010)},
	Inria = {RMOD},
	Inriareport = {2010},
	Journal = {Information and Software Technology Journal},
	Keywords = {moose remoose2 lse-pub cook kzVisualisation},
	Pages = {1312-1330},
	Secondurl = {http://rmod.lille.inria.fr/archives/papers/Abde10a-IST-packageFingerprints.pdf},
	Title = {Package Fingerprint: a visual summary of package interfaces and relationships},
	Url = {http://rmod.lille.inria.fr/archives/papers/Abde10a-IST-Official-packageFingerprints.pdf},
	Volume = {52},
	X-Editorial-Board = {yes},
	X-International-Audience = {yes},
	X-Proceedings = {yes},
	Year = 2010,
	Bdsk-Url-1 = {http://rmod.lille.inria.fr/archives/papers/Abde10a-IST-Official-packageFingerprints.pdf},
	Bdsk-Url-2 = {http://dx.doi.org/10.1016/j.infsof.2010.07.005}}

'
)  
]

{ #category : #'examples for tests' }
CZDocBuilderTest class >> Chev11a [
	"self  Chev11a"
^
(CZBibParser parse: 
'
@inproceedings{Chev11a,
	author = {Chevalier-Boisvert, Maxime and Lavoie, Erick and Feeley, Marc and Dufour, Bruno},
	booktitle = {Dynamic Language Symposium},
	title = {Bootstrapping a Self-Hosted Research Virtual Machine for JavaScript},
	year = 2011
}
'
)  
]

{ #category : #'examples for tests' }
CZDocBuilderTest class >> Denk08b [
	"self  Denk08b"
^
(CZBibParser parse: 
'@inproceedings{Denk08b,
  Annote       = {internationalconference},
  Author       = {Marcus Denker and Mathieu Suen and St\''ephane
                  Ducasse},
  Booktitle    = {Proceedings of TOOLS EUROPE 2008},
  peer	       = {yes},
  pages	       = {218--237},
  aeres	       = {ACT},
  aeresstatus  = {aeres12},
  inria	       = {RMOD},
  selectif     = {non},
  ISSN	       = {1865-1348},
  Keywords     = {scg-pub jb08 fb08 snf08 reflectivity},
  labo 		= {dans},
  Publisher    = {Springer-Verlag},
  Series       = {LNBIP},
  Volume       = 11,
  Doi	       = {10.1007/978-3-540-69824-1_13},
  Url	       = {http://scg.unibe.ch/archive/papers/Denk08bMetaContextLNBIP.pdf},
  Title	       = {The Meta in Meta-object Architectures},
  hal          = {inria-00271286,p56w09p},
  Year	       = 2008
}
'
)  
]

{ #category : #'examples for tests' }
CZDocBuilderTest class >> Duca10a [
	"self  Duca10a"
^
(CZBibParser parse: 
'
@article{Duca10a,
author = {St\''ephane Ducasse and Damien Pollet},
keywords = {insubmission},
title = {Fingerprints},
journal = {Journal of Information System},
year = {2010}
}

'
)  
]

{ #category : #'examples for tests' }
CZDocBuilderTest class >> Duca12a [
	"self  Duca12a"
^
(CZBibParser parse: 
'

@article{Duca12a,
     author = {St\''ephane Ducasse and Zork Ranger},
	annote = {internationaljournal},
     title = {Woa},
     journal = {Journal of Information System},
     Url	       = {obsoleteData.pdf},
     year = 2010
}

'
)  
]

{ #category : #'examples for tests' }
CZDocBuilderTest class >> aDoc [

	^ (CZSingleAuthorDocBuilder new 
					bibset: self someArticles;
					authorMatchingString: '*S*Ducasse*';
					noHeader;
					build;
					document)
]

{ #category : #'examples for tests' }
CZDocBuilderTest class >> someArticles [
	"self  someArticles"
^
(CZBibParser parse: 
'@article{Abde10a,
	Aeres = {ACL},
	Aeresstatus = {aeres12},
	Annote = {internationaljournal},
	Author = {Hani Abdeen and St\''ephane Ducasse and Damien Pollet and Ilham Alloui},
	Doi = {10.1016/j.infsof.2010.07.005},
	Hal-Id = {inria-00531496},
	Impactfactor = {ISI impact factor 1.821 (2010)},
	Inria = {RMOD},
	Inriareport = {2010},
	Journal = {Information and Software Technology Journal},
	Keywords = {moose remoose2 lse-pub cook kzVisualisation},
	Pages = {1312-1330},
	Secondurl = {http://rmod.lille.inria.fr/archives/papers/Abde10a-IST-packageFingerprints.pdf},
	Title = {Package Fingerprint: a visual summary of package interfaces and relationships},
	Url = {http://rmod.lille.inria.fr/archives/papers/Abde10a-IST-Official-packageFingerprints.pdf},
	Volume = {52},
	X-Editorial-Board = {yes},
	X-International-Audience = {yes},
	X-Proceedings = {yes},
	Year = {2010},
	Bdsk-Url-1 = {http://rmod.lille.inria.fr/archives/papers/Abde10a-IST-Official-packageFingerprints.pdf},
	Bdsk-Url-2 = {http://dx.doi.org/10.1016/j.infsof.2010.07.005}}


@inproceedings{Denk08b,
  Annote       = {internationalconference},
  Author       = {Marcus Denker and Mathieu Suen and St\''ephane
                  Ducasse},
  Booktitle    = {Proceedings of TOOLS EUROPE 2008},
  peer	       = {yes},
  pages	       = {218--237},
  aeres	       = {ACT},
  aeresstatus  = {aeres12},
  inria	       = {RMOD},
  selectif     = {non},
  ISSN	       = {1865-1348},
  Keywords     = {scg-pub jb08 fb08 snf08 reflectivity},
  labo 		= {dans},
  Publisher    = {Springer-Verlag},
  Series       = {LNBIP},
  Volume       = 11,
  Doi	       = {10.1007/978-3-540-69824-1_13},
  Url	       = {http://scg.unibe.ch/archive/papers/Denk08bMetaContextLNBIP.pdf},
  Title	       = {The Meta in Meta-object Architectures},
  hal          = {inria-00271286,p56w09p},
  Year	       = {2008}
}

@inproceedings{Chev11a,
	author = {Chevalier-Boisvert, Maxime and Lavoie, Erick and Feeley, Marc and Dufour, Bruno},
	booktitle = {Dynamic Language Symposium},
	title = {Bootstrapping a Self-Hosted Research Virtual Machine for JavaScript},
	year = {2011}
}

@article{Duca10a,
author = {St\''ephane Ducasse and Damien Pollet},
keywords = {insubmission},
title = {Fingerprints},
journal = {Journal of Information System},
year = {2010}
}

@inproceedings{Abde08a,
author = {Hani Abdeen and Ilham Alloui and St\''ephane Ducasse and Damien Pollet and Mathieu Suen},
title = {Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships},
booktitle = {European Conference on Software Maintenance and Reengineering (CSMR)},
pages = {213--222},
publisher = {IEEE Computer Society Press},
year = {2008},
acceptnum = {24},
accepttotal = {87}
}


@article{Duca12a,
     author = {St\''ephane Ducasse and Zork Ranger},
	annote = {internationaljournal},
     title = {Woa},
     journal = {Journal of Information System},
     Url	       = {obsoleteData.pdf},
     year = {2010}
}

'
)  
]

{ #category : #setUp }
CZDocBuilderTest >> setUp [

	bibset := self someArticles.
]

{ #category : #setUp }
CZDocBuilderTest >> someArticles [
	"self new someArticles"
	^ self class someArticles 
]

{ #category : #tests }
CZDocBuilderTest >> testAnEmptyDocumentWithATitleHasJustOneElement [
	"self  debug: #testAnEmptyDocumentWithATitleHasJustOneElement"
	
	| builder |
	builder := CZDocBuilder new bibset: bibset.
	builder addTitle: CZTitle new.
	builder document.
	self assert: builder document elements size = 1
]

{ #category : #tests }
CZDocBuilderTest >> testAuthorMatchingSelectEntryWithCorrespondingAuthor [
	"self debug: #testWithAuthor"
	
	| builder |
	builder := CZDocBuilder new 
					authorMatchingString: '*S*Ducasse*';
					bibset: bibset.
	self assert: builder workingBibSet size = 6.				
	self assert: ( builder workingBibSet select: builder authorQuery) size = 5
]

{ #category : #tests }
CZDocBuilderTest >> testBlackListedEntriesAlsoFiltersInSubmission [
	"self debug: #testBlackListedEntriesAlsoFiltersInSubmission"
	"it could be orthogonal but for now this is not the case."
	
	| builder |
	builder := CZDocBuilder new bibset: bibset.
	"filtering not invoked"				
	self assert: builder workingBibSet size = 6.		
	
	"now testing that we removed the keys we do not want"	
	builder keysOfBlackListedEntries: #(Abde10a Chev11a).
	builder filter.
	self assert: builder workingBibSet size = 3.	
]

{ #category : #tests }
CZDocBuilderTest >> testInSubmissionPublicationAreRemovedWhenFilteringIsOn [
	"self debug: #testBlackListedEntries"
	
	| builder |
	builder := CZDocBuilder new bibset: bibset.
	"filtering not invoked"				
	self assert: builder workingBibSet size = 6.		
			
	"now testing that we remove the insubmission"				
	builder setFilteringOn.
	builder filter.
	self assert: builder workingBibSet size = 5.		
	
	
]

{ #category : #tests }
CZDocBuilderTest >> testSelectingJournalEffectivelyReturnsOnlyJournals [
	"self debug: #testSelectingJournalEffectivelyReturnsOnlyJournals"

	| builder |
	builder := CZDocBuilder new bibset: bibset.
	self assert: builder workingBibSet size = 6.
	self assert: (builder workingBibSet select: builder internationalJournalQuery) size = 2
]
