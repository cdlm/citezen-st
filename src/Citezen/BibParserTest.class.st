Class {
	#name : #BibParserTest,
	#superclass : #TestCase,
	#category : #'Citezen-Tests'
}

{ #category : #testing }
BibParserTest >> testComment [
	|bibset|
	bibset := BibParser parse: '
@comment( junk )
'.
	self assert: bibset macros isEmpty.
	self assert: bibset entries isEmpty
]

{ #category : #testing }
BibParserTest >> testEntry [
	|bibset entry|
	bibset := BibParser parse: '
@article(foobar,
	title = "Hello world",
	author = {Foo Bar},
	journal = foo,
	year = 2042
)
'.
	self assert: bibset macros isEmpty.
	entry := bibset entries at: 'foobar'.
	self assert: entry type = 'article'.
	self assert: entry size = 4
]

{ #category : #testing }
BibParserTest >> testMacro [
	|bibset|
	bibset := BibParser parse: '
@string(foo = {bar})
'.
	self assert: (bibset macros at: 'foo') = 'bar'.
	self assert: bibset entries isEmpty
]

{ #category : #testing }
BibParserTest >> testScannedComment [
	|bibset|
	bibset := BibParser parse: '
% junk stuff
'.
	self assert: bibset macros isEmpty.
	self assert: bibset entries isEmpty
]
