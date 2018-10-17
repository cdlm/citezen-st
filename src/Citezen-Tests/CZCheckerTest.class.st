Class {
	#name : #CZCheckerTest,
	#superclass : #TestCase,
	#category : 'Citezen-Tests'
}

{ #category : #'as yet unclassified' }
CZCheckerTest >> brokenTeamEntry [
^
(CZBibParser parse: 
'@inproceedings{badkey,
  Author       = {Marcus Denker and Mathieu Suen and St\''ephane
                  Ducasse},
  Booktitle    = {Proceedings of TOOLS EUROPE 2008},
  peer	       = {yes},
  pages	       = {218--237},
  ISSN	       = {1865-1348},
  Keywords     = {scg-pub jb08 fb08 snf08 reflectivity},
  Publisher    = {Springer-Verlag},
  Series       = {LNBIP},
  Volume       = 11,
  Doi	       = {10.1007/978-3-540-69824-1_13},
  Url	       = {http://scg.unibe.ch/archive/papers/Denk08bMetaContextLNBIP.pdf},
  Title	       = {The Meta in Meta-object Architectures},
  hal          = {inria-00271286,p56w09p},
  Year	       = {2008}
}') entries first
]

{ #category : #'as yet unclassified' }
CZCheckerTest >> notTeamEntry [
^
(CZBibParser parse: 
'@article{Desm08a,
	author = {Desmet, Lieven and Verbaeten, Petrus and Joosen, Wouter and Piessens, Frank},
	title = {Provable protection against web application vulnerabilities related to session data dependencies},
	journal = {IEEE transactions on software engineering},
	year = {2008},
	month = jan,
	volume = {34},
	number = {1},
	pages = {50--64},
	url = {https://lirias.kuleuven.be/handle/123456789/161855},
	doi = {10.1109/TSE.2007.70742},
	issn = {0098-5589}
}') entries first
]

{ #category : #'as yet unclassified' }
CZCheckerTest >> teamEntry [
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
}') entries first
]

{ #category : #'as yet unclassified' }
CZCheckerTest >> testAeresClassificationRule [
	self assert: (CZRmodAeresClassificationRule new check: self teamEntry).
	self deny: (CZRmodAeresClassificationRule new check: self brokenTeamEntry)
]

{ #category : #'as yet unclassified' }
CZCheckerTest >> testAeresStatusRule [
	self assert: (CZRmodAeresStatusRule new check: self teamEntry).
	self deny: (CZRmodAeresStatusRule new check: self brokenTeamEntry)
]

{ #category : #'as yet unclassified' }
CZCheckerTest >> testAnnoteRule [
	self assert: (CZRmodAnnoteRule new check: self teamEntry).
	self deny: (CZRmodAnnoteRule new check: self brokenTeamEntry)
]

{ #category : #'as yet unclassified' }
CZCheckerTest >> testInriaRmodRule [
	self assert: (CZRmodInriaRmodRule new check: self teamEntry).
	self deny: (CZRmodInriaRmodRule new check: self brokenTeamEntry)
]

{ #category : #'as yet unclassified' }
CZCheckerTest >> testIsWrittenByRModMember [
	| entry |
	entry := (CZBibParser parse: '@misc{key, author={Ducasse, Stephane}}') entries at: 1.
	self assert: (CZChecker isWrittenByRModMember: entry).
	entry := (CZBibParser parse: '@misc{key, author={The, Cat}}') entries at: 1.
	self deny: (CZChecker isWrittenByRModMember: entry)
]

{ #category : #'as yet unclassified' }
CZCheckerTest >> testKeyRule [
	self assert: (CZRmodKeyRule new check: self teamEntry).
	self deny: (CZRmodKeyRule new check: self brokenTeamEntry)
]

{ #category : #'as yet unclassified' }
CZCheckerTest >> testKeywordLsePubRule [
	| checker entry |
	checker := CZChecker new addRule: CZRmodKeywordLsePubRule new.
	
	entry := self brokenTeamEntry.
	checker checkEntry: entry.
	
	self assert:  ((entry at: #keyword) value = 'lse-pub').
	
	entry at: #keyword put: 'aKeyWord'.
	checker checkEntry: entry.
	
	self assert:  ((entry at: #keyword) value = 'aKeyWord lse-pub').
]

{ #category : #'as yet unclassified' }
CZCheckerTest >> testSelectifRule [
	self assert: (CZRmodSelectifRule new check: self teamEntry).
	self deny: (CZRmodSelectifRule new check: self brokenTeamEntry)
]

{ #category : #'as yet unclassified' }
CZCheckerTest >> testlaboRule [
	self assert: (CZRmodLaboRule new check: self teamEntry).
	self deny: (CZRmodLaboRule new check: self brokenTeamEntry)
]
