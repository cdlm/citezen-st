Class {
	#name : #CZNodeTest,
	#superclass : #TestCase,
	#instVars : [
		'textNode',
		'stream',
		'entry'
	],
	#category : #'Citezen-Tests'
}

{ #category : #running }
CZNodeTest >> setUp [
	stream := Array new writeStream.
	textNode := CZText text: 'hello'.
	entry := (CZEntry type: #article)
				key: #foobar;
				at: #author put: 'A';
				at: #title put: 'T';
				at: #journal put: 'J';
				at: #year put: 'Y';
				yourself
]

{ #category : #tests }
CZNodeTest >> testStreamFieldSource [
	| source |
	source := CZFieldSource field: #author.
	source streamFrom: entry to: stream.
	self assert: stream contents first text = 'A'
]

{ #category : #tests }
CZNodeTest >> testStreamGroup [
	| group |
	group := (CZGroup new).
	group streamFrom: nil to: stream.
	self assert: stream contents isEmpty.
	
	group add: textNode.
	group streamFrom: nil to: stream.
	self assert: stream contents last = textNode.
	
	group name: 'some name'.
	group streamFrom: nil to: stream.
	self assert: stream contents last = group
]

{ #category : #tests }
CZNodeTest >> testStreamText [
	textNode streamFrom: nil to: stream.
	self assert: stream contents last = textNode
]
