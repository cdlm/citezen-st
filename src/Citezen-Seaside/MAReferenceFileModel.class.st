Class {
	#name : #MAReferenceFileModel,
	#superclass : #MAExternalFileModel,
	#category : #'Citezen-Seaside'
}

{ #category : #'instance creation' }
MAReferenceFileModel class >> fromRio: aRio [
	^ self new
		filename: aRio fileName;
		"base directory if absolute"
		location: aRio split allButLast;
		yourself
]

{ #category : #configuration }
MAReferenceFileModel >> baseDirectory [
	<todo: 'extract default baseDirectory'>
	^ BaseDirectory ifNil: [ FileDirectory default ]
]

{ #category : #'accessing-dynamic' }
MAReferenceFileModel >> filePath [
	^ ((self location
		inject: Cwd
		into: [ :result :each | result / each ]) / filename) value
]

{ #category : #'accessing-dynamic' }
MAReferenceFileModel >> location [
	<todo: 'extract default location'>
	^ location ifNil: [ location := Array new ]
]

{ #category : #'accessing-dynamic' }
MAReferenceFileModel >> location: anArray [
	location := anArray
]
