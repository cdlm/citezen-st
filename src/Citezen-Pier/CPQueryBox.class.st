Class {
	#name : #CPQueryBox,
	#superclass : #PRWidget,
	#category : #'Citezen-Pier'
}

{ #category : #'access-description' }
CPQueryBox class >> descriptionBibFile [
	^ PRStructureDescription new
		addCondition: (MACondition selector: #isKindOf: argument: #CPBibFile)
			labelled: 'Select an existing Bib File';
		accessor: #bibFile;
		label: 'Bib File';
		priority: 10;
		beEditable;
		beRequired;
		yourself
]

{ #category : #accessing }
CPQueryBox class >> groupLabel [
	^ 'Pier Bibliography'
]

{ #category : #testing }
CPQueryBox class >> isAbstract [
	^ false
]

{ #category : #accessing }
CPQueryBox class >> label [
	^ 'Query box'
]

{ #category : #rendering }
CPQueryBox >> query: queryString [
	| newContext |
	newContext := self context structure: (self read: #descriptionBibFile).
	
	newContext command viewComponent queryString: queryString; processQuery.

	self context: newContext 
]

{ #category : #rendering }
CPQueryBox >> renderContentOn: html [ 
	html form: [
		html textInput
			callback: [: queryString |
				self query: queryString
				]
		]
]
