"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCitezenReborn,
	#superclass : #PackageManifest,
	#category : #'Citezen-Reborn'
}

{ #category : #'code-critics' }
ManifestCitezenReborn class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#CZSmartSectionBuilder #generate #false)) #'2016-08-07T21:41:02.012082+02:00') )
]
