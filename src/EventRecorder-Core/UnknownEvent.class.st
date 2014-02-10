"
An unknown event 
"
Class {
	#name : #UnknownEvent,
	#superclass : #UserInputEvent,
	#category : #'EventRecorder-Core-Utilities'
}

{ #category : #'instance creation' }
UnknownEvent class >> endOfFile [

	^(self new)
		setType: #EOF;
		yourself
]

{ #category : #private }
UnknownEvent >> setType: aSymbol [

	type := aSymbol.
]
