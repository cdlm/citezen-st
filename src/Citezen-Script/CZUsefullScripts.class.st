"
Some useful scripts, on class side.

Not sure that we will use that for now we should learn and see. 
"
Class {
	#name : #CZUsefullScripts,
	#superclass : #Object,
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZUsefullScripts class >> notWrittenBy: aString [ 
	| script |
	
	script := (CZScript new).
	(aString = '')
		ifFalse: [
			script query: (CZUsefullQueries dontMatchAuthor: aString)].
		
	^ script
]

{ #category : #'as yet unclassified' }
CZUsefullScripts class >> withoutInriaFields [
	^ (CZScript new)
		"displayPattern: (CZDisplayPattern new beginWith:'<br />&nbsp;&nbsp;Infos : '; endWith: '.'; defaultSeparator: ', '; field: #year; separator: '  ->  ';field: #author);"
		"displayPattern: (CZDisplayPattern new field: #*; defaultSeparator: '::');"
		fieldsToRemove: #(aeres aeresstatus selectif inria hal misc rate keywords x-pays x-country x-editorial-board x-proceedings x-international-audience type_rapport)
]

{ #category : #'as yet unclassified' }
CZUsefullScripts class >> writtenBy: aString [ 
	| script |
	
	script := (CZScript new).
	(aString = '')
		ifFalse: [
			script query: (CZUsefullQueries matchAuthor: aString)].
		
	^ script
]
