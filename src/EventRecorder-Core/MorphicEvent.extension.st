Extension { #name : #MorphicEvent }

{ #category : #'*EventRecorder-Core' }
MorphicEvent >> isEscapeKey [

	^ self isKeyboard and: [ self keyCharacter = Character escape ].
]
