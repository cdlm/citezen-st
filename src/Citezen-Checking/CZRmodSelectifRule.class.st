Class {
	#name : #CZRmodSelectifRule,
	#superclass : #CZRmodRule,
	#category : 'Citezen-Checking'
}

{ #category : #'as yet unclassified' }
CZRmodSelectifRule >> condition: aCZEntry [
	^ (aCZEntry hasField: #selectif)
		ifFalse: [ false ]
		ifTrue: [ #(non oui) includes: (aCZEntry at: #selectif) rawValue ]
]

{ #category : #'as yet unclassified' }
CZRmodSelectifRule >> explanation [
	^ '(Inria) Must have field #selectif with value in: [oui non]'
]
