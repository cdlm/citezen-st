"
to generate bibtex out of bibset entries :)
"
Class {
	#name : #CZBibTexGenerator,
	#superclass : #CZFileFormatGenerator,
	#category : #'Citezen-Reborn'
}

{ #category : #entries }
CZBibTexGenerator >> emitEntryFooter: anEntry [
	self outputStream nextPut: $}.
	self line ; line

]

{ #category : #entries }
CZBibTexGenerator >> emitEntryHeader: anEntry [
	"Add to the outputStream @type{key e.g.., @inproceedings{Key90a,"
	self outputStream  
		nextPut: $@;
		nextPutAll: anEntry type;
		nextPut: ${;
		nextPutAll: anEntry key;
		nextPut: $,.
	self line
	
]

{ #category : #visiting }
CZBibTexGenerator >> emitFieldSeparation [

	super emitFieldSeparation.
	self line.
]

{ #category : #visiting }
CZBibTexGenerator >> visitComment: aCZCommentElement [
	self outputStream 
		nextPut: $#;
		nextPutAll: aCZCommentElement text.
	self line.
]

{ #category : #visiting }
CZBibTexGenerator >> visitField: aField [

	self outputStream 
		nextPutAll: '  ';
		nextPutAll: aField key;
		nextPutAll: ' = '.
	aField dispatchVisitor: self.
]

{ #category : #visiting }
CZBibTexGenerator >> visitFooter: aCZString [
	"we do not anything so that we do have to pay attention to footer if we got a document"
		
]

{ #category : #visiting }
CZBibTexGenerator >> visitHeader: aCZString [
	"we do not anything so that we do have to pay attention to header if we got a document"
		
]

{ #category : #visiting }
CZBibTexGenerator >> visitMacro: aCZField [
	self outputStream nextPutAll: '@string{'.
	self visitField: aCZField. 
	self outputStream nextPutAll: ' }'.
	self line
]

{ #category : #visiting }
CZBibTexGenerator >> visitPeople: aCZPeople [

	self outputStream nextPut: ${.
	aCZPeople perform: expandOption.
	outputStream nextPutAll: aCZPeople expanded.
	self outputStream nextPut: $}.
]

{ #category : #visiting }
CZBibTexGenerator >> visitSection: aCSection [
	"we do not anything so that we do have to pay attention to section if we got a document"
		
]

{ #category : #visiting }
CZBibTexGenerator >> visitSet: aSet [	
	
	aSet macros do: [ :each | 
		each acceptVisitor: self].
	self line.
	aSet entries do: [ :each | 
		each acceptVisitor: self].
	
]

{ #category : #visiting }
CZBibTexGenerator >> visitString: aCZString [
	self outputStream 
		nextPut: ${;
		nextPutAll: aCZString notExpanded; 
		nextPut: $}
]
