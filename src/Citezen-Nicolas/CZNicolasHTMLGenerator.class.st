Class {
	#name : #CZNicolasHTMLGenerator,
	#superclass : #CZHTMLGenerator,
	#category : #'Citezen-Nicolas'
}

{ #category : #visit }
CZNicolasHTMLGenerator >> visitBibSet: aSet [	
	
	self outputStream nextPutAll: '<ol class="bibliography">'.
	self line.

	aSet entries do: [ :each | 
		each acceptVisitor: self.
		].
	outputStream nextPutAll: '</ol>'.

]

{ #category : #visit }
CZNicolasHTMLGenerator >> visitSectionTitle: aCZString [
	outputStream
		nextPutAll: '<h3>';
		nextPutAll:
			(self treatString: aCZString expanded);
		nextPutAll: '</h3>'.
	self
		line;
		line
]
