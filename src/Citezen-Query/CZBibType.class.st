Class {
	#name : #CZBibType,
	#superclass : #CZBibQueryFactory,
	#category : #'Citezen-Query'
}

{ #category : #querying }
CZBibType class >> matches: aPattern [
	^ (CZBibTypeMatches new)
		pattern: aPattern;
		yourself
]
