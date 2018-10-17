Class {
	#name : #CZRmodKeywordLsePubRule,
	#superclass : #CZRmodRule,
	#category : 'Citezen-Checking'
}

{ #category : #'as yet unclassified' }
CZRmodKeywordLsePubRule >> condition: aCZEntry [
	^ (aCZEntry hasField: #keyword)
		ifFalse: [ false ]
		ifTrue: [ '*lse-pub*' match: (aCZEntry at: #keyword) rawValue ]
]

{ #category : #'as yet unclassified' }
CZRmodKeywordLsePubRule >> explanation [
	^ '(Inria) Must have field #keyword including "lse-pub"'
]

{ #category : #'as yet unclassified' }
CZRmodKeywordLsePubRule >> hasPostAction [ 
	^ true
]

{ #category : #'as yet unclassified' }
CZRmodKeywordLsePubRule >> postAction: aCZEntry [
	(aCZEntry at: #keyword) isUndefined 
		ifTrue: [ aCZEntry at: #keyword put: 'lse-pub' ]
		ifFalse: [ aCZEntry at: #keyword put: (aCZEntry at: #keyword) value, ' lse-pub' ]
]
