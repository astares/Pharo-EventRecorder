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
		'time',
		'deltaTime',
		'playHand',
		'tapeStream',
		'lastDelta'
	],
	#category : #'EventRecorder-Core-Model'
}

{ #category : #testing }
EventRecorder >> canExport [

	^self hasNothingRecordedYet not and: [ self isRecording not ]
]

{ #category : #testing }
EventRecorder >> canImport [
	
	^self isRecording not or: [ self isPlaying not ]
]

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

{ #category : #'import/export' }
EventRecorder >> export [
	^ STON toStringPretty: tape
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

{ #category : #'import/export' }
EventRecorder >> import: aStonSerialization [
	tape := STON fromString: aStonSerialization.
	state := StoppedRecording new
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

{ #category : #accessing }
EventRecorder >> nextEventToPlay [
	"Return the next event when it is time to be replayed.
	If it is not yet time, then return an interpolated mouseMove.
	Return nil if nothing has happened.
	Return an EOF event if there are no more events to be played."
	| nextEvent now nextTime lastP delta |
	(tapeStream isNil or:[tapeStream atEnd]) ifTrue:[^ UnknownEvent endOfFile].

	now := Time millisecondClockValue.
	nextEvent := tapeStream next.

	deltaTime ifNil:[deltaTime := now - nextEvent timeStamp].
	nextTime := nextEvent timeStamp + deltaTime.
	now < time ifTrue:["clock rollover"
		time := now.
		deltaTime := nil.
		^nil "continue it on next cycle"].
	time := now.
	(now >= nextTime) ifTrue:[
		nextEvent := nextEvent copy setTimeStamp: nextTime.
		nextEvent isMouse ifTrue:[lastEvent := nextEvent] ifFalse:[lastEvent := nil].
		^nextEvent].
	tapeStream skip: -1.
	"Not time for the next event yet, but interpolate the mouse.
	This allows tapes to be compressed when velocity is fairly constant."
	lastEvent ifNil: [^ nil].
	lastP := lastEvent position.
	delta := (nextEvent position - lastP) * (now - lastEvent timeStamp) // (nextTime - lastEvent timeStamp).
	delta = lastDelta ifTrue: [^ nil]. "No movement"
	lastDelta := delta.
	^MouseMoveEvent basicNew
		setType: #mouseMove 
		startPoint: lastEvent position endPoint: lastP + delta
		trail: #() buttons: lastEvent buttons hand: nil stamp: now.
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

	self startPlaying
]

{ #category : #commands }
EventRecorder >> record [
 
	self isPausedRecording ifFalse: [ 
		tape := EventTape new.
	].
	
	self startRecording
]

{ #category : #'private - recording' }
EventRecorder >> startPlaying [
	
	playHand := HandMorphForReplay forRecorder: self.
	playHand position: tape startingPosition.
	self world addHand: playHand.
	playHand newKeyboardFocus: self world.
	
	tapeStream := tape tapeStream.
	lastEvent := nil.
	lastDelta := 0@0.
	
	state := ReplayingEvents new.
		
	self synchronize
]

{ #category : #'private - recording' }
EventRecorder >> startRecording [
	
	recHand := self world activeHand ifNil: [self world primaryHand].
	recHand newKeyboardFocus: self world.
	recHand addEventListener: self.
	
	state := RecordingEvents new.	
		
	self synchronize
]

{ #category : #accessing }
EventRecorder >> stateDescription [

	^state description
]

{ #category : #commands }
EventRecorder >> stop [

	self isPlaying ifTrue: [ 
		state := StoppedPlaying new.
		playHand delete.
		self world removeHand: playHand.
		playHand := nil
	].
		
	self isRecording ifTrue: [ 
		recHand removeEventListener: self.
		recHand := nil.
		state := StoppedRecording new.		
	]		
	

]

{ #category : #'event handling' }
EventRecorder >> synchronize [

	time := Time millisecondClockValue.
	deltaTime := nil.
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
