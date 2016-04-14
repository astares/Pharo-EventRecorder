"
I am a hand for replaying events stored in an EventRecorder.  When there are no more events, I delete myself.
"
Class {
	#name : #HandMorphForReplay,
	#superclass : #HandMorph,
	#instVars : [
		'eventRecorder'
	],
	#category : #'EventRecorder-Core-Utilities'
}

{ #category : #'instance creation' }
HandMorphForReplay class >> forRecorder: anEventRecorder [

	^(self new)
		eventRecorder: anEventRecorder;
		yourself
]

{ #category : #accessing }
HandMorphForReplay >> eventRecorder: anEventRecorder [

	eventRecorder := anEventRecorder 
]

{ #category : #initialization }
HandMorphForReplay >> initialize [
	super initialize.
	self showTemporaryCursor: Cursor normal.

]

{ #category : #drawing }
HandMorphForReplay >> needsToBeDrawn [
	"Always needs to be drawn"
	
	^true
]

{ #category : #'event handling' }
HandMorphForReplay >> pauseEventRecorderIn: aWorld [
	"Suspend my recorder prior to a project change, and return it.
	It will be resumed after starting the new project."

	^eventRecorder pause
]

{ #category : #'event handling' }
HandMorphForReplay >> processEvents [
	"Play back the next event"

	| evt hadMouse hadAny |
	hadMouse := hadAny := false.
	[(evt := eventRecorder nextEventToPlay) isNil] whileFalse: 
			[evt type == #EOF 
				ifTrue: 
					[eventRecorder pause.
					World removeHand: self.
					^self].
			evt type == #startSound 
				ifTrue: 
					[evt argument play.
					eventRecorder synchronize.
					^self].
			evt isMouse ifTrue: [hadMouse := true].
			(evt isMouse or: [evt isKeyboard]) 
				ifTrue: 
					[self handleEvent: (evt setHand: self) resetHandlerFields.
					hadAny := true]].
	(mouseClickState notNil and: [hadMouse not]) 
		ifTrue: 
			["No mouse events during this cycle. Make sure click states time out accordingly"

			mouseClickState handleEvent: lastMouseEvent asMouseMove from: self].
	hadAny 
		ifFalse: 
			["No pending events. Make sure z-order is up to date"

			self mouseOverHandler processMouseOver: lastMouseEvent.
			
			]
]

{ #category : #drawing }
HandMorphForReplay >> restoreSavedPatchOn: aCanvas [ 
	"In Squeak, if the hand had user information (which HandMorphForReplay always does), the method would just draw and return, 	 	skipping the transition to hardware cursor (see HandMorph>>#restoreSavedPatchOn:. Since in Pharo, hands don't have user 	info, we can't use that trick, so we just copied the first part of HandMorph's implementation"
	hasChanged := false.
	savedPatch ifNotNil: [ aCanvas drawImage: savedPatch at: savedPatch offset ].
	
	
]

{ #category : #cursor }
HandMorphForReplay >> showTemporaryCursor: cursorOrNil hotSpotOffset: hotSpotOffset [
	"When I show my cursor, it appears double size,
	unless it is a form such as a paint brush."

	cursorOrNil
	ifNil: ["Setting cursor to nil cannot revert to hardware cursor -- just show normal."
			^ self showTemporaryCursor: Cursor normal hotSpotOffset: Cursor normal offset]
	ifNotNil:
		[(cursorOrNil isKindOf: Cursor)
			ifTrue: ["Show cursors magnified for visibility"
					^ super showTemporaryCursor:
									(CursorWithMask derivedFrom: (cursorOrNil magnifyBy: 2))
				 				hotSpotOffset: (cursorOrNil offset negated*2) + hotSpotOffset]
			ifFalse: [^ super showTemporaryCursor: cursorOrNil
				 				hotSpotOffset: hotSpotOffset]]
]

{ #category : #copying }
HandMorphForReplay >> veryDeepCopyWith: deepCopier [
	^ self copy
]
