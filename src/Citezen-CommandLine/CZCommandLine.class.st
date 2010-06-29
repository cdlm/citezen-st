Class {
	#name : #CZCommandLine,
	#superclass : #AbstractLauncher,
	#category : #'Citezen-CommandLine'
}

{ #category : #'as yet unclassified' }
CZCommandLine class >> initialize [
	ProjectLauncher deactivate.
	self activate
]

{ #category : #'as yet unclassified' }
CZCommandLine >> parameterAt: parName ifAbsent: aBlock [
	"Return the parameter named parName.
	Evaluate the block if parameter does not exist."
	^self parameters
		at: parName 
		ifAbsent: [aBlock value]
]

{ #category : #'as yet unclassified' }
CZCommandLine >> parameters [
	^ Smalltalk extractMinusParameters
]

{ #category : #'as yet unclassified' }
CZCommandLine >> startUp [
	| files |

	files := self parameterAt: 'bib'.

	files do: [ :each | 
		Console print: '*** Checks: ', each, ' ***', String lf.
		CZChecker new checkFile: each
	] separatedBy: [ Console print: String crlf, String crlf, String crlf ].

	files ifNotEmpty: [ Console print: String crlf ].
	
	Smalltalk shouldQuit ifTrue: [ Smalltalk snapshot: false andQuit: true ]
]
