Extension { #name : #CZField }

{ #category : #'*Citezen-Scripts' }
CZField >> match: aPattern [

	^ aPattern match: self rawValue.
]
