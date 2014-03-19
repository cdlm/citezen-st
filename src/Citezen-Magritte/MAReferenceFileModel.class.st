Class {
	#name : #MAReferenceFileModel,
	#superclass : #MAExternalFileModel,
	#category : #'Citezen-Magritte'
}

{ #category : #'instance creation' }
MAReferenceFileModel class >> baseDirectory [
	^ baseDirectory ifNil: [ FileDirectory default ]
]

{ #category : #'instance creation' }
MAReferenceFileModel class >> fromFileReference: aFileReference [
	^ self new
		filename: aFileReference basename;
		"base directory if absolute"
		location: aFileReference parent pathSegments;
		yourself
]

{ #category : #'instance creation' }
MAReferenceFileModel class >> fromPath: aFSPath [
	| parents |
	self flag: 'Ugly, MAExternalFileModels should use FS objects in the 1st place'.
	parents := Array new: aFSPath size - 1.
	1 to: aFSPath size - 1 do: [:index | parents at: index put: (aFSPath at: index)].
	^ self new
		filename: aFSPath basename;
		location: parents;
		yourself
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
		inject: FileSystem disk workingDirectory	
		into: [ :result :each | result / each ]) / filename) fullName
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
