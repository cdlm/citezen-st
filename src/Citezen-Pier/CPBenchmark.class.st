"
I assess the basic costs of loading the scgbib, querying with a regex, and querying with a fixed string
"
Class {
	#name : #CPBenchmark,
	#superclass : #Object,
	#category : #'Citezen-Pier'
}

{ #category : #'as yet unclassified' }
CPBenchmark >> run [
	"self new run"
	<ignoreForCoverage>
	| bib re result |
	TimeProfileBrowser
		spyOn: [bib := String lf , String lf split: (FileDirectory default oldFileNamed: '/home/scg/scgbib/scg.bib') contents].
	re := 'scg-pub' asRegex.
	TimeProfileBrowser
		spyOn: [result := bib
						select: [:each | each includesSubString: 'scg-pub']].
	"result explore."
	TimeProfileBrowser
		spyOn: [result := bib
						select: [:each | re search: each]].
	"result explore."
]
