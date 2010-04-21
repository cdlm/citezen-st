Class {
	#name : #CZRawOutputer,
	#superclass : #CZOutputer,
	#instVars : [
		'filter'
	],
	#category : #'Citezen-Outputers'
}

{ #category : #'as yet unclassified' }
CZRawOutputer >> initialize [ 
	super initialize.
	filter := #()
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> setFieldsToExclude: aCollection [
	filter := (aCollection 
		collect: [ :each | 
			(each isNil & each isKindOf: Number) 
				ifFalse: [each asString asSymbol asLowercase ]] 
		thenSelect: [ :each | each isNil not])
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitCompositeValue: aCZCompositeValue [
	aCZCompositeValue do: 
		[ :each | each acceptVisitor: self] separatedBy: [ outputStream nextPutAll: ' # ' ].
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
	outputStream 
		nextPutAll: '  ';
		nextPutAll: aField key;
		nextPutAll: ' = '.
	aField dispatchVisitor: self
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitInteger: aCZInteger [
	outputStream nextPutAll: aCZInteger notExpanded asString 
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitMacroReference: aCZMacroReference [
	outputStream nextPutAll: aCZMacroReference notExpanded 
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitPeople: aCZPeople [
	outputStream nextPut: ${; nextPutAll: aCZPeople notExpanded; nextPut: $}
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
		outputStream cr; nextPut: $}; cr; cr.].
	
]

{ #category : #'as yet unclassified' }
CZRawOutputer >> visitString: aCZString [
	outputStream nextPut: ${; nextPutAll: aCZString notExpanded; nextPut: $}
]
