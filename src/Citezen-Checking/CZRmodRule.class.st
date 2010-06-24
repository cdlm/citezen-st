Class {
	#name : #CZRmodRule,
	#superclass : #CZRule,
	#category : #'Citezen-Checking'
}

{ #category : #'as yet unclassified' }
CZRmodRule >> explanation [
	^ 'Checks nothing, ensure CZChecker isWrittenByRModMember'
]

{ #category : #'as yet unclassified' }
CZRmodRule >> preCondition: aCZEntry [
	^ CZChecker isWrittenByRModMember: aCZEntry
]
