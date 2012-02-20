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
	self assert: (visitor outputStream contents =  '<ol>
<li>St&eacute;phane Ducasse and Florence Ducasse, La maledication de la fille de la femme crocodile, Journal of Hatred, 2012.</li><li>St&eacute;phane Ducasse, Botsinc: Learning programming in Squeak, Apress, 2005.</li></ol>'
).
]
