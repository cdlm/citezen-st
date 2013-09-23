"
A CZVisitor is visitor handling both CZEntries and CZDocuments.
it is a new generation of visitor that should replace the Outputters package.


todo: 
CZVisitor should handle blackListedFields as the old CZBibtexOutputer was used to.

visitEntry: anEntry
	self emitEntryHeader: anEntry.
	(anEntry fields reject: [ :aField | (blackListedFields includes: aField key)])
		do: [ :each | each acceptVisitor: self ]
		separatedBy: [ outputStream nextPut: self fieldSeparator; lf ].
	self emitEntryFooter: anEntry
	

- what is the difference between visitSet: and visitBibSet:
this should be addressed

- write a couple of test for CZBibTexGenerator!

"
Class {
	#name : #CZVisitor,
	#superclass : #Object,
	#instVars : [
		'expandOption',
		'fieldOrder'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #accessing }
CZVisitor >> authorNameExpandOption [
	"returns the name author display option: "
	^ expandOption


]

{ #category : #configuration }
CZVisitor >> defaultFieldOrder [

	^ #(#author 
			  #title 
			  #chapter
			  #journal 
			  #booktitle 
			  #volume 
			  #pages 
			  #publisher  
			  #year 
			  #impactfactor 
			  #misc 
			  #url 
			  #doi)
			"rate is bad because it does not have enough information"
]

{ #category : #accessing }
CZVisitor >> fieldOrder [
	^ fieldOrder 
]

{ #category : #accessing }
CZVisitor >> fieldOrder: aCollection [
	"The collection of field aCollection is used to filter and order the fields. You can then customize to filter private fields, web information and others."

	fieldOrder := aCollection
]

{ #category : #'initialize-release' }
CZVisitor >> initialize [

	super initialize.
	self setAuthorDisplayAsFullName.
	fieldOrder := self defaultFieldOrder.

]

{ #category : #configuration }
CZVisitor >> setAuthorDisplayAsFullName [

	expandOption := #displayFullName
]

{ #category : #configuration }
CZVisitor >> setAuthorDisplayAsNormalizedName [

	expandOption := #displayNormalizedName
]

{ #category : #configuration }
CZVisitor >> setAuthorDisplayAsShortenedName [

	expandOption := #displayShortenedName
]

{ #category : #visiting }
CZVisitor >> visitBibSet: aCZSet [
	
	aCZSet macros do: [ :each | each acceptVisitor: self].
	aCZSet entries do: [ :each | each acceptVisitor: self].

	
]

{ #category : #visiting }
CZVisitor >> visitComment: aCZCommentElement [
	
]

{ #category : #'visiting doc' }
CZVisitor >> visitCompositeValue: aCZCompositeValue [
]

{ #category : #'visiting doc' }
CZVisitor >> visitDoc: aDocument [

	aDocument header acceptVisitor: self.
	aDocument elements do: [ :each | each acceptVisitor: self ].
	aDocument footer acceptVisitor: self.
]

{ #category : #'as yet unclassified' }
CZVisitor >> visitEntry: anEntry [
	"Visit a bib entry"
	
	
]

{ #category : #'visiting doc' }
CZVisitor >> visitFooter: aCZHeader [


	
]

{ #category : #'visiting doc' }
CZVisitor >> visitHeader: aCZHeader [


	
]

{ #category : #visiting }
CZVisitor >> visitInteger: aCZInteger [
	
	self outputStream nextPutAll:  aCZInteger notExpanded asString 
]

{ #category : #'visiting doc' }
CZVisitor >> visitMacro: aCZField [
]

{ #category : #'visiting doc' }
CZVisitor >> visitMacroReference: aCZMacroReference [
	
]

{ #category : #visiting }
CZVisitor >> visitPeople: aCZPeople [
]

{ #category : #'visiting doc' }
CZVisitor >> visitSection: aSection [

	
]

{ #category : #visiting }
CZVisitor >> visitString: aCZString [

	
]
