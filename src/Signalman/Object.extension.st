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
Object >> addModel: aModel event: anEvent callbackEvent: aCallbackEvent [
	| res |
	res := aModel perform: anEvent asSymbol.
	self perform: (aCallbackEvent, #':') asSymbol with: res.
	aModel addEvent: anEvent receiver: self selector: aCallbackEvent.
	self addEvent: aCallbackEvent receiver: aModel selector: anEvent.
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
			event: anEventName
			source: self
			arg: anArg
]

{ #category : #'*Signalman' }
Object >> sEventLinks [
	^ SMLinks currentLinks.
]
