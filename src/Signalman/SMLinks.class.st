"
Event management. You can add (remove) event handler and create events.
Each event handler runs on separate thread.

Public API and Key Messages

- add: aReceiver selector: aSelector source: aSource event: anEvent  
- remove: aReceiver event: anEvent source: aSource
- event: aSelector source: aSource
- event: aSelector source: aSource arg: anArgument

- SMLinks new - creating a new event manager.

|eventReceiver eventReceiver2 source|
eventReceiver := [ self inform: 'this is first event receiver' ].
source := Object new.
eventReceiver2 := [ self inform: 'this is second event receiver' ].
source addEvent: #newEvent receiver: eventReceiver selector: #value.
source addEvent: #newEvent receiver: eventReceiver2 selector: #value.
source addEvent: #newEvent2 receiver: eventReceiver selector: #value.
source sEvent: #newEvent.
source sEvent: #newEvent2.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	links:		<Object>


    Implementation Points
"
Class {
	#name : #SMLinks,
	#superclass : #Object,
	#instVars : [
		'links'
	],
	#classVars : [
		'CurrentLinks'
	],
	#category : #Signalman
}

{ #category : #'as yet unclassified' }
SMLinks class >> currentLinks [
	^ CurrentLinks ifNil: [ CurrentLinks := self new ].
]

{ #category : #'as yet unclassified' }
SMLinks class >> currentLinks: aNewLinks [
	CurrentLinks := aNewLinks
]

{ #category : #'as yet unclassified' }
SMLinks class >> resentCurrentLinks [
	CurrentLinks := nil
]

{ #category : #'event handling' }
SMLinks >> add: aReceiver selector: aSelector source: aSource event: aSymbol [ 
	"Adding an event handler"
	| coll symbols |
	symbols := self links at: aSource ifAbsent: [ nil ].
	symbols ifNil: [
		symbols := IdentityDictionary new.
		links at: aSource put: symbols ].
	coll := symbols at: aSymbol ifAbsent: [ symbols at: aSymbol put: WeakIdentityKeyDictionary new ].
	coll at: aReceiver put: aSelector.
]

{ #category : #'event handling' }
SMLinks >> event: aSelector source: aSource [
	"Creating an Event"
	| receivers symbols res |
	symbols := self links at: aSource ifAbsent: [ nil ].
	symbols ifNil: [ ^ self ].
	receivers := symbols at: aSelector ifAbsent: [ nil ].
	receivers ifNil: [ ^ self ].
	res := OrderedCollection new.
	receivers keysAndValuesDo: [ :k :v| res add: ([k perform: v asSymbol] fork)].
	^ res
]

{ #category : #'event handling' }
SMLinks >> event: aSelector source: aSource arg: anArg [
	"Creating an Event with an argument"
	| receivers symbols res |
	symbols := self links at: aSource ifAbsent: [ nil ].
	symbols ifNil: [ ^ self ].
	receivers := symbols at: aSelector ifAbsent: [ nil ].
	receivers ifNil: [ ^ self ].
	res := OrderedCollection new.
	receivers keysAndValuesDo: [ :k :v| res add: ([ k perform: (v, #':') asSymbol with: anArg ] fork) ].
	^ res
]

{ #category : #accessing }
SMLinks >> links [
	^ links ifNil: [ links := WeakIdentityKeyDictionary new ]
]

{ #category : #accessing }
SMLinks >> links: anObject [
	links := anObject
]

{ #category : #'event handling' }
SMLinks >> remove: anReceiver event: anSymbol source: aSource [
	"Removing an event handler"
	| coll symbols |
	symbols := self links at: aSource ifAbsent: [ nil ].
	symbols ifNil: [ ^ self ].
	coll := symbols at: anSymbol ifAbsent: [ nil ].
	coll ifNil: [ ^ self ].
	^ coll removeKey: anReceiver ifAbsent: [  ].
]
