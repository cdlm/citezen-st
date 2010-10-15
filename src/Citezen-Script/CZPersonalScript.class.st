"
Note that this is not sure that we will use that class.
Better have a look at CZPersonalWebPageGenerator
"
Class {
	#name : #CZPersonalScript,
	#superclass : #Object,
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZPersonalScript class >> me [
	^ ''
]

{ #category : #'as yet unclassified' }
CZPersonalScript class >> notWrittenByMe [
	^ CZUsefulScripts notWrittenBy: self me
]

{ #category : #'as yet unclassified' }
CZPersonalScript class >> writtenByMe [ 
	^ CZUsefulScripts writtenBy: self me
]
