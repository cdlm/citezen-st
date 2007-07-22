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
	phrase := BibPhraseLibrary phraseFor: entry.
	
	renderer := BibHtmlRenderer html:
		(WAStaticHtmlCanvas document:
			(WAHtmlStreamDocument new stream: String new writeStream))
]

{ #category : #testing }
BibHtmlTest >> testArticle [
	| actual |
	renderer render: phrase for: entry.
	actual := renderer contents.
	self assert: actual = '<div class="article"><div class="author">A</div>. <div class="title">T</div>. <div class="publishing">In J, Y</div>.</div>'
]

{ #category : #testing }
BibHtmlTest >> testSeveral [
	| actual |
	renderer render: phrase for: entry.
	renderer render: phrase for: entry.
	actual := renderer contents.
	self assert: actual = '<div class="article"><div class="author">A</div>. <div class="title">T</div>. <div class="publishing">In J, Y</div>.</div><div class="article"><div class="author">A</div>. <div class="title">T</div>. <div class="publishing">In J, Y</div>.</div>'
]
