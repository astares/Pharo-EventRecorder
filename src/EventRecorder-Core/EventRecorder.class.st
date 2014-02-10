"
I'm a recorder for events
"
Class {
	#name : #EventRecorder,
	#superclass : #Object,
	#instVars : [
		'tape',
		'state',
		'world',
		'recHand',
		'lastEvent',
		'time'
	],
	#category : #'EventRecorder-Core-Model'
}

{ #category : #testing }
EventRecorder >> canPause [

	^self isRecording 
		| self isPlaying 
		| self isPausedRecording
		| self isPausedPlaying
]

{ #category : #testing }
EventRecorder >> canPlay [

	^self hasNothingRecordedYet not and: [ self isRecording not ]
]

{ #category : #testing }
EventRecorder >> canRecord [

	^self hasNothingRecordedYet or: [ self isStopped ]
]

{ #category : #testing }
EventRecorder >> canStop [

	^self isRecording or: [ self isPlaying ]
]

{ #category : #defaults }
EventRecorder >> defaultWorld [

	^ActiveWorld
]

{ #category : #'private - recording' }
EventRecorder >> handleListenEvent: anEvent [
	"Record the given event"
	(self isRecording and: [anEvent hand == recHand]) ifFalse:[^self].
	
	anEvent = lastEvent ifTrue: [^ self].
	anEvent isEscapeKey ifTrue: [^ self stop].
	time := anEvent timeStamp.
	tape append: (anEvent copy setHand: nil).	 
	lastEvent := anEvent.
]

{ #category : #testing }
EventRecorder >> hasNothingRecordedYet [

	^self hasState: NothingRecordedYet  
]

{ #category : #'private - testing' }
EventRecorder >> hasState: aState [

	^state class = aState  
]

{ #category : #initialization }
EventRecorder >> initialize [
	"Initializes the receiver"
	
	super initialize.
	world := self defaultWorld.
	state := NothingRecordedYet new
]

{ #category : #testing }
EventRecorder >> isPausedPlaying [

	^self hasState: PausedPlaying 
]

{ #category : #testing }
EventRecorder >> isPausedRecording [

	^self hasState: PausedRecording 
]

{ #category : #testing }
EventRecorder >> isPlaying [

	^self hasState: ReplayingEvents  
]

{ #category : #testing }
EventRecorder >> isRecording [

	^self hasState: RecordingEvents 
]

{ #category : #testing }
EventRecorder >> isStopped [

	^self hasState: StoppedPlaying  
]

{ #category : #commands }
EventRecorder >> pause [

	self isPlaying 
		ifTrue: [ ^state := PausedPlaying new ].
	self isPausedPlaying 
		ifTrue: [ ^state := ReplayingEvents new "continuePlaying"].
	self isPausedRecording  
		ifTrue: [ ^state := RecordingEvents new  "continuerecording"].		
	self isRecording 
		ifTrue: [ state := PausedRecording new ]		
				

]

{ #category : #commands }
EventRecorder >> play [
	state := ReplayingEvents new
]

{ #category : #commands }
EventRecorder >> record [
self inspect.
	self isPausedRecording ifFalse: [ 
		tape := EventTape new.
	].
	
	self startRecording
]

{ #category : #'private - recording' }
EventRecorder >> startRecording [
	
	recHand := self world activeHand ifNil: [self world primaryHand].
	recHand newKeyboardFocus: self world.
	recHand addEventListener: self.
	
	state := RecordingEvents new.	
]

{ #category : #accessing }
EventRecorder >> stateDescription [

	^state description
]

{ #category : #commands }
EventRecorder >> stop [

	self isPlaying 
		ifTrue: [ state := StoppedPlaying new ].
	self isRecording 
		ifTrue: [ state := StoppedRecording new ]		
]

{ #category : #accessing }
EventRecorder >> world [
	"Return the world that is used to record events"
	
	^world
]

{ #category : #accessing }
EventRecorder >> world: aWorld [
	"Sets the world that is used for recording events"

	world := aWorld
]
