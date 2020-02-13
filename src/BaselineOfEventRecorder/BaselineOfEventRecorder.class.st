"
Baseline for https://github.com/astares/Pharo-EventRecorder
"
Class {
	#name : #BaselineOfEventRecorder,
	#superclass : #BaselineOf,
	#category : #BaselineOfEventRecorder
}

{ #category : #baseline }
BaselineOfEventRecorder >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			"Packages"
			spec 
				package: 'EventRecorder-Core';
				package: 'EventRecorder-Core-Tests' with: [ spec requires: #('EventRecorder-Core') ].
			
			"Groups"	
			spec	
				group: 'Core' with: #('EventRecorder-Core');
				group: 'Tests' with: #('EventRecorder-Core-Tests');
				group: 'all' with: #('Core' 'Tests');
				group: 'default' with: #('all')	
	]
]
