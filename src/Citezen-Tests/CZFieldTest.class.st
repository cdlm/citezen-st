Class {
	#name : #CZFieldTest,
	#superclass : #TestCase,
	#instVars : [
		'entry'
	],
	#category : 'Citezen-Tests'
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
CZFieldTest >> testIsUndefined [
	self deny: (entry at:#title) isUndefined.
	self assert: (CZUndefinedField new isUndefined). 
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
	self assert: (entry at:#author) value class = ByteString.
	self assert: (entry at:#author) rawValue class = ByteString.
	
	self assert: (entry at:#title) value class = ByteString.
	self assert: (entry at:#title) value class = (entry at:#title) rawValue class.
	
	self assert: (entry at:#year) value class = SmallInteger.
	self assert: (entry at:#title) value class = (entry at:#title) rawValue class.
	
	self assert: (entry at:#undefined) value = ''
]

{ #category : #testsForInstances }
CZFieldTest >> testValueClass [
	| string |
	
	string := {CZString . CZMacroReference . CZCompositeValue}.
	self assert: (entry at:#author) valueClass = CZPeople.
	self assert: (string includes: (entry at:#title) valueClass).
	self assert: (entry at:#year) valueClass = CZInteger.
	self assert: (string includes: (entry at:#annotation) valueClass).
	
	self assert: (entry at:#undefined) valueClass = CZValue
	
]
