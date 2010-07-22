Class {
	#name : #CZBblTest,
	#superclass : #CZRendererTest,
	#category : #'Citezen-Tests'
}

{ #category : #setup }
CZBblTest >> rendererClass [
	^ BibBblRenderer
]

{ #category : #testing }
CZBblTest >> testArticle [
	super testArticle.
	self assert: result = '\bibitem[displayKey]{Duca10a}
St\''ephane Ducasse and Damien Pollet. 
\newblock Fingerprints. 
\newblock In Journal of Information System, 2010.

' 
]

{ #category : #testing }
CZBblTest >> testSeveral [
	super testSeveral.
	self assert: result = '\bibitem[displayKey]{Duca10a}
St\''ephane Ducasse and Damien Pollet. 
\newblock Fingerprints. 
\newblock In Journal of Information System, 2010.

\bibitem[displayKey]{Duca10a}
St\''ephane Ducasse and Damien Pollet. 
\newblock Fingerprints. 
\newblock In Journal of Information System, 2010.

' 
]
