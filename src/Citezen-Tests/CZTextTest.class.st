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
CZTextTest >> testLongArticle [
	"self debug: #testLongArticle"

	super testLongArticle.
	self assert: result = 'Hani Abdeen, Ilham Alloui, St\''ephane Ducasse, Damien Pollet, and Mathieu Suen. Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships. In European Conference on Software Maintenance and Reengineering (CSMR), p. 213--222, IEEE Computer Society Press, 2008. Acceptance rate: 24/87 = 28%.

' 
]

{ #category : #'as yet unclassified' }
CZTextTest >> testSeveral [
	super testSeveral.
	self assert: result = 'St\''ephane Ducasse and Damien Pollet. Fingerprints. In Journal of Information System, 2010.

Hani Abdeen, Ilham Alloui, St\''ephane Ducasse, Damien Pollet, and Mathieu Suen. Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships. In European Conference on Software Maintenance and Reengineering (CSMR), p. 213--222, IEEE Computer Society Press, 2008. Acceptance rate: 24/87 = 28%.

'
]
