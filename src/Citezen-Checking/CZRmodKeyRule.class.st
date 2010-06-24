Class {
	#name : #CZRmodKeyRule,
	#superclass : #CZRmodRule,
	#category : #'Citezen-Checking'
}

{ #category : #'as yet unclassified' }
CZRmodKeyRule >> condition: aCZEntry [
	^ (aCZEntry key size = 7)
		ifFalse: [ false ]
		ifTrue: [ 
			| ret |
			ret := true.
			1 to: 4 do: [ :cpt | (aCZEntry key at: cpt) isLetter ifFalse: [ ret := false ] ].
			5 to: 6 do: [ :cpt | (aCZEntry key at: cpt) isDigit ifFalse: [ ret := false] ].
			(aCZEntry key at: 7) isLetter ifFalse: [ ret := false ].
			ret ]
]

{ #category : #'as yet unclassified' }
CZRmodKeyRule >> explanation [ 
	^ '(Inria) Key = 4 letter + 2 digit of year + a-z'
]
