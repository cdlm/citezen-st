Class {
	#name : #CZPersonalScript,
	#superclass : #Object,
	#classInstVars : [
		'fieldValue',
		'field'
	],
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZPersonalScript class >> initialize [
	field := fieldValue := CZBibField uniqueInstance  
]
