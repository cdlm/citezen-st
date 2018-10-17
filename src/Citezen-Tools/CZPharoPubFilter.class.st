"
probably to remove or to really enhance....

stef
"
Class {
	#name : #CZPharoPubFilter,
	#superclass : #CZTool,
	#category : 'Citezen-Tools'
}

{ #category : #'as yet unclassified' }
CZPharoPubFilter class >> example [
	"self  example"
	
	| bibset |
	bibset := CZFileLoader  bibFromFileNamed: 'rmod.bib'.
	^ bibset select: [:each | each isPharoPub].
]
