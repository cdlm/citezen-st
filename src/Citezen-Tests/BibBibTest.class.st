Class {
	#name : #BibBibTest,
	#superclass : #BibRendererTest,
	#instVars : [
		'phrase'
	],
	#category : #'Citezen-Tests'
}

{ #category : #setup }
BibBibTest >> rendererClass [
	^ BibBibRenderer
]

{ #category : #testing }
BibBibTest >> testArticle [
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
BibBibTest >> testSeveral [
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
