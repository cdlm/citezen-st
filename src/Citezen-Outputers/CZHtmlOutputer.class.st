"
Obviously, visits all elements of the document and writes their xHTML equivalent on the output stream.
"
Class {
	#name : #CZHtmlOutputer,
	#superclass : #CZOutputer,
	#instVars : [
		'accentuateCharChecker'
	],
	#category : #'Citezen-Outputers'
}

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> defaultFooter [
	^ '</body>
</html>'
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> defaultHeader [
	| title |
	
	title := 
		(fileName isEmptyOrNil)
			ifTrue: [ 'default.html' ]
			ifFalse: [ fileName ].
	
	^ '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >
	<head>
		<title>',title,'</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	</head>
<body>

'
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitComment: aCZCommentElement [
	outputStream 
		nextPutAll: '<!-- ';
		nextPutAll: aCZCommentElement comment;
		nextPutAll: ' -->';
		cr
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitCompositeValue: aCZCompositeValue [
	aCZCompositeValue do: 
		[ :each | each acceptVisitor: self] separatedBy: [ outputStream nextPutAll: ' ' ].
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitDocument: aCZDocument [
	aCZDocument getWithoutHeaderAndFooter ifFalse: [
		(aCZDocument header isNil not)
			ifTrue: [ outputStream nextPutAll: aCZDocument header ]
			ifFalse: [ outputStream nextPutAll: self defaultHeader ] ].
	
	aCZDocument elements do: [ :each | each acceptVisitor: self ].
	
	aCZDocument getWithoutHeaderAndFooter ifFalse: [
		(aCZDocument footer isNil not)
			ifTrue: [ outputStream nextPutAll: aCZDocument footer ]
			ifFalse: [ outputStream nextPutAll: self defaultFooter ] ].
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitEntry: anEntry [
	| fields index sep|
	index := 1.
	fields := anEntry fields.
	lastEntryVisited := lastEntryVisited + 1.
	
	
	sep := separators at: lastEntryVisited.
	outputStream nextPutAll: (sep at: 1 ifAbsent: 'Hop').
	fields do: [ :each |
		each acceptVisitor: self.
		outputStream nextPutAll: (sep at: (index := index + 1) ifAbsent: 'poh')].
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitField: aField [
	outputStream nextPutAll: '<span class="',aField key,'">'.
	aField dispatchVisitor: self.
	outputStream nextPutAll: '</span>'.
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitInteger: aCZInteger [
	outputStream nextPutAll: aCZInteger notExpanded asString 
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitMacroReference: aCZMacroReference [
	outputStream nextPutAll: aCZMacroReference expanded 
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitPeople: aCZPeople [
	outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZPeople notExpanded)
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitScript: aCZScript [
	| list beginList endList entry fields sep |
	
	aCZScript generate.
	
	list := aCZScript document listIndex.
	(list = 0)
		ifTrue: [ beginList := '<ul>'. endList := '</ul>' ]
		ifFalse: [ beginList := '<ol start="', list asString, '">'. endList := '</ol>'].
		
	outputStream nextPutAll: beginList; cr.
	
	aCZScript generatingCollection do: [ :assoc |
		entry := assoc key.
		fields := assoc value key.
		sep := assoc value value.
		
		outputStream nextPutAll: '<li>'.
		1 to: fields size do: [ :cpt | 
			outputStream nextPutAll: (sep at: cpt).
			(entry at: (fields at: cpt)) acceptVisitor: self ].
		outputStream nextPutAll: sep last.
		outputStream nextPutAll: '</li>';cr
	].
	
	outputStream nextPutAll: endList; cr; cr.
	
	(list = 0) ifFalse: [
	aCZScript document addEntriesDisplayed: aCZScript generatingCollection size ]

]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitSet: aSet [	
	lastEntryVisited := 0.
	
	outputStream nextPutAll: self header.
	outputStream nextPutAll: '<ol>';cr.
	
	aSet entries do: [ :each | 
		outputStream nextPutAll: '<li>';
			cr; 
			nextPutAll: each type;
			nextPutAll: ' : ';
			nextPutAll: each key;
			cr.
		each acceptVisitor: self.
		outputStream cr; nextPutAll: '</li>'; cr; cr.].
	
	outputStream nextPutAll: '</ol>'.
	outputStream nextPutAll: self footer.
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitString: aCZString [
	outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZString notExpanded)
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitTitle: aCZTitleElement [
	outputStream 
		nextPutAll: '<h'; 
		nextPutAll: aCZTitleElement htmlLevel asString;
		nextPutAll: '>';
		nextPutAll: aCZTitleElement title;
		nextPutAll: '</h';
		nextPutAll: aCZTitleElement htmlLevel asString;
		nextPutAll: '>';
		cr;
		cr
]
