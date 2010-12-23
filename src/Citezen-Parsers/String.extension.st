Extension { #name : #String }

{ #category : #'*citezen-parsers' }
String >> trimBoth [
	"Damien Cassou: this method is required by SmaCC but looks like it has been removed from Pharo. I copied the implementation from Grease."
	| left right aBlock|
	aBlock := [ :char | char isSeparator ].
	left := 1.
	right := self size.
	[ left <= right and: [ aBlock value: (self at: left) ] ]
		whileTrue: [ left := left + 1 ].
	[ left <= right and: [ aBlock value: (self at: right) ] ]
		whileTrue: [ right := right - 1 ].
	^ self copyFrom: left to: right
]
