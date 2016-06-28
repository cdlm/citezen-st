"
A visitor that generates pillar format.
"
Class {
	#name : #CZPillarNewGenerator,
	#superclass : #CZFileFormatGenerator,
	#instVars : [
		'writer'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #entries }
CZPillarNewGenerator >> emitEntryHeader: anEntry [

	self outputStream nextPutAll: '# '.
]

{ #category : #initialize }
CZPillarNewGenerator >> initialize [
	super initialize.
	writer := PRPillarWriter new.
]

{ #category : #'as yet unclassified' }
CZPillarNewGenerator >> treatString: aString [

	^ writer escape: aString
]

{ #category : #'as yet unclassified' }
CZPillarNewGenerator >> visitField: aField [
	
	aField isURL
		ifTrue: [outputStream nextPutAll: '*PDF>'].
	aField isDoi
		ifTrue: [outputStream nextPutAll: '*DOI>http://dx.doi.org/'].	
	aField dispatchVisitor: self.
	aField isURL
		ifTrue: [outputStream nextPutAll: '*'].
	aField isDoi
		ifTrue: [outputStream nextPutAll: '*'].

]

{ #category : #visit }
CZPillarNewGenerator >> visitItem: anItem [
	
	outputStream 
		nextPutAll: '- *'; 
		nextPutAll: anItem name;
		nextPutAll: '>';
		nextPutAll: anItem link;
		nextPutAll: '*'.
		self line.

]

{ #category : #visit }
CZPillarNewGenerator >> visitItemList: aList [

	 aList elements do: [ :each | self visit: each ] 
]

{ #category : #visit }
CZPillarNewGenerator >> visitPeople: aCZPeople [

	aCZPeople perform:  expandOption.
	self outputStream nextPutAll: (CZAccentuateCharactersParser parseToAccentedChars: aCZPeople expanded)
]

{ #category : #visit }
CZPillarNewGenerator >> visitSection: aCZSection [
	
	outputStream 
		nextPutAll: '!!'; 
		nextPutAll: (CZAccentuateCharactersParser parseToAccentedChars: aCZSection name).
		self line.
		self line.
]
