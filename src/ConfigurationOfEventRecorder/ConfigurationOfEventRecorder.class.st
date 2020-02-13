"
Configuration for event recorder
"
Class {
	#name : #ConfigurationOfEventRecorder,
	#superclass : #Object,
	#instVars : [
		'project'
	],
	#classVars : [
		'LastVersionLoad'
	],
	#category : #ConfigurationOfEventRecorder
}

{ #category : #'development support' }
ConfigurationOfEventRecorder class >> DevelopmentSupport [

"See the methods in the 'development support' category on the class-side of MetacelloBaseConfiguration. Decide what development support methods you would like to use and copy them the the class-side of your configuration."
	<apiDocumentation>

]

{ #category : #private }
ConfigurationOfEventRecorder class >> baseConfigurationClassIfAbsent: aBlock [

	^Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			self ensureMetacelloBaseConfiguration.
			Smalltalk at: #MetacelloBaseConfiguration ifAbsent: aBlock ].

]

{ #category : #catalog }
ConfigurationOfEventRecorder class >> catalogChangeLog [
	"Returns a paragraph describing the most important changes in the configuration class."
	^ ' '
]

{ #category : #catalog }
ConfigurationOfEventRecorder class >> catalogContactInfo [
	"Returns a paragraph describing contact information such as email, mailing lists and website."
	^ 'You can reach the author on the Pharo mailinglist (http://lists.pharo.org)'
]

{ #category : #catalog }
ConfigurationOfEventRecorder class >> catalogDescription [
	"Returns a paragraph describing the project"
	^ 'Record and replay screen events.'
]

{ #category : #catalog }
ConfigurationOfEventRecorder class >> catalogKeyClassesAndExample [
	"Returns a paragraph or more describing the key classes of your project. You can use Pillar/Pier syntax to layout out the text i.e., ==Code== and - for bullet."
	^ ' '
]

{ #category : #catalog }
ConfigurationOfEventRecorder class >> catalogKeywords [
	"Returns an array of symbols"
	^ #(screen recording) 
]

{ #category : #private }
ConfigurationOfEventRecorder class >> ensureMetacello [

	(self baseConfigurationClassIfAbsent: []) ensureMetacello
]

{ #category : #private }
ConfigurationOfEventRecorder class >> ensureMetacelloBaseConfiguration [

	Smalltalk
		at: #MetacelloBaseConfiguration
		ifAbsent: [ 
			| repository version |
			repository := MCHttpRepository location: 'http://seaside.gemstone.com/ss/metacello' user: '' password: ''.
			repository
				versionReaderForFileNamed: 'Metacello-Base-DaleHenrichs.2.mcz'
				do: [ :reader | 
					version := reader version.
					version load.
					version workingCopy repositoryGroup addRepository: repository ] ]
]

{ #category : #'metacello tool support' }
ConfigurationOfEventRecorder class >> isMetacelloConfig [
	"Answer true and the Metacello tools will operate on you"
	
	^true
]

{ #category : #loading }
ConfigurationOfEventRecorder class >> load [
	"Load the #stable version defined for this platform. The #stable version is the version that is recommended to be used on this platform."

	"self load"

	<apiDocumentation>
	^(self project version: #stable) load
]

{ #category : #loading }
ConfigurationOfEventRecorder class >> loadBleedingEdge [
	"Load the latest versions of the mcz files defined for this project. It is not likely that the #bleedingEdge has been tested."

	"self loadBleedingEdge"

	<apiDocumentation>
	^(self project version: #bleedingEdge) load
]

{ #category : #loading }
ConfigurationOfEventRecorder class >> loadDevelopment [
	"Load the #development version defined for this platform. The #development version will change over time and is not expected to be stable."

	"self loadDevelopment"

	<apiDocumentation>
	^(self project version: #development) load
]

{ #category : #accessing }
ConfigurationOfEventRecorder class >> project [

	^self new project
]

{ #category : #'development support' }
ConfigurationOfEventRecorder class >> validate [
	"Check the configuration for Errors, Critical Warnings, and Warnings (see class comment for MetacelloMCVersionValidator for more information). 
	Errors identify specification issues that will result in unexpected behaviour when you load the configuration. 
	Critical Warnings identify specification issues that may result in unexpected behavior when you load the configuration.
	Warnings identify specification issues that are technically correct, but are worth take a look at."

	"self validate"

	<apiDocumentation>
	self ensureMetacello.
	^ ((Smalltalk at: #MetacelloToolBox) validateConfiguration: self debug: #() recurse: false) explore
]

{ #category : #baselines }
ConfigurationOfEventRecorder >> baseline01: spec [
	<version: '0.1-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/TorstenBergmann/EventRecorder/main/'.
		spec 
			package: 'EventRecorder-Core';
			package: #'EventRecorder-Tests-Core' with: [
				spec requires: #('EventRecorder-Core' ). ].
		spec 
			group: 'Core' with: #('EventRecorder-Core' );
			group: 'Tests' with: #(#'EventRecorder-Tests-Core' );
			group: 'default' with: #('Core' 'default' ). ].

]

{ #category : #baselines }
ConfigurationOfEventRecorder >> baseline02: spec [
	<version: '0.2-baseline'>

	spec for: #'common' do: [
		spec blessing: #'baseline'.
		spec repository: 'http://smalltalkhub.com/mc/TorstenBergmann/EventRecorder/main/'.
		spec 
			package: 'EventRecorder-Core';
			package: #'EventRecorder-Tests-Core' with: [
				spec requires: #('EventRecorder-Core' ). ].
		spec 
			group: 'Core' with: #('EventRecorder-Core' );
			group: 'Tests' with: #(#'EventRecorder-Tests-Core' );
			group: 'default' with: #('Core' 'default' ). ].

]

{ #category : #baselines }
ConfigurationOfEventRecorder >> baseline03: spec [
	<version: '0.3-baseline'>

	spec for: #'common' do: [ 
		spec
			baseline: 'EventRecorder' with: [ 
				spec 
					className: 'BaselineOfEventRecorder';
					repository: 'github://astares/Pharo-EventRecorder:master/src' ]]
]

{ #category : #accessing }
ConfigurationOfEventRecorder >> customProjectAttributes [
	 "Edit to return a collection of any custom attributes e.g. for conditional loading: Array with: #'Condition1' with: #'Condition2.
	For more information see: http://code.google.com/p/metacello/wiki/CustomProjectAttrributes"

	^ #().
]

{ #category : #'symbolic versions' }
ConfigurationOfEventRecorder >> development: spec [
	<symbolicVersion: #'development'>

	spec for: #'common' version: '0.3-baseline'.

]

{ #category : #accessing }
ConfigurationOfEventRecorder >> project [

	^ project ifNil: [ 
		"Bootstrap Metacello if it is not already loaded"
		(self class baseConfigurationClassIfAbsent: []) ensureMetacello.
		"Construct Metacello project"
		project := MetacelloMCProject new projectAttributes: self customProjectAttributes. 
		(Smalltalk at: #MetacelloVersionConstructor) on: self project: project.
		project loadType: #linear. "change to #atomic if desired"
		project ]
]

{ #category : #'symbolic versions' }
ConfigurationOfEventRecorder >> stable: spec [
	<symbolicVersion: #'stable'>

	spec for: #'common' version: '0.2'.

]

{ #category : #versions }
ConfigurationOfEventRecorder >> version01: spec [
	<version: '0.1' imports: #('0.1-baseline' )>

	spec for: #'common' do: [
		spec blessing: #'stable'.
		spec description: 'version 0.1'.
		spec author: 'TorstenBergmann'.
		spec timestamp: '1/9/2015 23:24'.
		spec 
			package: 'EventRecorder-Core' with: 'EventRecorder-Core-TorstenBergmann.7';
			package: #'EventRecorder-Tests-Core' with: 'EventRecorder-Tests-Core-TorstenBergmann.1'. ].

]

{ #category : #versions }
ConfigurationOfEventRecorder >> version02: spec [
	<version: '0.2'>

	spec for: #'common' do: [ 
		spec
			baseline: 'EventRecorder' with: [ 
				spec 
					className: 'BaselineOfEventRecorder';
					repository: 'github://astares/Pharo-EventRecorder:0.2/src' ]]
]
