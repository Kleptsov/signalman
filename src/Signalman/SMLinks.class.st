Class {
	#name : #SMLinks,
	#superclass : #Object,
	#instVars : [
		'links'
	],
	#category : #Signalman
}

{ #category : #'as yet unclassified' }
SMLinks >> add: anReceiver at: anSymbol [
	| coll |
	coll := self links at: anSymbol ifAbsent: [ nil ].
	coll ifNil: [ coll := WeakIdentitySet new.
		links at: anSymbol put: coll ].
	(coll like: anReceiver) ifFalse: [ coll add: anReceiver ].
	
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
SMLinks >> remove: anReceiver at: anSymbol [
	| coll |
	coll := self links at: anSymbol ifAbsent: [ nil ].
	coll ifNil: [ ^ self ].
	coll remove: anSymbol ifAbsent: [ nil ].
]

{ #category : #'as yet unclassified' }
SMLinks >> signalize: anSymbol [
	| ref |
	ref := self links at: anSymbol ifAbsent: [ nil ].
	ref ifNil: [ ^ self ].
	^ ref collect: [ :el| [ el perform: anSymbol asSymbol ] fork ].
]

{ #category : #'as yet unclassified' }
SMLinks >> signalize: anSymbol from: anObject [
	| ref |
	ref := self links at: anObject ifAbsent: [ nil ].
	ref ifNil: [ ^ self ].
	^ ref collect: [ :el| [ el perform: anSymbol asSymbol ] fork ].
]

{ #category : #'as yet unclassified' }
SMLinks >> signalize: anSymbol width: anObject [
	| ref |
	ref := self links at: anSymbol ifAbsent: [ nil ].
	ref ifNil: [ ^ self ].
	^ ref collect: [ :el| [ el perform: anSymbol asSymbol with: anObject ] fork ].
]
