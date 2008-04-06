Class {
	#name : #CZFieldSource,
	#superclass : #CZNode,
	#instVars : [
		'fieldName'
	],
	#category : 'Citezen-Rendering2'
}

{ #category : #'instance creation' }
CZFieldSource class >> field: aName [
	^ self new setFieldName: aName
]

{ #category : #'initialize-release' }
CZFieldSource >> setFieldName: aName [
	fieldName := aName
]

{ #category : #rendering }
CZFieldSource >> streamFrom: anEntry to: aNodeStream [
	(anEntry hasField: fieldName)
		ifTrue: [| node |
			node := (CZNode from: (anEntry at: fieldName) value).
			node origin: fieldName.
			self isVolatile ifTrue: [node beVolatile].
			aNodeStream nextPut: node]
]
