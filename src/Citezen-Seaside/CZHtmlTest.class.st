Class {
	#name : #CZHtmlTest,
	#superclass : #CZRendererTest,
	#category : #'Citezen-Seaside'
}

{ #category : #testing }
CZHtmlTest >> expectedFailures [

	^ #(testSeveral)
	
]

{ #category : #setup }
CZHtmlTest >> rendererClass [
	^ CZHtmlRenderer
]

{ #category : #testing }
CZHtmlTest >> testArticle [
	super testArticle.
	self assert: result = '<a name="Duca10a"></a><span class="article"><span class="author">St&eacute;phane Ducasse and Damien Pollet</span>. <span class="title">Fingerprints</span>. <span class="publishing">In Journal of Information System, 2010</span>.</span>' 
]

{ #category : #testing }
CZHtmlTest >> testLongArticle [
	super testLongArticle.
	self assert: result = '<a name="Abde08a"></a><span class="inproceedings"><span class="author">Hani Abdeen, Ilham Alloui, St&eacute;phane Ducasse, Damien Pollet, and Mathieu Suen</span>. <span class="title"><a href="http://scg.unibe.ch/archive/external/Abde08a.pdf">Package Reference Fingerprint: a Rich and Compact Visualization to Understand Package Relationships</a></span>. <span class="publishing">In European Conference on Software Maintenance and Reengineering (CSMR), p. 213&ndash;222, IEEE Computer Society Press, 2008</span>. Acceptance rate: 24/87 = 28%.</span>'
]

{ #category : #testing }
CZHtmlTest >> testSeveral [
	"This one fails because the WACanvas has changed and it's a pain to make a stateful renderer.
	IMHO the renderers should switch to renderOn: like in Seaside, rather than creation + just render"
	super testSeveral.
	self assert: result = '<a name="Duca10a"></a><span class="article"><span class="author">St&eacute;phane Ducasse and Damien Pollet</span>. <span class="title">Fingerprints</span>. <span class="publishing">In Journal of Information System, 2010</span>.</span>' 
]
