Class {
	#name : #CPPierRenderer,
	#superclass : #CPPlainPierRenderer,
	#category : #'Citezen-Pier'
}

{ #category : #'visiting-phrases' }
CPPierRenderer >> currentEntryUrl [
	^ ('\s+' asRegex split: (currentEntry at: #url) value) first
]

{ #category : #'visiting-phrases' }
CPPierRenderer >> highlightUrlInField: field for: format [
	| re url |
	re := '\\url\{([^}]*)}' asRegexIgnoringCase.
			(field key = #note and: [ re search: field rawValue ]) 
				ifTrue: 
					[ url := self class htmlOutOfLatexString: (re subexpression: 2).
					self text: '*' , url , '*' ]
				ifFalse: [ self visit: format ]
]

{ #category : #'visiting-phrases' }
CPPierRenderer >> linkFor: format [
	self
		text: '*';
		visit: format;
		text: '>';
		text: self currentEntryUrl;
		text: '*'
]

{ #category : #'visiting-phrases' }
CPPierRenderer >> visitFieldRef: aFieldRef [ 
	| field format |
	field := currentEntry at: aFieldRef fieldName.
	field ifNil: [ ^ self ].
	format := self formatFor: field.
	(field key = #title and: [ currentEntry hasField: #url ]) 
		ifTrue: [ self linkFor: format ]
		ifFalse: 
			[ (field key = #note)
				ifTrue: [ self highlightUrlInField: field for: format ]
				ifFalse: [ self visit: format ] ].

]
