"
currently replaying events
"
Class {
	#name : #ReplayingEvents,
	#superclass : #EventRecordingState,
	#category : #'EventRecorder-Core-Model-States'
}

{ #category : #testing }
ReplayingEvents class >> canPause [

	^true
]

{ #category : #accessing }
ReplayingEvents >> description [

	^'Replaying'
]
