"
A CZHTMLGeneratorTest is test
"
Class {
	#name : #CZHTMLGeneratorTest,
	#superclass : #CZFileFormatGeneratorTest,
	#category : #'Citezen-Reborn'
}

{ #category : #tests }
CZHTMLGeneratorTest >> generatorClass [

	^ CZHTMLGenerator
]

{ #category : #tests }
CZHTMLGeneratorTest >> testSet [
	"self debug: #testSet"
	
	| visitor |
	visitor := self generatorClass new.
	visitor visit: bibset.
	self assert: (visitor outputStream contents = '<ol>
<li>
Ducasse, St\''ephane and Ducasse, Florence, La maledication de la fille de la femme crocodile, Journal of Hatred, 2012.
</li>
<li>
Ducasse, St\''ephane, Botsinc: Learning programming in Squeak, Apress, 2005.
</li>
</ol>')
]
