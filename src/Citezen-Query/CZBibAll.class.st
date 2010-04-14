Class {
	#name : #CZBibAll,
	#superclass : #CZBibQuery,
	#category : #'Citezen-Query'
}

{ #category : #testing }
CZBibAll >> = aBibquery [
	^ self class = aBibquery class
]

{ #category : #printing }
CZBibAll >> queryString [
	^ 'true'
]

{ #category : #public }
CZBibAll >> value: aBibEntry [
	^ true
]
