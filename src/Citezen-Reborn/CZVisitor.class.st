"
A CZVisitor is visitor handling both CZEntries and CZDocuments
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
	
	aCZSet entries do: [ :each | each acceptVisitor: self].

	
]

{ #category : #'visiting doc' }
CZVisitor >> visitDoc: aDocument [

	aDocument elements do: [ :each | each acceptVisitor: self ]
]

{ #category : #visiting }
CZVisitor >> visitInteger: aCZInteger [
	
	self outputStream nextPutAll:  aCZInteger notExpanded asString 
]

{ #category : #'visiting doc' }
CZVisitor >> visitMacroReference: aCZMacroReference [
	
]

{ #category : #'visiting doc' }
CZVisitor >> visitSection: aSection [

	
]

{ #category : #visiting }
CZVisitor >> visitSet: aCZSet [
	
	aCZSet entries do: [ :each | each acceptVisitor: self].

	
]
