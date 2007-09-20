Class {
	#name : #CZSequenceSource,
	#superclass : #CZGroup,
	#category : #'Citezen-Rendering2'
}

{ #category : #'as yet unclassified' }
CZSequenceSource >> streamFrom: anEntry to: aNodeStream [ 
	| nodesStream nodes |
	nodesStream := OrderedCollection new writeStream.
	children do: [:each | each streamFrom: anEntry to: nodesStream].
	nodes := nodesStream contents.
	(nodes allSatisfy: [:it | it isVolatile]) "true even if empty"
		ifFalse: [aNodeStream nextPut: (CZGroup nodes: nodes)]
]
