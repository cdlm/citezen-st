"
Obviously, visits all elements of the document and writes their xHTML equivalent on the output stream.
"
Class {
	#name : #CZHtmlOutputer,
	#superclass : #CZOutputer,
	#category : #'Citezen-Outputers'
}

{ #category : #registration }
CZHtmlOutputer class >> exporterEncoding [

	^ #html
]

{ #category : #default }
CZHtmlOutputer >> defaultFooter [
	^ '</body>
</html>'
]

{ #category : #default }
CZHtmlOutputer >> defaultHeader [
	
	| title |
	title :=  (fileName isEmptyOrNil)
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

{ #category : #visiting }
CZHtmlOutputer >> visitComment: aCZCommentElement [
	outputStream 
		nextPutAll: '<!-- ';
		nextPutAll: aCZCommentElement comment;
		nextPutAll: ' -->';
		cr
]

{ #category : #visiting }
CZHtmlOutputer >> visitCompositeValue: aCZCompositeValue [
	aCZCompositeValue do: 
		[ :each | each acceptVisitor: self] separatedBy: [ outputStream nextPutAll: ' ' ].
]

{ #category : #visiting }
CZHtmlOutputer >> visitDocument: aCZDocument [
	CZAccentuateCharactersParser toHtmlTable.
	
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

{ #category : #visiting }
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

{ #category : #visiting }
CZHtmlOutputer >> visitField: aField [
	outputStream nextPutAll: '<span class="',aField key,'">'.
	
	aField isURL
		ifTrue: [outputStream nextPutAll: '<a href="'].
	aField isDoi
		ifTrue: [outputStream nextPutAll: '<a href="http://dx.doi.org/'].	
	aField dispatchVisitor: self.
	aField isURL
		ifTrue: [outputStream nextPutAll: '">PDF</a>'].
	aField isDoi
		ifTrue: [outputStream nextPutAll: '">DOI</a>'].
	outputStream nextPutAll: '</span>'.
]

{ #category : #visiting }
CZHtmlOutputer >> visitInteger: aCZInteger [
	outputStream nextPutAll: aCZInteger notExpanded asString 
]

{ #category : #visiting }
CZHtmlOutputer >> visitMacroReference: aCZMacroReference [
	outputStream nextPutAll: aCZMacroReference expanded 
]

{ #category : #visiting }
CZHtmlOutputer >> visitPeople: aCZPeople [
	aCZPeople expandOption: authorDisplay.
	outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZPeople expanded)
]

{ #category : #visiting }
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
		outputStream nextPutAll: '</li>';cr ].
	outputStream nextPutAll: endList; cr; cr.
	list isZero ifFalse: [aCZScript document updateNumberOfTreatedEntries: aCZScript generatingCollection size ]

]

{ #category : #visiting }
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

{ #category : #visiting }
CZHtmlOutputer >> visitString: aCZString [
	outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZString notExpanded)
]

{ #category : #visiting }
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
