"
Just overloads isUndefined. It's used to access to an inexistant field.
"
Class {
	#name : #CZUndefinedField,
	#superclass : #CZField,
	#category : 'Citezen-Model'
}

{ #category : #testing }
CZUndefinedField >> isUndefined [
	^ true
]
