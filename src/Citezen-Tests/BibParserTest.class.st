Class {
	#name : #BibParserTest,
	#superclass : #TestCase,
	#category : 'Citezen-Tests'
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

{ #category : #'test data' }
BibParserTest class >> bibFile [
	^ '@string{ foo = "bar" }
@string{ foo = "baz" }
@article(foobar,
	title = "HeY!",
	author = {Théodule du Cellier de Lagrange},
	journal = foo,
	year = 2042
)

@misc{meuh,
	title = {L''eau ou hors le deux}}'
]

{ #category : #tests }
BibParserTest >> testAux [
	| aux |
	"Keep the parser itself because it accumulates what we want.
	#parse returns the value of the initial grammar rule"
	aux := BibAuxParser on: self class auxFile readStream.
	aux parse.
	self assert: aux citations size = 2.
	self assert: aux databases size = 1.
	self assert: aux style = 'alpha'
]

{ #category : #'tests (todo)' }
BibParserTest >> testBib [
	|bibset|
	"fails because of the last comma"
	bibset := BibParser parse: '@article{key, year=42,}'.
	self assert: bibset macros size = 2.
	self assert: bibset entries size = 2
]

{ #category : #tests }
BibParserTest >> testComment [
	|bibset|
	bibset := BibParser parse: '
@comment( junk )
'.
	self assert: bibset macros isEmpty.
	self assert: bibset entries isEmpty
]

{ #category : #tests }
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

{ #category : #tests }
BibParserTest >> testMacro [
	|bibset|
	bibset := BibParser parse: '
@string(foo = {bar})
'.
	self assert: (bibset macroAt: 'foo') value = 'bar'.
	self assert: bibset entries isEmpty
]

{ #category : #tests }
BibParserTest >> testScannedComment [
	|bibset|
	bibset := BibParser parse: '
% junk stuff
'.
	self assert: bibset macros isEmpty.
	self assert: bibset entries isEmpty
]

{ #category : #tests }
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
