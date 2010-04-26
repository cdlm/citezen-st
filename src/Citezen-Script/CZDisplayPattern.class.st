Class {
	#name : #CZDisplayPattern,
	#superclass : #Object,
	#instVars : [
		'lastAddWasField',
		'fields',
		'separators',
		'defaultSeparator',
		'begin',
		'end'
	],
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZDisplayPattern >> beginWith: aString [
	begin := aString 
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> defaultSeparator: aString [
	defaultSeparator := aString 
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> endWith: aString [
	end := aString 
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> field: aSymbol [
	lastAddWasField ifTrue: [
		separators add: defaultSeparator].
	fields add: aSymbol.
	lastAddWasField := true
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> fields [ 
	^ OrderedCollection new addAll: fields; yourself
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> initialize [
	lastAddWasField := false.
	fields := OrderedCollection new.
	separators := OrderedCollection new.
	begin := end := defaultSeparator := ' '
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> separator: aString [
	separators add: aString .
	lastAddWasField := false
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> separators [ 
	^ OrderedCollection new addAll: separators; addFirst: begin; addLast: end; yourself
]
