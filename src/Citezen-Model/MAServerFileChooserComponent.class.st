Class {
	#name : #MAServerFileChooserComponent,
	#superclass : #MAElementComponent,
	#category : #'Citezen-Seaside'
}

{ #category : #testing }
MAServerFileChooserComponent class >> isAbstract [
	^ false
]

{ #category : #actions }
MAServerFileChooserComponent >> filePath [
	^ self value
		ifNotNil: [ self value filePath ]
		ifNil: [ '' ]
]

{ #category : #actions }
MAServerFileChooserComponent >> filePath: aString [
	<todo: 'detect mime type'>
	self value: (self description kind fromRio: Cwd / aString)
]

{ #category : #actions }
MAServerFileChooserComponent >> remove [
	self value: nil
]

{ #category : #rendering }
MAServerFileChooserComponent >> renderChooseOn: html [
	html textInput
		attributes: self attributes;
		id: self labelId;
		on: #filePath of: self
]

{ #category : #rendering }
MAServerFileChooserComponent >> renderEditorOn: html [ 
	self renderChooseOn: html
]

{ #category : #rendering }
MAServerFileChooserComponent >> renderRemoveOn: html [
	html anchor
		url: (self value urlOn: html);
		with: self value filename.
	html text: ' ('; render: self value filesize asFileSize; text: ') '.
	html submitButton on: #remove of: self
]

{ #category : #rendering }
MAServerFileChooserComponent >> renderViewerOn: html [
	<todo: 'specified file path (as download link) + existence/size'>
	html render: self value
]
