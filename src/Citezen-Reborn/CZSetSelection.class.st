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

{ #category : #accessing }
CZSetSelection >> entries [

	^ self select: filteringPredicate
]

{ #category : #accessing }
CZSetSelection >> filteringPredicate [
	^ filteringPredicate
]

{ #category : #accessing }
CZSetSelection >> filteringPredicate: aQuery [
	filteringPredicate := aQuery
]

{ #category : #accessing }
CZSetSelection >> id [ 
	"Return the id of the script - handy to debug."
	
	^ id
]

{ #category : #accessing }
CZSetSelection >> id: anId [
	"anId can be anything."
	
	id := anId.
]

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

{ #category : #'to change in CZEntry' }
CZSetSelection >> select: aBlock [
	^ self class new
		setEntries: (entries select: aBlock)
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
