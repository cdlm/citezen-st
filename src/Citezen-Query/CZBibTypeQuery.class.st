Class {
	#name : #CZBibTypeQuery,
	#superclass : #CZBibGeneralQuery,
	#category : #'Citezen-Query'
}

{ #category : #'as yet unclassified' }
CZBibTypeQuery >> value: aCZEntry [
	^ super value: aCZEntry type
]
