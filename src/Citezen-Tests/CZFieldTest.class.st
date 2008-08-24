Class {
	#name : #CZFieldTest,
	#superclass : #TestCase,
	#category : #'Citezen-Tests'
}

{ #category : #tests }
CZFieldTest >> testPeople [
	| field |
	field := CZField
		key: #author
		rawValue: 'Last, First Middle and Prénom de Nom'.
	self assert: field valueClass = CZPeople.
	self assert: field value size = 2.
	self assert: field value first shortenedName = 'F. M. Last'
]
