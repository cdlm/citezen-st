Class {
	#name : #CZSequenceSource,
	#superclass : #CZGroup,
	#category : 'Citezen-Rendering2'
}

{ #category : #rendering }
CZSequenceSource >> streamFrom: anEntry to: aNodeStream [ 
	| nodesStream |
	nodesStream := Array new writeStream.
	children do: [:each | each streamFrom: anEntry to: nodesStream].
	(CZGroup fromGroup: self nodes: nodesStream contents asOrderedCollection)
		streamFrom: anEntry to: aNodeStream
]
