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

{ #category : #'as yet unclassified' }
CZHTMLGenerator >> visitBibSet: aSet [	
	
	self outputStream nextPutAll: '<ol>'; lf.

	aSet entries do: [ :each | 
		each acceptVisitor: self.
		].
	outputStream nextPutAll: '</ol>'.

]

{ #category : #visiting }
CZHTMLGenerator >> visitDocument: aCZDoc [

	
]

{ #category : #visiting }
CZHTMLGenerator >> visitEntry: anEntry [
	
	| fields |
	fields := anEntry fieldSortedFollowingKeys: fieldOrder. 
	outputStream 
		nextPutAll: '<li>'.
	fields
		 do: [ :each | each acceptVisitor: self]
		 separatedBy: [outputStream nextPutAll: ', '].
	outputStream nextPut: $. .
	outputStream 
		nextPutAll: '</li>'.
]

{ #category : #visiting }
CZHTMLGenerator >> visitSet: aSet [	
	
	self outputStream nextPutAll: '<ol>'; lf.

	aSet entries do: [ :each | 
		each acceptVisitor: self.
		].
	outputStream nextPutAll: '</ol>'.

]
