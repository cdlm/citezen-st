Class {
	#name : #CZRmodInriaRmodRule,
	#superclass : #CZRmodRule,
	#category : 'Citezen-Checking'
}

{ #category : #'as yet unclassified' }
CZRmodInriaRmodRule >> condition: aCZEntry [
	^ (aCZEntry hasField: #inria)
		ifFalse: [ false ]
		ifTrue: [ (aCZEntry at: #inria) rawValue = 'RMOD' ]
]

{ #category : #'as yet unclassified' }
CZRmodInriaRmodRule >> explanation [ 
	^ '(Inria) Must have field #inria with value "RMOD"'
]
