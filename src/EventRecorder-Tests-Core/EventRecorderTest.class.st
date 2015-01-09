Class {
	#name : #EventRecorderTest,
	#superclass : #TestCase,
	#instVars : [
		'recorder'
	],
	#category : #'EventRecorder-Tests-Core-Model'
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
