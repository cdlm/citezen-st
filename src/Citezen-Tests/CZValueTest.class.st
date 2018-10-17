Class {
	#name : #CZValueTest,
	#superclass : #TestCase,
	#instVars : [
		'entry',
		'macro'
	],
	#category : 'Citezen-Tests'
}

{ #category : #'as yet unclassified' }
CZValueTest >> setUp [
	| bibset |
	
	bibset := (CZBibParser parse: CZTestResource bibTest).
	entry := bibset entries at:1.
	macro := bibset macros at:1.
]

{ #category : #'as yet unclassified' }
CZValueTest >> testValues [
	self assert: entry author valueClass = CZPeople.
	self assert: entry title valueClass = CZString.
	self assert: entry year valueClass = CZInteger.
	
]
