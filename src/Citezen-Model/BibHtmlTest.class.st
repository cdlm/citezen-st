Class {
	#name : #BibHtmlTest,
	#superclass : #BibRendererTest,
	#category : 'Citezen-Tests'
}

{ #category : #setup }
BibHtmlTest >> rendererClass [
	^ BibHtmlRenderer
]

{ #category : #testing }
BibHtmlTest >> testArticle [
	super testArticle.
	self assert: result = '<div class="article"><div class="author">A</div>. <div class="title">T</div>. <div class="publishing">In J, Y</div>.</div>'
]

{ #category : #testing }
BibHtmlTest >> testSeveral [
	super testSeveral.
	self assert: result = '<div class="article"><div class="author">A</div>. <div class="title">T</div>. <div class="publishing">In J, Y</div>.</div><div class="article"><div class="author">A</div>. <div class="title">T</div>. <div class="publishing">In J, Y</div>.</div>'
]
