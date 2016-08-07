"
A visitor that generates pillar format.
However I'm hacking the trasnformation of certain symbols instead of using a pillar canvas. I should be removed. 

"
Class {
	#name : #CZPillarGenerator,
	#superclass : #CZFileFormatGenerator,
	#category : #'Citezen-Reborn-FormattingVisitors'
}

{ #category : #entries }
CZPillarGenerator >> emitEntryHeader: anEntry [

	self outputStream nextPutAll: '# '.
]

{ #category : #visit }
CZPillarGenerator >> treatString: aString [

	| s |
	s := aString copyReplaceAll: '--' with: '-'.
	s := s copyReplaceAll: '+' with: '\+'.
	s := s copyReplaceAll: '''' with: '\''\'''.
	s := s copyReplaceAll: '__' with: '-'.
	s := s copyReplaceAll: '==' with: '='.
	s := s copyReplaceAll: '@@' with: ''.
	s := s copyReplaceAll: '""' with: '\"\"'.
	s := s copyReplaceAll: String cr with: String space. 
	s := s copyReplaceAll: String lf with: String space. 
	^ s
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
CZPillarGenerator >> visitItemList: aList [

	 aList elements do: [ :each | self visit: each ] 
]

{ #category : #visit }
CZPillarGenerator >> visitPeople: aCZPeople [

	aCZPeople perform:  expandOption.
	self outputStream nextPutAll: (CZAccentuateCharactersParser parseToAccentedChars: aCZPeople expanded)
]

{ #category : #visit }
CZPillarGenerator >> visitSection: aCZSection [
	
	outputStream 
		nextPutAll: '!!'; 
		nextPutAll: (CZAccentuateCharactersParser parseToAccentedChars: aCZSection name).
		self line.
		self line.
]
