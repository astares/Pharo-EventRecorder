Class {
	#name : #EventRecorderTest,
	#superclass : #TestCase,
	#instVars : [
		'recorder'
	],
	#category : #'EventRecorder-Core-Tests-Model'
}

{ #category : #running }
EventRecorderTest >> setUp [

	super setUp.
	recorder := EventRecorder new.
]

{ #category : #tests }
EventRecorderTest >> testInitialization [

	self assert: recorder hasNothingRecordedYet 
]
