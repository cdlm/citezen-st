"
I store metadata for this package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : #ManifestCitezenReborn,
	#superclass : #PackageManifest,
	#category : 'Citezen-Reborn'
}

{ #category : #'code-critics' }
ManifestCitezenReborn class >> ruleRBBadMessageRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#CZBodyDocBuilder #buildBody #false)) #'2018-05-06T15:45:29.963005+02:00') )
]

{ #category : #'code-critics' }
ManifestCitezenReborn class >> ruleRBStringConcatenationRuleV1FalsePositive [
	^ #(#(#(#RGMethodDefinition #(#CZSmartSectionBuilder #generate #false)) #'2016-08-07T21:41:02.012082+02:00') #(#(#RGMethodDefinition #(#CZBodyDocBuilder #buildBody #false)) #'2018-05-06T15:45:35.42425+02:00') )
]
