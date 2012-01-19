"
CZLaTeXOutputer produce raw latex entries for itemize


For selecting the fields to be displayed right now we use a display pattern as in

journalsScript
	^ CZScript new
		displayPattern: self articleDisplayPattern;
		reversedSortByField: #year;
		query: (self withAuthor 
					AND: CZQuery isInternationalJournalQuery )
"
Class {
	#name : #CZLaTeXOutputer,
	#superclass : #CZOutputer,
	#instVars : [
		'fieldEmbellishingTable'
	],
	#category : #'Citezen-Outputers'
}

{ #category : #'as yet unclassified' }
CZLaTeXOutputer class >> exporterEncoding [

	^ #tex
]

{ #category : #visiting }
CZLaTeXOutputer >> emitEntryHeader: anEntry [
	"Add to the outputStream a header for the correponding anEntry if needed."
	
	outputStream nextPutAll: '\pub '.
]

{ #category : #initialize }
CZLaTeXOutputer >> initialize [

	super initialize.
	self initializeFieldEmbellishingTable.
]

{ #category : #initialize }
CZLaTeXOutputer >> initializeFieldEmbellishingTable [

	fieldEmbellishingTable := Dictionary new. 
	fieldEmbellishingTable at: CZPool author put: '\emph{'.
	fieldEmbellishingTable at: CZPool booktitle put: 'In \emph{'.
	fieldEmbellishingTable at: CZPool title put: '\emph{'.
	fieldEmbellishingTable at: CZPool journal put: 'In \emph{'.

	
	
	
]

{ #category : #visiting }
CZLaTeXOutputer >> visitComment: aCZCommentElement [

	outputStream 
		nextPutAll: '%%',aCZCommentElement comment;
		lf;
		lf
]

{ #category : #visiting }
CZLaTeXOutputer >> visitDocument: aCZDocument [
	
	aCZDocument getWithoutHeaderAndFooter ifFalse: [
		(aCZDocument header isNil)
			ifFalse: [ outputStream nextPutAll: aCZDocument header ]
			ifTrue: [ outputStream nextPutAll: self defaultHeader ] ].
	
	super visitDocument: aCZDocument.
	
	aCZDocument getWithoutHeaderAndFooter ifFalse: [
		(aCZDocument footer isNil)
			ifTrue: [ outputStream nextPutAll: self defaultFooter ]
			ifFalse: [ outputStream nextPutAll: aCZDocument footer ] ].
]

{ #category : #visiting }
CZLaTeXOutputer >> visitField: aField [
	
	"We should probably use phrases instead of doing everything ourselves."
	
	aField key = CZPool volume ifTrue: [outputStream nextPutAll: 'Volume '].
	aField key = CZPool pages ifTrue: [outputStream nextPutAll: 'pp. '].

	fieldEmbellishingTable at: aField key ifPresent: [:t | outputStream nextPutAll: ' ', t].
	aField dispatchVisitor: self.
	fieldEmbellishingTable at: aField key ifPresent: [:t | outputStream nextPutAll: '}'].
	aField key = CZPool editor
		ifTrue: [ outputStream nextPutAll: ' ed.'].
]

{ #category : #visiting }
CZLaTeXOutputer >> visitPeople: aCZPeople [

	aCZPeople expandOption: authorDisplay.
	outputStream nextPutAll:  aCZPeople expanded
]

{ #category : #visiting }
CZLaTeXOutputer >> visitString: aCZString [
	outputStream nextPutAll: aCZString notExpanded asString
]
