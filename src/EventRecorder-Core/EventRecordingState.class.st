"
Abstract superclass for recording states
"
Class {
	#name : #EventRecordingState,
	#superclass : #Object,
	#category : #'EventRecorder-Core-Model-States'
}

{ #category : #accessing }
EventRecordingState >> description [

	^self subclassResponsibility 
]

{ #category : #printing }
EventRecordingState >> printOn: aStream [

	aStream nextPutAll: self description
	
]
