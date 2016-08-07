"
A CZVisitor is visitor handling both CZEntries and CZDocuments.
it is a new generation of visitor that should replace the Outputters package.


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
	#category : #'Citezen-Reborn-Core-Visitor'
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
CZVisitor >> visit: anObject [

	^ anObject acceptVisitor: self
]

{ #category : #visiting }
CZVisitor >> visitBibSet: aCZSet [
	
	aCZSet macros do: [ :each | self visit: each ].
	aCZSet entries do: [ :each | self visit: each ].

	
]

{ #category : #visiting }
CZVisitor >> visitComment: aCZCommentElement [
	
]

{ #category : #visiting }
CZVisitor >> visitCompositeValue: aCZCompositeValue [
]

{ #category : #'visiting doc' }
CZVisitor >> visitDoc: aDocument [
	self visitDocTitle: aDocument title. 
	self visit: aDocument header.
	aDocument elements do: [ :each | self visit: each ].
	self visit: aDocument footer.
]

{ #category : #'visiting doc' }
CZVisitor >> visitDocTitle: aTitle [
	self visitString: aTitle

]

{ #category : #visiting }
CZVisitor >> visitEntry: anEntry [
	"Visit a bib entry"
	
	anEntry do: [:each | self visit: each]
	
	
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

{ #category : #visiting }
CZVisitor >> visitMacro: aCZField [
]

{ #category : #visiting }
CZVisitor >> visitMacroReference: aCZMacroReference [
	
]

{ #category : #visiting }
CZVisitor >> visitPeople: aCZPeople [
]

{ #category : #'visiting doc' }
CZVisitor >> visitSection: aSection [

	
]

{ #category : #visiting }
CZVisitor >> visitSet: aSet [	
	
	self visitBibSet: aSet
]

{ #category : #visiting }
CZVisitor >> visitString: aCZString [

	
]
