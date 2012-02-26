"
A CZHTMLGenerator is generating nice html for us. 
"
Class {
	#name : #CZHTMLGenerator,
	#superclass : #CZFileFormatGenerator,
	#category : #'Citezen-Reborn'
}

{ #category : #configuration }
CZHTMLGenerator >> defaultFooter [
	^ '</body>
</html>' withUnixLineEndings
]

{ #category : #configuration }
CZHTMLGenerator >> defaultHeader [
	
	"should probably do something for the title"
	
	^ ('<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" >
	<head>
		<title>    </title>
		<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
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

{ #category : #'as yet unclassified' }
CZHTMLGenerator >> visitBibSet: aSet [	
	
	self outputStream nextPutAll: '<ol>'; lf.

	aSet entries do: [ :each | 
		each acceptVisitor: self.
		].
	outputStream nextPutAll: '</ol>'.

]

{ #category : #visiting }
CZHTMLGenerator >> visitDoc: aCZDoc [

	CZAccentuateCharactersParser toHtmlTable.
	super visitDoc: aCZDoc.
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
CZHTMLGenerator >> visitPeople: aCZPeople [

	aCZPeople perform: expandOption.
	outputStream nextPutAll: (CZAccentuateCharactersParser parse: aCZPeople expanded)
]

{ #category : #visiting }
CZHTMLGenerator >> visitSection: aCZSection [
	
	outputStream 
		nextPutAll: '<h4'; 
		nextPutAll: '>';
		nextPutAll: (CZAccentuateCharactersParser parse: aCZSection name);
		nextPutAll: '</h4';
		nextPutAll: '>';
		lf;
		lf
]

{ #category : #visiting }
CZHTMLGenerator >> visitSet: aSet [	
	
	self outputStream nextPutAll: '<ol>'; lf.

	aSet entries do: [ :each | 
		each acceptVisitor: self.
		].
	outputStream nextPutAll: '</ol>'.

]

{ #category : #visiting }
CZHTMLGenerator >> visitTitle: aCZTitleElement [
	"this is not the same title: here this is the still the legacy from CZDocument of adrian"
	
	outputStream 
		nextPutAll: '<h4'; 
		nextPutAll: '>';
		nextPutAll: (CZAccentuateCharactersParser parse: aCZTitleElement title);
		nextPutAll: '</h4';
		nextPutAll: '>';
		lf;
		lf
]
