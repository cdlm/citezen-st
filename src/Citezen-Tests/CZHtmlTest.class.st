Class {
	#name : #CZHtmlTest,
	#superclass : #CZRendererTest,
	#category : #'Citezen-Tests'
}

{ #category : #setup }
CZHtmlTest >> rendererClass [
	^ CZHtmlRenderer
]

{ #category : #testing }
CZHtmlTest >> testArticle [
	super testArticle.
	self assert: result = '<span class="article"><div class="author">A</div>. <div class="title">T</div>. <div class="publishing">In J, 4</div>.</span>'
]

{ #category : #testing }
CZHtmlTest >> testSeveral [
	super testSeveral.
	self assert: result = '<span class="article"><div class="author">A</div>. <div class="title">T</div>. <div class="publishing">In J, 4</div>.</span><span class="article"><div class="author">A</div>. <div class="title">T</div>. <div class="publishing">In J, 4</div>.</span>'
]
