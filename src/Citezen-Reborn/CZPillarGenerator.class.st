"
A visitor that generates pillar format.
I use a pillar writer to properly encode special characters. 
"
Class {
	#name : #CZPillarGenerator,
	#superclass : #CZFileFormatGenerator,
	#instVars : [
		'writer'
	],
	#category : #'Citezen-Reborn-FormattingVisitors'
}

{ #category : #entries }
CZPillarGenerator >> emitEntryHeader: anEntry [

	self outputStream nextPutAll: '# '.
]

{ #category : #accessing }
CZPillarGenerator >> expansionPolicyAppliedTo: aCZString [
	^ aCZString expanded
]

{ #category : #initialize }
CZPillarGenerator >> initialize [
	super initialize.
	writer := PRPillarWriter new.
]

{ #category : #'string encoding hooks' }
CZPillarGenerator >> setEncodedCharacterTransformationTable [
	CZAccentuateCharactersParser toAccentedCharTable
]

{ #category : #'string encoding hooks' }
CZPillarGenerator >> treatSignsInString: aString [
	"we ask the pillar writer to escape all the special pillar characters."
	^ writer escape: aString
]

{ #category : #visit }
CZPillarGenerator >> visitDocTitle: aTitle [
	self outputStream nextPutAll: '!'.
	super visitDocTitle: aTitle.
]

{ #category : #visit }
CZPillarGenerator >> visitField: aField [
	
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
CZPillarGenerator >> visitItem: anItem [
	
	outputStream 
		nextPutAll: '- *'; 
		nextPutAll: anItem name;
		nextPutAll: '>';
		nextPutAll: anItem link;
		nextPutAll: '*'.
		self line.

]

{ #category : #visit }
CZPillarGenerator >> visitPeople: aCZPeople [

	aCZPeople perform:  expandOption.
	self outputStream nextPutAll: (self treatString: aCZPeople expanded)
]

{ #category : #visit }
CZPillarGenerator >> visitSectionTitle: aCZString [
	
	outputStream 
		nextPutAll: '!!'; 
		nextPutAll: (self treatString: aCZString expanded).
		self line.
		self line.
]
