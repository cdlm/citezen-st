Class {
	#name : #CZBibtexOutputterTest,
	#superclass : #CZOutputterTest,
	#category : #'Citezen-Tests'
}

{ #category : #hooks }
CZBibtexOutputterTest >> rendererClass [
	^ CZBibtexOutputer
]

{ #category : #testing }
CZBibtexOutputterTest >> testArticle [
	super testArticle.
	self assert: result = '@article{Duca10a,
  author = {St\''ephane Ducasse and Damien Pollet},
  title = {Fingerprints},
  journal = {Journal of Information System},
  year = {2010}
}' withUnixLineEndings
]

{ #category : #testing }
CZBibtexOutputterTest >> testLongArticle [
	super testLongArticle.
	self assert: result =  '@inproceedings{Abde08a,
  author = {Hani Abdeen and Ilham Alloui and St\''ephane Ducasse and Damien Pollet and Mathieu Suen},
  title = {Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships},
  aeres = {ACT},
  aeresstatus = {aeres08},
  annote = {internationalconference stefPub},
  booktitle = {European Conference on Software Maintenance and Reengineering (CSMR)},
  inria = {ADAM},
  keywords = {moose-pub},
  location = {Athens, Greece},
  misc = {Acceptance rate: 24/87 = 27\%},
  accepttotal = 87,
  acceptnum = 24,
  pages = {213--222},
  publisher = {IEEE Computer Society Press},
  rate = {27%},
  selectif = {oui},
  url = {http://scg.unibe.ch/archive/external/Abde08a.pdf},
  year = 2008,
  bdsk-url-1 = {http://scg.unibe.ch/archive/external/Abde08a.pdf}
}' withUnixLineEndings
]

{ #category : #testing }
CZBibtexOutputterTest >> testSeveral [
	super testSeveral.
	self assert: result = '@article{Duca10a,
  author = {St\''ephane Ducasse and Damien Pollet},
  title = {Fingerprints},
  journal = {Journal of Information System},
  year = {2010}
}
@inproceedings{Abde08a,
  author = {Hani Abdeen and Ilham Alloui and St\''ephane Ducasse and Damien Pollet and Mathieu Suen},
  title = {Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships},
  aeres = {ACT},
  aeresstatus = {aeres08},
  annote = {internationalconference stefPub},
  booktitle = {European Conference on Software Maintenance and Reengineering (CSMR)},
  inria = {ADAM},
  keywords = {moose-pub},
  location = {Athens, Greece},
  misc = {Acceptance rate: 24/87 = 27\%},
  accepttotal = 87,
  acceptnum = 24,
  pages = {213--222},
  publisher = {IEEE Computer Society Press},
  rate = {27%},
  selectif = {oui},
  url = {http://scg.unibe.ch/archive/external/Abde08a.pdf},
  year = 2008,
  bdsk-url-1 = {http://scg.unibe.ch/archive/external/Abde08a.pdf}
}'  withUnixLineEndings
]
