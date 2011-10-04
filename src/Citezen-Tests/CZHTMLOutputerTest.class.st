Class {
	#name : #CZHTMLOutputerTest,
	#superclass : #CZOutputterTest,
	#category : #'Citezen-Tests'
}

{ #category : #hooks }
CZHTMLOutputerTest >> rendererClass [
	^ CZHtmlOutputer
]

{ #category : #hooks }
CZHTMLOutputerTest >> testLongArticle [
	"self debug: #testLongArticle"
	super testLongArticle.
	self assert: result = ''
]
