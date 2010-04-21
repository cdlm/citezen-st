Class {
	#name : #CZBibKeyQuery,
	#superclass : #CZBibGeneralQuery,
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZBibKeyQuery >> value: aCZEntry [
	^ super value: aCZEntry key
]
