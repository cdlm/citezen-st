Class {
	#name : #Console,
	#superclass : #Object,
	#category : #'Citezen-CommandLine'
}

{ #category : #console }
Console class >> << aStream [

	OSProcess thisOSProcess stdOut nextPutAll: aStream
]

{ #category : #console }
Console class >> closeConsole [

	(OSProcess thisOSProcess isKindOf: WindowsProcess) 
		ifTrue: [OSProcess thisOSProcess closeConsole]
]

{ #category : #console }
Console class >> cr [ 
	
	^OSProcess thisOSProcess newLineInConsole
]

{ #category : #console }
Console class >> newLine [
	
	^OSProcess thisOSProcess newLineInConsole
]

{ #category : #console }
Console class >> nextPutAll: aStream [

	OSProcess thisOSProcess stdOut nextPutAll: aStream
]

{ #category : #console }
Console class >> openConsole [

	(OSProcess thisOSProcess isKindOf: WindowsProcess) 
		ifTrue: [OSProcess thisOSProcess openConsole]
]

{ #category : #console }
Console class >> print: aStream [

	OSProcess thisOSProcess stdOut nextPutAll: aStream
]

{ #category : #console }
Console class >> printError: aStream [

	OSProcess thisOSProcess stdErr nextPutAll: aStream
]

{ #category : #console }
Console class >> printNl: aStream [

	OSProcess thisOSProcess stdOut nextPutAll: aStream, Console newLine
]

{ #category : #console }
Console class >> read [

	^OSProcess thisOSProcess stdIn readUpToNewLine
]
