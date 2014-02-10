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

{ #category : #drawing }
HandMorphForReplay >> restoreSavedPatchOn: aCanvas [ 
	"In Squeak, if the hand had user information (which HandMorphForReplay always does), the method would just draw and return, 	 	skipping the transition to hardware cursor (see HandMorph>>#restoreSavedPatchOn:. Since in Pharo, hands don't have user 	info, we can't use that trick, so we just copied the first part of HandMorph's implementation"
	hasChanged := false.
	savedPatch ifNotNil: [ aCanvas drawImage: savedPatch at: savedPatch offset ].
	
	
]

{ #category : #copying }
HandMorphForReplay >> veryDeepCopyWith: deepCopier [
	^ self copy
]
