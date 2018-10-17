Class {
	#name : #CZRmodAeresClassificationRule,
	#superclass : #CZRmodRule,
	#category : 'Citezen-Checking'
}

{ #category : #'as yet unclassified' }
CZRmodAeresClassificationRule >> condition: aCZEntry [
	^ (aCZEntry hasField: #aeres)
		ifFalse: [ false ]
		ifTrue: [ #(ACL ACLN ASCL INV ACT COM AFF OS OV DO AP TH) includes: (aCZEntry at: #aeres) rawValue.]
]

{ #category : #'as yet unclassified' }
CZRmodAeresClassificationRule >> explanation [ 
	^ '(Inria) Must have field #aeres with value in: [ACL ACLN ASCL INV ACT COM AFF OS OV DO AP TH]'
]
