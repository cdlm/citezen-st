Class {
	#name : #CZRawOutputerTest,
	#superclass : #TestCase,
	#instVars : [
		'fileName',
		'bibset'
	],
	#category : #'Citezen-Tests'
}

{ #category : #initialization }
CZRawOutputerTest >> initialize [
	fileName := 'tests/lse.bib'
]

{ #category : #running }
CZRawOutputerTest >> setUp [
	bibset := CZBibParser parse: ((FileStream readOnlyFileNamed: fileName) contents)
]

{ #category : #tests }
CZRawOutputerTest >> testWithFilter [
	
	| generateBibset |
	generateBibset := CZBibParser parse: ((CZRawOutputer withoutThisFields: #(author)) getOutputFor: bibset).
	
	self assert: (bibset entries size = generateBibset entries size).
	self assert: (bibset macros size = generateBibset macros size).
	
	1 to: bibset entries size do: [ :cpt | 
		((bibset entries at: cpt) hasField: #author)
			ifTrue: [ "if the entry includes the author, test if the new size has changed ..."
				self assert: (((bibset entries at: cpt) fields size) = ((generateBibset entries at: cpt) fields size + 1))]
			ifFalse: [ "... or entry doesn't include an author field, test if the two size est equals"
				self assert: (((bibset entries at: cpt) fields size) = ((generateBibset entries at: cpt) fields size))].
		self assert: (((generateBibset entries at: cpt) at: #author ifAbsent: [ 'missing' ]) = 'missing')].
]

{ #category : #tests }
CZRawOutputerTest >> testWithUsefullAndUselessFilter [
	
	| generateBibset |
	generateBibset := CZBibParser parse: ((CZRawOutputer withoutThisFields: #(12 toto author '' nil)) getOutputFor: bibset).
	
	self assert: (bibset entries size = generateBibset entries size).
	self assert: (bibset macros size = generateBibset macros size).
	
	1 to: bibset entries size do: [ :cpt | 
		((bibset entries at: cpt) hasField: #author)
			ifTrue: [ "if the entry includes the author, test if the new size has changed ..."
				self assert: (((bibset entries at: cpt) fields size) = ((generateBibset entries at: cpt) fields size + 1))]
			ifFalse: [ "... or entry doesn't include an author field, test if the two size est equals"
				self assert: (((bibset entries at: cpt) fields size) = ((generateBibset entries at: cpt) fields size))].
		self assert: (((generateBibset entries at: cpt) at: #author ifAbsent: [ 'missing' ]) = 'missing')].
]

{ #category : #tests }
CZRawOutputerTest >> testWithUselessFilter [

	| generateBibset |
	generateBibset := CZBibParser parse: ((CZRawOutputer withoutThisFields: #(12 toto '' nil)) getOutputFor: bibset).
	
	self assert: (bibset equalsButDifferent: generateBibset).
]

{ #category : #tests }
CZRawOutputerTest >> testWithoutFilter [
	"Check if the file content equals with the generate file"
	
	| generateBibset |
	generateBibset := CZBibParser parse: (CZRawOutputer new getOutputFor: bibset).
	
	self assert: (bibset equalsButDifferent: generateBibset).
]
