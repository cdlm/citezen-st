Class {
	#name : #CZRmodAeresStatusRule,
	#superclass : #CZRmodRule,
	#category : #'Citezen-Checking'
}

{ #category : #'as yet unclassified' }
CZRmodAeresStatusRule >> condition: aCZEntry [
	^ (aCZEntry hasField: #aeresstatus)
		ifFalse: [ false ]
		ifTrue: [ '*aeres*' match: (aCZEntry at: #aeresstatus) rawValue ]
]

{ #category : #'as yet unclassified' }
CZRmodAeresStatusRule >> explanation [
	^ '(Inria) Must have field #aeresstatus with value "aeres12"'
]
