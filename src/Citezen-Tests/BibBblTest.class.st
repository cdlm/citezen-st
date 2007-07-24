Class {
	#name : #BibBblTest,
	#superclass : #BibRendererTest,
	#instVars : [
		'phrase'
	],
	#category : #'Citezen-Tests'
}

{ #category : #setup }
BibBblTest >> rendererClass [
	^ BibBblRenderer
]

{ #category : #testing }
BibBblTest >> testArticle [
	super testArticle.
	self assert: result = '\bibitem[displayKey]{foobar}
A. 
\newblock T. 
\newblock In J, Y.

'
]

{ #category : #testing }
BibBblTest >> testSeveral [
	super testSeveral.
	self assert: result = '\bibitem[displayKey]{foobar}
A. 
\newblock T. 
\newblock In J, Y.

\bibitem[displayKey]{foobar}
A. 
\newblock T. 
\newblock In J, Y.

'
]
