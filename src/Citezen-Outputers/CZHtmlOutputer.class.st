Class {
	#name : #CZHtmlOutputer,
	#superclass : #CZOutputer,
	#category : #'Citezen-Outputers'
}

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> footer [
	^ '
</body>
</html>
	'
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> header [
	^ '<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="fr" >
	<head>
		<title>Bib -> Html</title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	</head>
<body>
	'
]

{ #category : #'as yet unclassified' }
CZHtmlOutputer >> visitCompositeValue: aCZCompositeValue [
	aCZCompositeValue do: 
		[ :each | each acceptVisitor: self] separatedBy: [ outputStream nextPutAll: ' ' ].
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
	aField dispatchVisitor: self.
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
	outputStream nextPutAll: aCZPeople notExpanded
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
	outputStream nextPutAll: aCZString notExpanded
]
