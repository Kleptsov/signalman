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
	| coll symbols |
	symbols := self links at: aSource ifAbsent: [ nil ].
	symbols ifNil: [
		symbols := IdentityDictionary new.
		links at: aSource put: symbols ].
	coll := symbols at: aSymbol ifAbsent: [ symbols at: aSymbol put: WeakIdentitySet new ].
	coll like: anReceiver ifAbsent: [ coll add: anReceiver ]
	
]

{ #category : #'as yet unclassified' }
SMLinks >> add: anReceiver sEvent: aSymbol source: aSource [
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
	| coll symbols |
	symbols := self links at: aSource ifAbsent: [ nil ].
	symbols ifNil: [ ^ self ].
	coll := symbols at: anSymbol ifAbsent: [ nil ].
	coll ifNil: [ ^ self ].
	coll remove: anReceiver ifAbsent: [  ].
]

{ #category : #'as yet unclassified' }
SMLinks >> remove: anReceiver sEvent: anSymbol source: aSource [
	| coll symbols |
	symbols := self links at: aSource ifAbsent: [ nil ].
	symbols ifNil: [ ^ self ].
	coll := symbols at: anSymbol ifAbsent: [ nil ].
	coll ifNil: [ ^ self ].
	coll remove: anReceiver ifAbsent: [  ].
]

{ #category : #'as yet unclassified' }
SMLinks >> sEvent: anSymbol from: anObject [
	| receivers symbols |
	symbols := self links at: anObject ifAbsent: [ nil ].
	symbols ifNil: [ ^ self ].
	receivers := symbols at: anSymbol ifAbsent: [ nil ].
	receivers ifNil: [ ^ self ].
	^ receivers collect: [ :el| [ el perform: anSymbol asSymbol ] fork ].
]

{ #category : #'as yet unclassified' }
SMLinks >> sEvent: anSymbol source: anObject [
	| receivers symbols |
	symbols := self links at: anObject ifAbsent: [ nil ].
	symbols ifNil: [ ^ self ].
	receivers := symbols at: anSymbol ifAbsent: [ nil ].
	receivers ifNil: [ ^ self ].
	^ receivers collect: [ :el| [ el perform: anSymbol asSymbol ] fork ].
]

{ #category : #'as yet unclassified' }
SMLinks >> sEvent: anSymbol source: anObject arg: anArg [
	| receivers symbols |
	symbols := self links at: anObject ifAbsent: [ nil ].
	symbols ifNil: [ ^ self ].
	receivers := symbols at: anSymbol ifAbsent: [ nil ].
	receivers ifNil: [ ^ self ].
	^ receivers collect: [ :el| [ el perform: anSymbol asSymbol with: anArg ] fork ].
]
