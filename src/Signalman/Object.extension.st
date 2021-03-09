Extension { #name : #Object }

{ #category : #'*Signalman' }
Object >> addEvent: anSymbol receiver: anReceiver [
	self sEventLinks
		add: anReceiver
		event: anSymbol
		source: self.
]

{ #category : #'*Signalman' }
Object >> removeEvent: anSymbol receiver: anReceiver [
	self sEventLinks
		remove: anReceiver
		event: anSymbol
		source: self.
]

{ #category : #'*Signalman' }
Object >> sEvent: aSelector [
	^ self sEventLinks
			sEvent: aSelector
			source: self
]

{ #category : #'*Signalman' }
Object >> sEvent: aSelector arg: anArg [
	^ self sEventLinks
			sEvent: aSelector
			source: self
			arg: anArg
]

{ #category : #'*Signalman' }
Object >> sEventLinks [
	^ SMLinks currentLinks.
]
