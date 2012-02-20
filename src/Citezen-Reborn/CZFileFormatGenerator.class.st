Class {
	#name : #CZFileFormatGenerator,
	#superclass : #CZVisitor,
	#instVars : [
		'fieldOrder',
		'outputStream',
		'fieldSeparatorString'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #configuration }
CZFileFormatGenerator >> defaultFieldOrder [

	^ #(#author 
			  #title 
			  #journal 
			  #booktitle 
			  #volume 
			  #pages 
			  #publisher  
			  #year 
			  #impactfactor 
			  #rate 
			  #url 
			  #doi)
]

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

{ #category : #accessing }
CZFileFormatGenerator >> fieldOrder [
	^ fieldOrder 
]

{ #category : #accessing }
CZFileFormatGenerator >> fieldOrder: anObject [
	fieldOrder := anObject
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
	fieldOrder := self defaultFieldOrder.
	"by default we write to a simple in memory stream"
	self outputStream:  String new writeStream.
	self fieldSeparatorString: self defaultFieldSeparatorString
]

{ #category : #visit }
CZFileFormatGenerator >> line [
	"so that we can change that after"
	self outputStream lf
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
CZFileFormatGenerator >> visit: anObject [

	anObject acceptVisitor: self.
]

{ #category : #'as yet unclassified' }
CZFileFormatGenerator >> visitBibSet: aSet [

	self line.
	aSet entries do: [ :each | 
		each acceptVisitor: self].
	self line.
]

{ #category : #visit }
CZFileFormatGenerator >> visitDoc: aCZDoc [

	CZAccentuateCharactersParser toAccentedCharTable.
	super visitDocument: aCZDoc
]

{ #category : #visit }
CZFileFormatGenerator >> visitEntry: anEntry [


	self emitEntryHeader: anEntry.

	(anEntry fields reject: [ :aField | (blackListedFields includes: aField key)])
		do: [ :each | each acceptVisitor: self ]
		separatedBy: [ self outputStream nextPutAll: self fieldSeparatorString].		
	"we should pay attention since the order should also be respected"

	self emitEntryFooter: anEntry
]

{ #category : #visit }
CZFileFormatGenerator >> visitField: aField [
	
	aField dispatchVisitor: self
]

{ #category : #visit }
CZFileFormatGenerator >> visitPeople: aCZPeople [

	aCZPeople perform:  expandOption.
	self outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZPeople expanded)
]

{ #category : #visit }
CZFileFormatGenerator >> visitSet: aSet [

	self line.
	aSet entries do: [ :each | 
		each acceptVisitor: self].
	self line.
]

{ #category : #visit }
CZFileFormatGenerator >> visitString: aCZString [

	self outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZString notExpanded)
]
