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
	"This one fails because the WACanvas has changed and it's a pain to make a stateful renderer.
	IMHO the renderers should switch to renderOn: like in Seaside, rather than creation + just render"
	super testSeveral.
	self assert: result = '<a name="foobar"></a><span class="article"><span class="author">A</span>. <span class="title">T</span>. <span class="publishing">In J, 4</span>.</span><a name="foobar"></a><span class="article"><span class="author">A</span>. <span class="title">T</span>. <span class="publishing">In J, 4</span>.</span>'
]
