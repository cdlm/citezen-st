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
	fieldEmbellishingTable at: Author put: '\emph{'.
	fieldEmbellishingTable at: BookTitle put: 'In \emph{'.
	fieldEmbellishingTable at: Title put: '\emph{'.
	fieldEmbellishingTable at: Journal put: 'In \emph{'.

	
	
	
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
		(aCZDocument header isNil not)
			ifTrue: [ outputStream nextPutAll: aCZDocument header ]
			ifFalse: [ outputStream nextPutAll: self defaultHeader ] ].
	
	super visitDocument: aCZDocument.
	
	aCZDocument getWithoutHeaderAndFooter ifFalse: [
		(aCZDocument footer isNil not)
			ifTrue: [ outputStream nextPutAll: aCZDocument footer ]
			ifFalse: [ outputStream nextPutAll: self defaultFooter ] ].
]

{ #category : #visiting }
CZLaTeXOutputer >> visitField: aField [
	
	"We should probably use phrases instead of doing everything ourselves."
	
	aField key = Volume ifTrue: [outputStream nextPutAll: 'Volume '].
	aField key = Pages ifTrue: [outputStream nextPutAll: 'pp. '].

	fieldEmbellishingTable at: aField key ifPresent: [:t | outputStream nextPutAll: ' ', t].
	aField dispatchVisitor: self.
	fieldEmbellishingTable at: aField key ifPresent: [:t | outputStream nextPutAll: '}'].
	aField key = Editor
		ifTrue: [ outputStream nextPutAll: ' ed.'].
]

{ #category : #visiting }
CZLaTeXOutputer >> visitPeople: aCZPeople [

	aCZPeople expandOption: authorDisplay.
	outputStream nextPutAll:  aCZPeople expanded
]

{ #category : #visiting }
CZLaTeXOutputer >> visitString: aCZString [
	outputStream nextPutAll: aCZString notExpanded
]
