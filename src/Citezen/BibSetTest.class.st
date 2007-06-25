Class {
	#name : #BibSetTest,
	#superclass : #TestCase,
	#instVars : [
		'bibset'
	],
	#category : #'Citezen-Tests'
}

{ #category : #setup }
BibSetTest >> setUp [
	bibset := BibParser parse: '
@string(used = "foo")
@string(unused = "bar")
@sometype{somekey,
	foo = used
}'

]

{ #category : #testing }
BibSetTest >> testUnusedMacros [
	bibset macros size = 2.

	bibset dropUnusedMacros.
	self assert: bibset macros size = 1.
	self shouldnt: (bibset macroAt: #used) raise: Error.
	self should: (bibset macroAt: #unused) raise: Error
]
