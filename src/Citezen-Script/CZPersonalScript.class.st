"
Note that this is not sure that we will use that class.
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
	^ CZUsefullScripts notWrittenBy: self me
]

{ #category : #'as yet unclassified' }
CZPersonalScript class >> writtenByMe [ 
	^ CZUsefullScripts writtenBy: self me
]
