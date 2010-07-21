"
CZDisplayPattern purpose is to create the syntax to print an entry.
It can be ignored by some outputer (e.g. if the output format is BibTeX) because the output format has to respect a syntax.

Example:
CZDisplayPattern new 
	defaultSeparator: '*****';
	beginsWith: '-->';
	field: #year;
	separator: ';;;';
	field: #annote;
	field: #*;
	endsWith: '<--'.
	
There are many messages to know:
- defaultSeparator: aString -> this is the default separator used to separate the fields. By default, it's a space. If you want to change that, make sure this is the FIRST message you send to your display pattern, because it changes the default separator for the next fields, it doesn't change the previous separators.
- beginsWith: aString -> a string put before all entries (empty by default)
- endsWith: aString -> a string put after all entries (empty by default)
- field: aSymbol -> specifies a field to display; if the last thing you added to the display pattern was a field, the default separator is automatically inserted before added this new field.
- separator: aString -> add a separator ; if you add two separators between two fields, they will be concatenated
CZDisplayPattern new
	field: #author;
	separator: ' ***';
	separator: '*** ';
	field: #*
is equivalent to: 
CZDisplayPattern new
	field: #author;
	separator: ' ****** ';
	field: #*
"
Class {
	#name : #CZDisplayPattern,
	#superclass : #Object,
	#instVars : [
		'lastAddWasField',
		'fields',
		'separators',
		'defaultSeparator',
		'begin',
		'end',
		'changed'
	],
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZDisplayPattern >> begin [
	^ begin 
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> beginsWith: aString [
	begin := (aString ifNil: [ '' ]) 
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> defaultSeparator [ 
	^ defaultSeparator 
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> defaultSeparator: aString [
	defaultSeparator := (aString ifNil: [ '' ])
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> end [
	^ end
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> endsWith: aString [
	end := (aString ifNil: [ '' ]) 
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> field: aSymbol [
	(changed) ifFalse: [ changed := true. fields := OrderedCollection new].
	
	(aSymbol isNil) ifFalse: [
		lastAddWasField ifTrue: [ separators add: defaultSeparator ].
		fields add: aSymbol asLowercase asSymbol.
		lastAddWasField := true ]
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> fields [ 
	^ OrderedCollection new addAll: fields; yourself
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> initialize [
	lastAddWasField := false.
	changed := false.
	fields := OrderedCollection new add: #*; yourself.
	separators := OrderedCollection new.
	begin := end := defaultSeparator := ' '
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> separator: aString [
	lastAddWasField 
		ifFalse: [ 
			| sep |
			sep := separators removeLast.
			aString isEmptyOrNil ifFalse: [ sep := sep, aString  ].
			separators add: sep ]
		ifTrue: [
			separators add: (aString ifNil: [ defaultSeparator ]).
			lastAddWasField := false ]
]

{ #category : #'as yet unclassified' }
CZDisplayPattern >> separators [ 
	^ OrderedCollection new addAll: separators; yourself
]
