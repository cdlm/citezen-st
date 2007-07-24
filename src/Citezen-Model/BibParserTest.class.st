Class {
	#name : #BibParserTest,
	#superclass : #TestCase,
	#category : #'Citezen-Tests'
}

{ #category : #'test data' }
BibParserTest class >> auxFile [
	^'junk
	\citation{foobar}
\citation{meuh}
\bibstyle{alpha}\bibdata{test}
'
]

{ #category : #'test data' }
BibParserTest class >> bblFile [
	^ '\begin{thebibliography}{dGdL42}

\bibitem[dGdL42]{foobar}
Théodule du~Cellier~de Lagrange.
\newblock Hello world.
\newblock {\em baz}, 2042.

\bibitem[meu]{meuh}


\end{thebibliography}
'
]

{ #category : #testing }
BibParserTest >> testAux [
	| aux |
	aux := BibAuxParser on: self class auxFile readStream.
	aux parse.
	self assert: aux citations size = 2.
	self assert: aux databases size = 1.
	self assert: aux style = 'alpha'
]

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
	Title = "Hello world",
	author = {Foo Bar},
	journal = foo,
	year = 2042
)
'.
	self assert: bibset macros isEmpty.
	entry := bibset entryAt: 'foobar'.
	self assert: entry type = 'article'.
	self assert: entry size = 4.
	self assert: (entry at: #title) = 'Hello world'
]

{ #category : #testing }
BibParserTest >> testMacro [
	|bibset|
	bibset := BibParser parse: '
@string(foo = {bar})
'.
	self assert: (bibset macroAt: 'foo') value = 'bar'.
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

{ #category : #testing }
BibParserTest >> testSimpleValues [
	|bibset entry|
	bibset := BibParser parse: '
@sometype(somekey,
	num = 42,
	ref = 42foo,
	reftoo = foo42,
	justavalue = "42"
)
'.
	entry := bibset entryAt: 'somekey'.
	self assert: (entry at: 'num') isNumber.
	self assert: (entry at: 'ref') isSymbol .
	self assert: (entry at: 'reftoo') isSymbol.
	self assert: (entry at: 'justavalue') isNumber not.
	self assert: (entry at: 'justavalue') isSymbol not
]
