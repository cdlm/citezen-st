Extension { #name : #String }

{ #category : #'*Citezen-Model' }
String >> containsTeamMember: memberCollection [
	"'Veronica Uquillas-Gomez and Zork' containsTeamMember: #( '*Ducasse*S*' '*Denker*M*' '*Anquetil*N*' '*Pollet*D*' '*Abdeen*H*' '*Laval*J*' '*Peirs*R*' '*Falleri*' '*Denier*S*' '*Hora*'
		'*Casaccio*G*' '*Bruni*C*' '*Martinez-Peck*' '*Uquillas*' '*Arnaud*J*B*' '*Bhatti*U*' '*Fernandes*H*' '*Razavizadeh*A*' '*Uquilla*') 
		
	'Awais Rashid and Jean-Claude Royer and Andreas Rummler' containsTeamMember: #( '*Ducasse*S*' '*Denker*M*' '*Anquetil*N*' '*Pollet*D*' '*Abdeen*H*' '*Laval*J*' '*Peirs*R*' '*Falleri*' '*Denier*S*' '*Hora*'
		'*Casaccio*G*' '*Bruni*C*' '*Martinez-Peck*' '*Uquillas*' '*Arnaud*J*B*' '*Bhatti*U*' '*Fernandes*H*' '*Razavizadeh*A*' '*Uquilla*') 
		"
	^ memberCollection anySatisfy: [ :each | each match: self ]
]

{ #category : #'*Citezen-Model' }
String >> scope: aField [
	"do nothing, see CZCompositeValue"
]
