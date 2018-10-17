Class {
	#name : #CZRule,
	#superclass : #Object,
	#category : 'Citezen-Checking'
}

{ #category : #'as yet unclassified' }
CZRule >> check: aCZEntry [
	(self preCondition: aCZEntry) ifFalse: [ ^ true ].
	(self condition: aCZEntry) 
		ifFalse: [
			(self hasPostAction)
				ifTrue: [ self postAction: aCZEntry. ^ true]
				ifFalse: [ ^ false ] 
		]
		ifTrue: [ ^ true ]
]

{ #category : #'as yet unclassified' }
CZRule >> condition: aCZEntry [
	^ true
]

{ #category : #'as yet unclassified' }
CZRule >> explanation [
	^ 'You should describe this rule!'
]

{ #category : #'as yet unclassified' }
CZRule >> hasPostAction [
	^ false
]

{ #category : #'as yet unclassified' }
CZRule >> postAction: aCZEntry [
	
]

{ #category : #'as yet unclassified' }
CZRule >> preCondition: aCZEntry [
	^ true
]
