"
A CZHTMLGenerator is generating nice html for us. 

| visitor bibset |
bibset := CZBibParser parse: (FileStream readOnlyFileNamed: 'rmod.bib') contents.
bibset scope: CZSet standardDefinitions.
visitor := CZHTMLGenerator new filename: 'rmod-Generated.html'.
visitor visit: bibset.

"
Class {
	#name : #CZHTMLGenerator,
	#superclass : #CZFileFormatGenerator,
	#category : #'Citezen-Reborn-FormattingVisitors'
}

{ #category : #configuration }
CZHTMLGenerator >> defaultFooter [
	^ '</body>
</html>' withUnixLineEndings
]

{ #category : #configuration }
CZHTMLGenerator >> defaultHeader [
	
	"should probably do something for the title"
	
	^ ('<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8" />
	<head>
		<title>  Put A title here  </title>
	</head>
<body>

') withUnixLineEndings
]

{ #category : #entries }
CZHTMLGenerator >> emitEntryFooter: anEntry [

	super emitEntryFooter: anEntry.
	self outputStream nextPutAll: '</li>'.
	self line.
]

{ #category : #entries }
CZHTMLGenerator >> emitEntryHeader: anEntry [

	self outputStream nextPutAll: '<li>'.
	self line.
]

{ #category : #initialization }
CZHTMLGenerator >> initialize [
	super initialize.
	self setEncodedCharacterTransformationTable.
]

{ #category : #'string encoding hooks' }
CZHTMLGenerator >> setEncodedCharacterTransformationTable [
	^ CZAccentuateCharactersParser toHtmlTable
]

{ #category : #'string encoding hooks' }
CZHTMLGenerator >> treatTexEncoding: aString [
	"we want the HTML encodings to tex encoded characters"

	^ CZAccentuateCharactersParser parse: aString
]

{ #category : #visit }
CZHTMLGenerator >> visitBibSet: aSet [	
	
	self outputStream nextPutAll: '<ol>'.
	self line.

	aSet entries do: [ :each | 
		each acceptVisitor: self.
		].
	outputStream nextPutAll: '</ol>'.

]

{ #category : #visiting }
CZHTMLGenerator >> visitComment: aCZCommentElement [
	self outputStream 
		nextPutAll: '<!-- ';
		nextPutAll: aCZCommentElement comment;
		nextPutAll: ' -->'.
	self line
]

{ #category : #visiting }
CZHTMLGenerator >> visitDoc: aCZDoc [
	self setEncodedCharacterTransformationTable.
	super visitDoc: aCZDoc
]

{ #category : #visiting }
CZHTMLGenerator >> visitField: aField [

	self outputStream nextPutAll: '<span class="',aField key,'">'.
	
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
CZHTMLGenerator >> visitMacroReference: aCZMacroReference [
	outputStream nextPutAll: aCZMacroReference expanded 
]

{ #category : #visiting }
CZHTMLGenerator >> visitPeople: aCZPeople [
	"self halt: aCZPeople printString."
	aCZPeople perform: expandOption.
	outputStream nextPutAll: (self treatString: aCZPeople expanded)
]

{ #category : #visiting }
CZHTMLGenerator >> visitSectionTitle: aCZString [
	outputStream
		nextPutAll: '<h4';
		nextPutAll: '>';
		nextPutAll:
			(self treatString: aCZString expanded);
		nextPutAll: '</h4';
		nextPutAll: '>'.
	self
		line;
		line
]

{ #category : #visiting }
CZHTMLGenerator >> visitTitle: aCZTitleElement [
	"this is not the same title: here this is the still the legacy from CZDocument of adrian"
	
	outputStream 
		nextPutAll: '<h4'; 
		nextPutAll: '>';
		nextPutAll: (self treatString: aCZTitleElement title);
		nextPutAll: '</h4';
		nextPutAll: '>'.
	self line ; line. 
]
