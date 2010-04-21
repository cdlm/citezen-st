Class {
	#name : #CZUsefullScripts,
	#superclass : #Object,
	#category : #'Citezen-Script'
}

{ #category : #'as yet unclassified' }
CZUsefullScripts class >> withoutInriaFields [
	^ (CZScript new)
		exportAsBib;
		fieldsToRemove: #(aeres aeresstatus selectif inria hal misc rate keywords x-pays x-country x-editorial-board x-proceedings x-international-audience type_rapport doi)
]
