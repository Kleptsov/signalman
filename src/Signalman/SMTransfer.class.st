Class {
	#name : #SMTransfer,
	#superclass : #Object,
	#instVars : [
		'source',
		'destination',
		'sSelector',
		'dSelector',
		'arguments'
	],
	#category : #Signalman
}

{ #category : #accessing }
SMTransfer >> arguments [
	^ arguments
]

{ #category : #accessing }
SMTransfer >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
SMTransfer >> dSelector [
	^ dSelector
]

{ #category : #accessing }
SMTransfer >> dSelector: anObject [
	dSelector := anObject
]

{ #category : #accessing }
SMTransfer >> destination [
	^ destination
]

{ #category : #accessing }
SMTransfer >> destination: anObject [
	destination := anObject
]

{ #category : #accessing }
SMTransfer >> sSelector [
	^ sSelector
]

{ #category : #accessing }
SMTransfer >> sSelector: anObject [
	sSelector := anObject
]

{ #category : #accessing }
SMTransfer >> source [
	^ source
]

{ #category : #accessing }
SMTransfer >> source: anObject [
	source := anObject
]

{ #category : #'as yet unclassified' }
SMTransfer >> source: aSource sSelector: aSSelector destination: aDestionation dSelector: aDSelector arguments: anArguments [
	
]
