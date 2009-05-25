Class {
	#name : #CZHtmlTest,
	#superclass : #CZRendererTest,
	#category : #'Citezen-Seaside'
}

{ #category : #setup }
CZHtmlTest >> rendererClass [
	^ CZHtmlRenderer
]

{ #category : #testing }
CZHtmlTest >> testArticle [
	super testArticle.
	self assert: result = '<a name="foobar"></a><span class="article"><span class="author">A</span>. <span class="title">T</span>. <span class="publishing">In J, 4</span>.</span>'
]

{ #category : #testing }
CZHtmlTest >> testSeveral [
	super testSeveral.
	self assert: result = '<a name="foobar"></a><span class="article"><span class="author">A</span>. <span class="title">T</span>. <span class="publishing">In J, 4</span>.</span><a name="foobar"></a><span class="article"><span class="author">A</span>. <span class="title">T</span>. <span class="publishing">In J, 4</span>.</span>'
]
