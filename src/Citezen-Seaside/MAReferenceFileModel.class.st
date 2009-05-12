Class {
	#name : #MAReferenceFileModel,
	#superclass : #MAExternalFileModel,
	#category : #'Citezen-Seaside'
}

{ #category : #'instance creation' }
MAReferenceFileModel class >> baseDirectory [
	^ baseDirectory ifNil: [ FileDirectory default ]
]

{ #category : #'instance creation' }
MAReferenceFileModel class >> fromRio: aRio [
	^ self new
		filename: aRio fileName;
		"base directory if absolute"
		location: aRio split allButLast;
		yourself
]

{ #category : #pierbib }
MAReferenceFileModel >> exists [
	^ (self directory exists and: [ self directory fileExists: self filename ])
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

{ #category : #pierbib }
MAReferenceFileModel >> modificationTime [
	"time the entry was last modified"
	^ (self directory directoryEntryFor: self filename) modificationTime
]

{ #category : #pierbib }
MAReferenceFileModel >> readStream [
	"override super readStream -- return text stream, not binary"
	^ (self directory readOnlyFileNamed: self filename)
]
