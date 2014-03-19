Extension { #name : #CZScoped }

{ #category : #'*citezen-voyage' }
CZScoped classSide >> isVoyageRoot [ 
	^ true
]

{ #category : #'*citezen-voyage' }
CZScoped classSide >> mongoContainer [ 
	<mongoContainer>
	
	^ VOMongoContainer new
		collectionName: 'citezen'
		yourself
]
