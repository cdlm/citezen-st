"
A CZFileFormatGenerator is mainly generating text into a stream.
Its subclasses are more interested.
"
Class {
	#name : #CZFileFormatGenerator,
	#superclass : #CZVisitor,
	#instVars : [
		'outputStream',
		'fieldSeparatorString'
	],
	#category : #'Citezen-Reborn-FormattingVisitors'
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

{ #category : #'header/footer hooks' }
CZFileFormatGenerator >> emitEntryFooter: anEntry [

	self outputStream nextPut: $..
	self line
]

{ #category : #'header/footer hooks' }
CZFileFormatGenerator >> emitEntryHeader: anEntry [
	"Add to the outputStream a header for the correponding anEntry if needed."
]

{ #category : #visit }
CZFileFormatGenerator >> emitFieldSeparation [
	^ self outputStream nextPutAll: self fieldSeparatorString
]

{ #category : #accessing }
CZFileFormatGenerator >> expansionPolicyAppliedTo: aCZString [
	^ aCZString notExpanded
]

{ #category : #accessing }
CZFileFormatGenerator >> fieldSeparatorString [

	^ fieldSeparatorString
]

{ #category : #accessing }
CZFileFormatGenerator >> fieldSeparatorString: aString [

	fieldSeparatorString := aString
]

{ #category : #'file helper' }
CZFileFormatGenerator >> filename: aString [
	outputStream := FileStream forceNewFileNamed: aString
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

{ #category : #'string encoding hooks' }
CZFileFormatGenerator >> setEncodedCharacterTransformationTable [
	"I do not nothing since for bib bbl treatTexEncoding should do nothing. Now in Pillar I should use accentedchars and HTML html ones."

	
]

{ #category : #'string encoding hooks' }
CZFileFormatGenerator >> treatSignsInString: aString [
	"By default do nothing because subclasses may apply way to handle strange characters such as _ \ and others. For example for latex _ is a special character for pillar too."

	^ aString
]

{ #category : #'string encoding hooks' }
CZFileFormatGenerator >> treatString: aString [
	"There are two aspects that should be covered: 
		- handling tex encodings ie. \' or \& or \'{o} to be turned into the correct glyph
		- strange characters that are meta characters in different outputs."

	^ (self treatSignsInString: (self treatTexEncoding: aString))
]

{ #category : #'string encoding hooks' }
CZFileFormatGenerator >> treatTexEncoding: aString [
	"How to handle the text accent encoding such as \'e 
	parse: use the previously set table 
		toHtmlTable    -> <acute>...
		toAccentedCharTable -> à
	"

	"This method will do nothing in bib, latex and bbl formats."
	"Check implementors of setEncodedCharacterTransformationTable."

	^ CZAccentuateCharactersParser parse: aString
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
		ifTrue: [ self outputStream nextPutAll: aCZFooter text ]
		ifFalse: [ self outputStream nextPutAll: self defaultFooter ]
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
	aCZPeople perform: expandOption.
	self outputStream
		nextPutAll: (self treatString: aCZPeople expanded)
			
]

{ #category : #visit }
CZFileFormatGenerator >> visitSection: aCZSection [

	self visitSectionTitle: aCZSection title. 
	self visitSectionText: aCZSection text.
	self visitSectionItems: aCZSection items
]

{ #category : #visit }
CZFileFormatGenerator >> visitSectionItems: aCZSet [

	aCZSet acceptVisitor: self. 
	"should kick in visitBibset:"
]

{ #category : #visit }
CZFileFormatGenerator >> visitSectionText: aCZText [

	aCZText acceptVisitor: self. 
	
]

{ #category : #visit }
CZFileFormatGenerator >> visitSectionTitle: aCZString [
	self outputStream
		nextPutAll:
			(self treatString: aCZString expanded)
]

{ #category : #visit }
CZFileFormatGenerator >> visitString: aCZString [

	self outputStream nextPutAll: 
		(self treatString: aCZString notExpanded)
]

{ #category : #visit }
CZFileFormatGenerator >> visitText: aCZText [
	self outputStream
		nextPutAll: (self treatString: aCZText text).
	self line
]

{ #category : #visit }
CZFileFormatGenerator >> visitValue: aValue [
	self halt: aValue
]
