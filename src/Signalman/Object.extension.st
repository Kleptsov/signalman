Extension { #name : #Object }

{ #category : #'*Signalman' }
Object >> addEvent: aSelector receiver: aReceiver [
	self sEventLinks
		add: aReceiver
		event: aSelector
		source: self.
]

{ #category : #'*Signalman' }
Object >> removeEvent: aSelector receiver: aReceiver [
	self sEventLinks
		remove: aReceiver
		event: aSelector
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
