"
A CZFileFormatGenerator is mainly generated text into a file.
Its subclasses are more interested.
"
Class {
	#name : #CZFileFormatGenerator,
	#superclass : #CZVisitor,
	#instVars : [
		'outputStream',
		'fieldSeparatorString'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #configuration }
CZFileFormatGenerator >> defaultFieldSeparatorString [
	^ ', '
]

{ #category : #configuration }
CZFileFormatGenerator >> defaultFooter [
	^ ''
]

{ #category : #configuration }
CZFileFormatGenerator >> defaultHeader [
	^ ''
]

{ #category : #entries }
CZFileFormatGenerator >> emitEntryFooter: anEntry [

	self outputStream nextPut: $..
	self line
]

{ #category : #entries }
CZFileFormatGenerator >> emitEntryHeader: anEntry [
	"Add to the outputStream a header for the correponding anEntry if needed."
]

{ #category : #visit }
CZFileFormatGenerator >> emitFieldSeparation [
	^ self outputStream nextPutAll: self fieldSeparatorString
]

{ #category : #accessing }
CZFileFormatGenerator >> fieldSeparatorString [

	^ fieldSeparatorString
]

{ #category : #accessing }
CZFileFormatGenerator >> fieldSeparatorString: aString [

	fieldSeparatorString := aString
]

{ #category : #accessing }
CZFileFormatGenerator >> filename: aString [

	outputStream := FileStream newFileNamed: aString 
]

{ #category : #initialize }
CZFileFormatGenerator >> initialize [
	
	super initialize.
	"by default we write to a simple in memory stream"
	self outputStream:  String new writeStream.
	self fieldSeparatorString: self defaultFieldSeparatorString
]

{ #category : #visit }
CZFileFormatGenerator >> line [
	"so that we can change that after"
	self outputStream crlf
]

{ #category : #accessing }
CZFileFormatGenerator >> outputStream [

	^ outputStream
]

{ #category : #accessing }
CZFileFormatGenerator >> outputStream: aStream [

	outputStream := aStream
]

{ #category : #visit }
CZFileFormatGenerator >> treatString: aString [

	
]

{ #category : #visit }
CZFileFormatGenerator >> visit: anObject [

	anObject acceptVisitor: self.
]

{ #category : #visit }
CZFileFormatGenerator >> visitBibSet: aSet [

	self line.
	super visitBibSet: aSet.
	self line.
]

{ #category : #visit }
CZFileFormatGenerator >> visitComment: aCZCommentElement [
	super visitComment: aCZCommentElement.
	self line.
]

{ #category : #visit }
CZFileFormatGenerator >> visitCompositeValue: aCZCompositeValue [
	aCZCompositeValue 
		do: [ :each | each acceptVisitor: self] 
		separatedBy: [ self outputStream nextPutAll: ' ' ].
]

{ #category : #'visit doc' }
CZFileFormatGenerator >> visitDoc: aCZDocument [
	"CZAccentuateCharactersParser toAccentedCharTable."
	"i do not get how I can go from  \'e to é"
	
	super visitDoc: aCZDocument
	
]

{ #category : #visit }
CZFileFormatGenerator >> visitEntry: anEntry [
	| fields |
	fields := anEntry fieldSortedFollowingKeys: fieldOrder.
	self emitEntryHeader: anEntry.
	fields 
		do: [ :each | each acceptVisitor: self ] 
		separatedBy: [ self emitFieldSeparation ].
	self emitEntryFooter: anEntry
]

{ #category : #visit }
CZFileFormatGenerator >> visitField: aField [
	"this is not good since it shortcuts the visitString: ... we will see later
	in particular for document like section we do not want to generate CZString for now.
	may be we should."
	
	self outputStream nextPutAll: aField value asString.
	
]

{ #category : #'visit doc' }
CZFileFormatGenerator >> visitFooter: aCZFooter [

	aCZFooter isDefined
		ifTrue: [self outputStream nextPutAll: aCZFooter text]
		ifFalse: [self outputStream nextPutAll: self defaultFooter]
]

{ #category : #'visit doc' }
CZFileFormatGenerator >> visitHeader: aCZHeader [

	aCZHeader isDefined
		ifTrue: [self outputStream nextPutAll: aCZHeader text]
		ifFalse: [self outputStream nextPutAll: self defaultHeader].
	self line.
]

{ #category : #visit }
CZFileFormatGenerator >> visitMacroReference: aCZMacroReference [
	self outputStream nextPutAll: aCZMacroReference expanded 
]

{ #category : #visit }
CZFileFormatGenerator >> visitPeople: aCZPeople [

	aCZPeople perform:  expandOption.
	"self outputStream nextPutAll: aCZPeople expanded"
	self halt.
	self outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZPeople expanded)
			
]

{ #category : #visit }
CZFileFormatGenerator >> visitSection: aCZSection [

	self outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZSection name)
]

{ #category : #visit }
CZFileFormatGenerator >> visitString: aCZString [

	self outputStream nextPutAll: 
		(self treatString: (CZAccentuateCharactersParser parse: aCZString notExpanded))
]
