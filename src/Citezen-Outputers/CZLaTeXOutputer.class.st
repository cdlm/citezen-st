Class {
	#name : #CZLaTeXOutputer,
	#superclass : #CZOutputer,
	#category : #'Citezen-Outputers'
}

{ #category : #'as yet unclassified' }
CZLaTeXOutputer class >> exporterEncoding [

	^ #tex
]

{ #category : #visiting }
CZLaTeXOutputer >> visitComment: aCZCommentElement [

	outputStream 
		nextPutAll: '%%',aCZCommentElement comment;
		lf;
		lf
]
