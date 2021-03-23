Extension { #name : #Object }

{ #category : #'*Signalman' }
Object >> addEvent: anEvent receiver: aReceiver selector: aSelector [
	self sEventLinks
		add: aReceiver
		selector: aSelector
		source: self
		event: anEvent.
]

{ #category : #'*Signalman' }
Object >> removeEvent: anEventName receiver: aReceiver [
	self sEventLinks
		remove: aReceiver
		event: anEventName
		source: self.
]

{ #category : #'*Signalman' }
Object >> sEvent: anEventName [
	^ self sEventLinks
			event: anEventName
			source: self
]

{ #category : #'*Signalman' }
Object >> sEvent: anEventName arg: anArg [
	^ self sEventLinks
			sEvent: anEventName
			source: self
			arg: anArg
]

{ #category : #'*Signalman' }
Object >> sEventLinks [
	^ SMLinks currentLinks.
]
