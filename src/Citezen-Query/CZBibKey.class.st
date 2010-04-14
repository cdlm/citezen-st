Class {
	#name : #CZBibKey,
	#superclass : #CZBibQueryFactory,
	#category : #'Citezen-Query'
}

{ #category : #querying }
CZBibKey class >> matches: aPattern [
	^ (CZBibKeyMatches new)
		pattern: aPattern;
		yourself
]
