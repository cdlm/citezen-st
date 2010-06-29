Extension { #name : #SmalltalkImage }

{ #category : #'*Citezen-CommandLine' }
SmalltalkImage >> extractMinusParameters [
	"Returns a dictionary matching parameters beginning by a minus character and the list of the next parameters.
	Here is an example: 
		I suppose I run pharo with: `pharo myImage.image -minus1 'Hello' -minus2 -minus3 'Hello' 'World'`.
		This message will return a dictionary with: 
			minus1 --> #(Hello)
			minus2 --> #()
			minus3 --> #('Hello' 'World')"
			
	| args dict str previous previousWithMinus index |
	
	dict := Dictionary new.
	args := OrderedCollection new.
	previous := previousWithMinus := ''.

	str := self getSystemAttribute: (index := 2).
	[ str isNil ] whileFalse: [ args add: str. str := self getSystemAttribute: (index := index + 1) ].

	args ifEmpty: [ ^ dict ].

	previous := previousWithMinus := args detect: [ :each | each first = $- ].
	[ (args first = previous) & (args isEmpty not) ] whileFalse: [ args removeFirst ].
	
	args do: [ :each |
		(each first = $-)
			ifTrue: [ 
				(previous first = $-) ifTrue: [ dict at: previous allButFirst put: #() ].
				previousWithMinus := each ]
			ifFalse: [ dict at: previousWithMinus allButFirst put: ((dict at: previousWithMinus allButFirst ifAbsent: [ #() ]), (Array with: each)) ].
				
		previous := each.
	].

	(previous first = $-) ifTrue: [ dict at: previous allButFirst put: #() ].

	^ dict
]

{ #category : #'*Citezen-CommandLine' }
SmalltalkImage >> shouldQuit [
	^ self extractMinusParameters includesKey: 'quit'
]