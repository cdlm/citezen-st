Class {
	#name : #CZTextTest,
	#superclass : #CZRendererTest,
	#category : #'Citezen-Tests'
}

{ #category : #'as yet unclassified' }
CZTextTest >> rendererClass [
	^ BibTextRenderer
]

{ #category : #'as yet unclassified' }
CZTextTest >> testArticle [
	"self debug: #testArticle"

	super testArticle.
	self assert: result = 'St\''ephane Ducasse and Damien Pollet. Fingerprints. In Journal of Information System, 2010.

'
]

{ #category : #'as yet unclassified' }
CZTextTest >> testSeveral [
	super testSeveral.
	self assert: result = 'St\''ephane Ducasse and Damien Pollet. Fingerprints. In Journal of Information System, 2010.

St\''ephane Ducasse and Damien Pollet. Fingerprints. In Journal of Information System, 2010.

' 
]
