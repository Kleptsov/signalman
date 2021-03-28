Class {
	#name : #SMMonitor,
	#superclass : #Object,
	#instVars : [
		'selector',
		'receiver',
		'monitor',
		'level',
		'mutex'
	],
	#category : #Signalman
}

{ #category : #'instance creation' }
SMMonitor class >> receiver: aReceiver selector: aSelector [
	^ self new
			receiver: aReceiver;
			selector: aSelector;
			yourself.
]

{ #category : #execution }
SMMonitor >> execute [
	self mutex critical: [
		[
			monitor := self monitor + 1.
			monitor > self level
				ifFalse: [ receiver perform: selector asSymbol ] ] ensure:
					[ monitor := self monitor - 1.
						monitor := monitor max: 0 ] ].
]

{ #category : #execution }
SMMonitor >> executeWith: anArg [
	self mutex critical: [
		[
			monitor := self monitor + 1.
			monitor > self level
				ifFalse: [ receiver perform: (selector, #':') asSymbol with: anArg ] ] ensure:
					[ monitor := self monitor - 1.
						monitor := monitor max: 0 ] ].
]

{ #category : #accessing }
SMMonitor >> level [
	^ level ifNil: [ level := 1 ]
]

{ #category : #accessing }
SMMonitor >> level: aLevel [
	level := aLevel
]

{ #category : #accessing }
SMMonitor >> monitor [
	^ monitor ifNil: [ monitor := 0 ]
]

{ #category : #accessing }
SMMonitor >> monitor: aMonitor [
	monitor := aMonitor
]

{ #category : #accessing }
SMMonitor >> mutex [
	^ mutex ifNil: [ mutex := Mutex new ]
]

{ #category : #accessing }
SMMonitor >> receiver [
	^ receiver
]

{ #category : #accessing }
SMMonitor >> receiver: anObject [
	receiver := anObject
]

{ #category : #accessing }
SMMonitor >> selector [
	^ selector
]

{ #category : #accessing }
SMMonitor >> selector: anObject [
	selector := anObject
]
