Class {
	#name : #CZDuplicateIdentifierTest,
	#superclass : #TestCase,
	#category : #'Citezen-Tests'
}

{ #category : #data }
CZDuplicateIdentifierTest >> entriesThatShouldTakePrecedence [

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
  Url	       = {http://rmod.lille.inria.fr/archive/papers/Denk08bMetaContextLNBIP.pdf},
  Title	       = {The Meta in Meta-object Architectures},
  hal          = {inria-00271286,p56w09p},
  Year	       = {2008}
}

@inproceedings{Denk08d,
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
') 
]

{ #category : #data }
CZDuplicateIdentifierTest >> entriesWithInternalDuplicatesBasedOnTitle [

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
  Year	       = {2008}
}

@inproceedings{Denk08c,
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

@article{Duca10a,
author = {St\''ephane Ducasse and Damien Pollet},
title = {Fingerprints},
journal = {Journal of Information System},
year = 2010
}

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


@article{Duca10a,
author = {St\''ephane Ducasse and Damien Pollet},
title = {Fingerprints},
journal = {Journal of Information System},
  Url	       = {obsoleteData.pdf},
year = 2010
}


'
)  
]

{ #category : #data }
CZDuplicateIdentifierTest >> entriesWithInternalKeyBasedDuplicates [

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
  Year	       = {2008}
}

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

@article{Duca10a,
author = {St\''ephane Ducasse and Damien Pollet},
title = {Fingerprints},
journal = {Journal of Information System},
year = 2010
}

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


@article{Duca10a,
author = {St\''ephane Ducasse and Damien Pollet},
title = {Fingerprints},
journal = {Journal of Information System},
  Url	       = {obsoleteData.pdf},
year = 2010
}

'

) 
]

{ #category : #test }
CZDuplicateIdentifierTest >> testIdentifyDuplicate [
	"self debug: #testIdentifyDuplicate"
	
	| dup newBibset |
	dup := CZDuplicateIdentifier new.
	newBibset := (dup withoutInternalKeyDuplicates: self entriesWithInternalKeyBasedDuplicates).
	self assert: (newBibset size = 3).
	self assert: dup keyBasedDuplicates size = 2.
]

{ #category : #test }
CZDuplicateIdentifierTest >> testIdentifyDuplicateBasedOnTitle [
	"self debug: #testIdentifyDuplicateBasedOnTitle"
	
	| dup newBibset |
	dup := CZDuplicateIdentifier new.
	newBibset := (dup withoutInternalTitleDuplicates: self entriesWithInternalDuplicatesBasedOnTitle).
	self assert: (newBibset size = 3).
	self assert: dup keyBasedDuplicates size = 2.
]

{ #category : #test }
CZDuplicateIdentifierTest >> testkeysThatAreInButNotIn [
	"self debug: #testkeysThatAreInButNotIn"
	
	| dup newBibset res |
	dup := CZDuplicateIdentifier new.
	res := dup keysThatAreIn:  self entriesThatShouldTakePrecedence butNotIn: self entriesWithInternalKeyBasedDuplicates.
	self assert: res size = 1.
	self assert: (res includes: #Denk08d).
	
	res := dup keysThatAreIn:   self entriesWithInternalKeyBasedDuplicates butNotIn:  self entriesThatShouldTakePrecedence.
	self assert: res size = 2.
	self assert: (res includes: #Duca10a).
	self assert: (res includes: #Abde08a).
	
	

]
