Class {
	#name : #CZLaTeXOutputerTest,
	#superclass : #CZOutputterTest,
	#category : #'Citezen-Tests'
}

{ #category : #'as yet unclassified' }
CZLaTeXOutputerTest >> rendererClass [
	^ CZLaTeXOutputer
]

{ #category : #'as yet unclassified' }
CZLaTeXOutputerTest >> testArticle [
	"self debug: #testArticle"
	
	super testArticle.
	
	self assert: result = '\pub S. Ducasse and D. Pollet,
 \emph{Fingerprints},
 In \emph{Journal of Information System},
2010' withUnixLineEndings
]

{ #category : #'as yet unclassified' }
CZLaTeXOutputerTest >> testLongArticle [
	super testLongArticle.
	self assert: result = ''
]

{ #category : #'as yet unclassified' }
CZLaTeXOutputerTest >> testSeveral [
	super testSeveral.
	self assert: result = ''
]
