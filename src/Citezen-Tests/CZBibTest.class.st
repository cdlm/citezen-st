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

@article{Duca10a,
author = {Ducasse, St\''ephane  and Pollet, Damien},
title = {Fingerprints},
journal = {Journal of Information System},
year = 2010
}

' 
]
