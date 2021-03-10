"
Event management. You can add (remove) event handler and create events.
Each event handler runs on separate thread.

Public API and Key Messages

- add: aReceiver event: anEvent source: aSource  
- remove: aReceiver event: anEvent source: aSource
- sEvent: aSelector source: aSource
- sEvent: aSelector source: aSource

- SMLinks new - creating a new event manager.

|handler handler2 source|
handler := [ self inform: 'this is first handler' ].
source := Object new.
handler2 := [ self inform: 'this is second handler' ].
source addEvent: #value receiver: handler.
source addEvent: #value receiver: handler2.
source sEvent: #value.
 
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

{ #category : #'as yet unclassified' }
SMLinks >> add: anReceiver event: aSymbol source: aSource [
	"Adding an event handler"	
	^ self add: anReceiver sEvent: aSymbol source: aSource
	
]

{ #category : #'as yet unclassified' }
SMLinks >> add: anReceiver sEvent: aSymbol source: aSource [
	"Adding an event handler"
	| coll symbols |
	symbols := self links at: aSource ifAbsent: [ nil ].
	symbols ifNil: [
		symbols := IdentityDictionary new.
		links at: aSource put: symbols ].
	coll := symbols at: aSymbol ifAbsent: [ symbols at: aSymbol put: WeakIdentitySet new ].
	coll like: anReceiver ifAbsent: [ coll add: anReceiver ]
	
]

{ #category : #accessing }
SMLinks >> links [
	^ links ifNil: [ links := WeakIdentityKeyDictionary new ]
]

{ #category : #accessing }
SMLinks >> links: anObject [
	links := anObject
]

{ #category : #'as yet unclassified' }
SMLinks >> remove: anReceiver event: anSymbol source: aSource [
	"Removing an event handler"
	
	^ self remove: anReceiver sEvent: anSymbol source: aSource
]

{ #category : #'as yet unclassified' }
SMLinks >> remove: anReceiver sEvent: anSymbol source: aSource [
	"Removing an event handler"
	| coll symbols |
	symbols := self links at: aSource ifAbsent: [ nil ].
	symbols ifNil: [ ^ self ].
	coll := symbols at: anSymbol ifAbsent: [ nil ].
	coll ifNil: [ ^ self ].
	coll remove: anReceiver ifAbsent: [  ].
]

{ #category : #'as yet unclassified' }
SMLinks >> sEvent: aSelector source: aSource [
	"Creating an Event"
	| receivers symbols |
	symbols := self links at: aSource ifAbsent: [ nil ].
	symbols ifNil: [ ^ self ].
	receivers := symbols at: aSelector ifAbsent: [ nil ].
	receivers ifNil: [ ^ self ].
	^ receivers collect: [ :el| [ el perform: aSelector asSymbol ] fork ].
]

{ #category : #'as yet unclassified' }
SMLinks >> sEvent: aSelector source: aSource arg: anArg [
	"Creating an Event with an argument"
	| receivers symbols |
	symbols := self links at: aSource ifAbsent: [ nil ].
	symbols ifNil: [ ^ self ].
	receivers := symbols at: aSelector ifAbsent: [ nil ].
	receivers ifNil: [ ^ self ].
	^ receivers collect: [ :el| [ el perform: aSelector asSymbol with: anArg ] fork ].
]
