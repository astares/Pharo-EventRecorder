"
I'm a tape for events to remember

Instance Variables
	events:		<OrderedCollection>

events
	- the events to remember
"
Class {
	#name : #EventTape,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #'EventRecorder-Core-Model'
}

{ #category : #accessing }
EventTape >> append: anEvent [
	"Appends the given event at the end of the tape"

	events add: anEvent
]

{ #category : #'private accessing' }
EventTape >> eventStream [

	^ReadStream on: events.
]

{ #category : #accessing }
EventTape >> events [
	"Return the collected events"
	
	^events
	
]

{ #category : #initialization }
EventTape >> initialize [
	super initialize.
	events := OrderedCollection new.
]

{ #category : #accessing }
EventTape >> startingPosition [

	^ self tapeStream peek position.
]

{ #category : #accessing }
EventTape >> tapeStream [

	^ ReadStream on: self events.
]
