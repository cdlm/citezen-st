Class {
	#name : #CZBibTest,
	#superclass : #CZRendererTest,
	#category : #'Citezen-Tests'
}

{ #category : #setup }
CZBibTest >> rendererClass [
	^ BibBibRenderer
]

{ #category : #testing }
CZBibTest >> testArticle [
	super testArticle.
	self assert: result = '@article{Duca10a,
author = {St\''ephane Ducasse and Damien Pollet},
title = {Fingerprints},
journal = {Journal of Information System},
year = 2010
}

'
]

{ #category : #testing }
CZBibTest >> testSeveral [
	super testSeveral.
	self assert: result = '@article{Duca10a,
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
year = 2008
acceptnum = {24},
accepttotal = {87},
28}

' 
]
