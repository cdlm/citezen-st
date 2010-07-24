Class {
	#name : #CZParserTest,
	#superclass : #TestCase,
	#category : #'Citezen-Tests'
}

{ #category : #'test data' }
CZParserTest class >> auxFile [
	^'junk
	\citation{foobar}
\citation{meuh}
\bibstyle{alpha}\bibdata{test}
'
]

{ #category : #'test data' }
CZParserTest class >> bblFile [
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
CZParserTest class >> bibFile [
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
CZParserTest >> testAux [
	| aux |
	aux := CZAuxParser on: self class auxFile readStream.
	aux parse.
	self assert: aux citations size = 2.
	self assert: aux databases size = 1.
	self assert: aux style = 'alpha'
]

{ #category : #'tests (todo)' }
CZParserTest >> testBib [
	| bibset |
	bibset := CZBibParser parse: '@article{key, year=42}'.
	self assert: bibset macros size = 0.
	self assert: bibset entries size = 1
]

{ #category : #tests }
CZParserTest >> testComment [
	| bibset |
	bibset := CZBibParser parse: '
@comment( junk )
'.
	self assert: bibset macros isEmpty.
	self assert: bibset entries isEmpty
]

{ #category : #tests }
CZParserTest >> testEntry [
	| bibset entry |
	bibset := CZBibParser 
				parse: '
@article(foobar,
	Title = "Hello world",
	author = {Foo Bar},
	journal = foo,
	year = 2042
)
'.
	self assert: bibset macros isEmpty.
	entry := bibset entryAt: #foobar.
	self assert: entry type =  CZEntry article.
	self assert: entry size = 4.
	self assert: (entry title) value = 'Hello world'
]

{ #category : #tests }
CZParserTest >> testMacro [
	| bibset |
	bibset := CZBibParser parse: '
@string(foo = {bar})
'.
	self assert: (bibset macroAt: 'foo') rawValue = 'bar'.
	self assert: (bibset macroAt: 'foo') value = 'bar'.
	self assert: bibset entries isEmpty
]

{ #category : #tests }
CZParserTest >> testScannedComment [
	| bibset |
	bibset := CZBibParser parse: '
% junk stuff
'.
	self assert: bibset macros isEmpty.
	self assert: bibset entries isEmpty
]

{ #category : #tests }
CZParserTest >> testSimpleValues [
	| bibset entry |
	bibset := CZBibParser 
				parse: '
@sometype(somekey,
	num = 42,
	ref = 42foo,
	reftoo = foo42,
	justavalue = "42"
)
'.
	entry := bibset entryAt: 'somekey'.
	self assert: (entry at: 'num') rawValue isNumber.
	self assert: (entry at: 'ref') rawValue isSymbol.
	self assert: (entry at: 'reftoo') rawValue isSymbol.
	self assert: (entry at: 'justavalue') rawValue isNumber not.
	self assert: (entry at: 'justavalue') rawValue isSymbol not
]
