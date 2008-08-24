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
	super testArticle.
	self assert: result = 'A. T. In J, 4.

'
]

{ #category : #'as yet unclassified' }
CZTextTest >> testSeveral [
	super testSeveral.
	self assert: result = 'A. T. In J, 4.

A. T. In J, 4.

'
]
