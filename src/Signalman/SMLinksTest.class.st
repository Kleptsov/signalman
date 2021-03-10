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
SMLinksTest >> testAddEventSource [
	| block link res |
	block := [ self inform: 'OK'. res := true. 'signalman' yourself ].
	links add: block sEvent: #value source: block.
	link := links links at: block ifAbsent: [ nil ].
	self assert: link notNil.
	self assert: link size equals: 1.
	self assert: (link at: #value) notNil.
	links sEvent: #value source: block.
	(Delay forMilliseconds: 1000) wait.
	self assert: res
]

{ #category : #tests }
SMLinksTest >> testRemoveEventSource [
	| block link |
	block := [  ].
	links add: block event: #value source: self.
	link := (links links at: self) at: #value.
	self assert: link size equals: 1.
	links remove: block event: #value source: self.
	link := (links links at: self) at: #value.
	self assert: link size equals: 0.

]

{ #category : #tests }
SMLinksTest >> testSEventSource [
	| res block |
	block := [ res := true ].
	links add: block event: #value source: self.
	links sEvent: #value source: self.
	(Delay forMilliseconds: 1000) wait.
	self assert: res.
]

{ #category : #tests }
SMLinksTest >> testSEventSourceArg [
	| res block |
	block := [:v| res := v ].
	links add: block event: #cull: source: self.
	links sEvent: #cull: source: self arg: 1.
	(Delay forMilliseconds: 1000) wait.
	self assert: res equals: 1
]
