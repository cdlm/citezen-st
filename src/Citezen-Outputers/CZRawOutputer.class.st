Class {
	#name : #CZRawOutputer,
	#superclass : #CZVisitor,
	#instVars : [
		'filter'
	],
	#category : #'Citezen-Outputers'
}

{ #category : #'as yet unclassified' }
CZRawOutputer class >> withoutThisFields: aCollection [
	^ (self new) setFieldsToExclude: aCollection 
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> initialize [ 
	super initialize.
	filter := #()
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> setFieldsToExclude: aCollection [
	filter := (aCollection 
		collect: [ :each | 
			(each isKindOf: Number) 
				ifFalse: [each asSymbol asLowercase ]] 
		thenSelect: [ :each | each isNil not])
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitEntry: anEntry [
	| fields |
	fields := anEntry fields reject: [ :each | filter includes: each key ].
	
	fields do: [ :each |
		each acceptVisitor: self.
		(each == (anEntry fields at: anEntry size))
			ifFalse: [outputStream nextPut: $,; cr]]

]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitField: aField [
	outputStream nextPutAll: aField key;
		nextPutAll: ' = ';
		nextPutAll: aField rawValueWithBibtexSyntax 
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitSet: aSet [	
	aSet macros do: [ :each | 
		outputStream nextPutAll: '@string {'.
		each acceptVisitor: self.
		outputStream nextPut: $}; cr; cr.
		].
	
	aSet entries do: [ :each | 
		outputStream nextPut: $@;
			nextPutAll: each type;
			nextPutAll: ' {';
			nextPutAll: each key;
			nextPut: $,; cr.
		each acceptVisitor: self.
		outputStream cr; nextPut: $}; cr; cr.
		].
	
]
