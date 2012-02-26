"
I'm a selection of bibSet.
"
Class {
	#name : #CZSetSelection,
	#superclass : #CZSet,
	#instVars : [
		'id',
		'filteringPredicate',
		'sortBlock',
		'reversed'
	],
	#category : #'Citezen-Reborn'
}

{ #category : #'initialize-release' }
CZSetSelection >> initialize [

	super initialize.
	filteringPredicate := [:each | true].
	self sortByType.
]

{ #category : #accessing }
CZSetSelection >> normal [

	reversed := false

	
]

{ #category : #accessing }
CZSetSelection >> reversed [

	reversed := true

	
]

{ #category : #accessing }
CZSetSelection >> reversed: aBoolean [

	reversed := aBoolean

	
]

{ #category : #accessing }
CZSetSelection >> sort [
	"I want the filtered entities to be sorted"
	
	^ self entries sortBy: sortBlock
]

{ #category : #accessing }
CZSetSelection >> sortByField: aField [

	sortBlock := [:a :b | (a at: aField) < (b at: aField)]. 
]

{ #category : #accessing }
CZSetSelection >> sortByKey [

	sortBlock := [:a :b | (a key) < (b key)]. 
]

{ #category : #accessing }
CZSetSelection >> sortByType [

	sortBlock := [:a :b | (a type) < (b type)]. 
]
