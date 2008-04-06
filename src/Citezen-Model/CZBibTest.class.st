Class {
	#name : #CZBibTest,
	#superclass : #CZRendererTest,
	#category : #'Citezen-Tests'
}

{ #category : #setup }
CZBibTest >> rendererClass [
	^ BibBibRenderer
]

{ #category : #testing }
CZBibTest >> testArticle [
	super testArticle.
	self assert: result = '@article(foobar,
author = {A},
title = {T},
journal = {J},
year = Y
)

'
]

{ #category : #testing }
CZBibTest >> testSeveral [
	super testSeveral.
	self assert: result = '@article(foobar,
author = {A},
title = {T},
journal = {J},
year = Y
)

@article(foobar,
author = {A},
title = {T},
journal = {J},
year = Y
)

'
]
