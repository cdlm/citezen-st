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
<span class="author">St&eacute;phane Ducasse and Florence Ducasse</span>, <span class="title">La maledication de la fille de la femme crocodile</span>, <span class="journal">Journal of Hatred</span>, <span class="year">2012</span>.
</li>
<li>
<span class="author">St&eacute;phane Ducasse</span>, <span class="title">Botsinc: Learning programming in Squeak</span>, <span class="journal">Apress</span>, <span class="year">2005</span>.
</li>
</ol>')
]
