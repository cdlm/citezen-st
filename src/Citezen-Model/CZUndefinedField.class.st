"
Just overloads isUndefined. It's used to access to an inexistant field.
"
Class {
	#name : #CZUndefinedField,
	#superclass : #CZField,
	#category : #'Citezen-Model'
}

{ #category : #'as yet unclassified' }
CZUndefinedField >> isUndefined [
	^ true
]
