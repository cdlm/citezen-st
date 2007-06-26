Class {
	#name : #BibHtmlTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'phrase',
		'renderer'
	],
	#category : #'Citezen-Tests'
}

{ #category : #setup }
BibHtmlTest >> setUp [
	entry := (BibEntry type: #article)
		key: #foobar;
		at: #author put: 'A';
		at: #title put: 'T';
		at: #journal put: 'J';
		at: #year put: 'Y';
		yourself.
	phrase := BibPhraseLibrary article.
	renderer := (BibHtmlRenderer on: (WAStaticHtmlCanvas root: WAHtmlRoot new))
]

{ #category : #testing }
BibHtmlTest >> testArticle [
	renderer render: phrase for: entry.
	self assert: renderer contents = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head><title>Seaside</title><meta content="text/html; charset=utf-8" http-equiv="Content-Type" /></head><body><div class="article"><div class="author">A</div>. <div class="title">T</div>. <div class="publishing">In J, Y</div>.</div>'
]

{ #category : #testing }
BibHtmlTest >> testSeveral [
	renderer render: phrase for: entry.
	renderer render: phrase for: entry.
	self assert: renderer contents = '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"><html lang="en" xml:lang="en" xmlns="http://www.w3.org/1999/xhtml"><head><title>Seaside</title><meta content="text/html; charset=utf-8" http-equiv="Content-Type" /></head><body><div class="article"><div class="author">A</div>. <div class="title">T</div>. <div class="publishing">In J, Y</div>.</div><div class="article"><div class="author">A</div>. <div class="title">T</div>. <div class="publishing">In J, Y</div>.</div>'
]
