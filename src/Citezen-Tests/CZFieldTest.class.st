Class {
	#name : #CZFieldTest,
	#superclass : #TestCase,
	#instVars : [
		'entry'
	],
	#category : #'Citezen-Tests'
}

{ #category : #running }
CZFieldTest >> setUp [

	entry := (CZBibParser parse: CZTestResource bibTest) entries at:1.

]

{ #category : #testsForInstances }
CZFieldTest >> testAddToBibSet [
	| bibset nbMacros |
	bibset := CZBibParser parse: CZTestResource bibTest.
	nbMacros := bibset macros size.
	
	(CZField key:'m' rawValue: 'M') addToBibSet: bibset.
	
	self assert: (bibset macros size) = (nbMacros + 1)
]

{ #category : #testsForInstances }
CZFieldTest >> testEqualsButDifferent [ 
	| duplicateEntry titleValue |
	
	duplicateEntry := (CZBibParser parse: CZTestResource bibTest) entries at:1.
	
	self assert: ((entry at:#author) equalsButDifferent: (duplicateEntry at:#author)).
	self deny: ((entry at:#author) equalsButDifferent: (entry at:#author)).
	
	duplicateEntry := (CZBibParser parse: CZTestResource bibTest) entries at:1.
	titleValue := (duplicateEntry at:#title) value.
	(duplicateEntry at:#title) setKey:#keyChanged rawValue:titleValue.
	self deny: ((entry at:#title) equalsButDifferent: (duplicateEntry at:#title)).
	
	duplicateEntry := (CZBibParser parse: CZTestResource bibTest) entries at:1.
	(duplicateEntry at:#title) setKey:#title rawValue:'title changed'.
	self deny: ((entry at:#title) equalsButDifferent: (duplicateEntry at:#title)).
]

{ #category : #testsForInstances }
CZFieldTest >> testIsUndefined [
	self deny: (entry at:#title) isUndefined.
	self assert: (CZUndefinedField new isUndefined). 
]

{ #category : #testForClass }
CZFieldTest >> testKeyValue [
	| value |

	self assert: ((CZField new setKey: #key rawValue: 'value') equalsButDifferent: (CZField key: #key rawValue: 'value')).
	
	value := CZString new setValue: 'value'.
	self assert: ((CZField new setKey: #key value: value) equalsButDifferent: (CZField key: #key value: value)).
]

{ #category : #testsForInstances }
CZFieldTest >> testPeople [
	| field |
	field := CZField
		key: #author
		rawValue: 'Last, First Middle and Prénom de Nom'.
	self assert: field valueClass = CZPeople.
	self assert: field value size = 2.
	self assert: field value first shortenedName = 'F. M. Last'
]

{ #category : #testsForInstances }
CZFieldTest >> testSetKeyValue [
	| aField |
	
	aField := CZField new.
	aField setKey: #key rawValue: 'a key'.
	self assert: (aField key = #key).
	self assert: (aField rawValue = 'a key').
	
	aField setKey: #key value: (CZString new setValue: 'a key too').
	self assert: (aField rawValue = 'a key too').
]

{ #category : #testForClass }
CZFieldTest >> testUndefined [
	| undefinedField |
	undefinedField := CZField undefined: #undefined.
	self assert: (undefinedField class = CZUndefinedField).
	self assert: (undefinedField key = #undefined).
	self assert: (undefinedField rawValue = CZValue defaultValue notExpanded)
]

{ #category : #testsForInstances }
CZFieldTest >> testValue [
	self assert: (entry at:#author) value class = OrderedCollection.
	self assert: (entry at:#author) rawValue class = ByteString.
	
	self assert: (entry at:#title) value class = ByteString.
	self assert: (entry at:#title) value class = (entry at:#title) rawValue class.
	
	self assert: (entry at:#year) value class = SmallInteger.
	self assert: (entry at:#title) value class = (entry at:#title) rawValue class.
	
	self assert: (entry at:#undefined) value = ''
]

{ #category : #testsForInstances }
CZFieldTest >> testValueClass [
	self assert: (entry at:#author) valueClass = CZPeople.
	self assert: (entry at:#title) valueClass = CZString.
	self assert: (entry at:#year) valueClass = CZInteger.
	self assert: (entry at:#annotation) valueClass = CZString.
	
	self assert: (entry at:#undefined) valueClass = CZString
	
]
