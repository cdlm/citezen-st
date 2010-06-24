Class {
	#name : #CZRmodLaboRule,
	#superclass : #CZRmodRule,
	#category : #'Citezen-Checking'
}

{ #category : #'as yet unclassified' }
CZRmodLaboRule >> condition: aCZentry [
	^ (aCZentry hasField: #labo)
		ifFalse: [ false ]
		ifTrue: [ #(dans hors) includes: (aCZentry at: #labo) rawValue ]
]

{ #category : #'as yet unclassified' }
CZRmodLaboRule >> explanation [
	^ '(Inria) Must have field #labo with value in: [dans hors]'
]
