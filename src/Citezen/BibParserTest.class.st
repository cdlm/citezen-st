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
Thomas de~Grenier~de Latour.
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
	title = "Hello world",
	author = {Thomas de Grenier de Latour},
	journal = foo,
	year = 2042,
)

@misc{meuh}'
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
