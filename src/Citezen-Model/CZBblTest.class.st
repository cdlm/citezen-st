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
	self assert: result = '\bibitem[displayKey]{foobar}
A. 
\newblock T. 
\newblock In J, 4.

'
]

{ #category : #testing }
CZBblTest >> testSeveral [
	super testSeveral.
	self assert: result = '\bibitem[displayKey]{foobar}
A. 
\newblock T. 
\newblock In J, 4.

\bibitem[displayKey]{foobar}
A. 
\newblock T. 
\newblock In J, 4.

'
]
