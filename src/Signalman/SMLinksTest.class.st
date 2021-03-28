Class {
	#name : #SMLinksTest,
	#superclass : #TestCase,
	#instVars : [
		'links'
	],
	#category : #Signalman
}

{ #category : #running }
SMLinksTest >> setUp [
	links := SMLinks new.
]

{ #category : #tests }
SMLinksTest >> testAddSelectorSourceEvent [
	| block link res |
	block := [ self inform: 'OK'. res := true. 'signalman' yourself ].
	links add: block selector: #value source: self event: #signalmanEvent.
	link := links links at: self ifAbsent: [ nil ].
	self assert: link notNil.
	self assert: link size equals: 1.
	self assert: (link at: #signalmanEvent) notNil.
	links event: #signalmanEvent source: self.
	(Delay forMilliseconds: 1000) wait.
	self assert: res
]

{ #category : #tests }
SMLinksTest >> testEventSource [
	| res block |
	block := [ res := true ].
	links add: block selector: #value source: self event: #signalmanEvent.
	links event: #signalmanEvent source: self.
	(Delay forMilliseconds: 1000) wait.
	self assert: res.
]

{ #category : #tests }
SMLinksTest >> testEventSourceArg [
	| res block |
	block := [:v| res := v ].
	links add: block selector: #cull source: self event: #signalmanEvent.
	links event: #signalmanEvent source: self arg: 1.
	(Delay forMilliseconds: 1000) wait.
	self assert: res equals: 1
]

{ #category : #tests }
SMLinksTest >> testRemoveEventSource [
	| block link |
	block := [  ].
	links add: block selector: #value source: self event: #signalmanEvent.
	link := (links links at: self) at: #signalmanEvent.
	self assert: link size equals: 1.
	links remove: block event: #signalmanEvent source: self.
	link := (links links at: self) at: #signalmanEvent.
	self assert: link size equals: 0.

]
