"
A panel for using the event recorder
"
Class {
	#name : #EventRecoderPanel,
	#superclass : #ComposableModel,
	#instVars : [
		'model',
		'playModel',
		'stopModel',
		'pauseModel',
		'recordModel',
		'descriptionModel',
		'importModel',
		'exportModel'
	],
	#classVars : [
		'Icon'
	],
	#category : #'EventRecorder-Core-UI'
}

{ #category : #specs }
EventRecoderPanel class >> defaultSpec [
	<spec: #default>
	^ SpecColumnLayout composed
		newRow: [ :row | 
			row
				add: #importModel;
				add: #exportModel ]
			height: self toolbarHeight; 	
		newRow: [ :row | 
			row
				add: #playModel;
				add: #stopModel;
				add: #pauseModel;
				add: #recordModel ]
			height: self toolbarHeight;		
		 
			
			yourself
]

{ #category : #'private - icon handling' }
EventRecoderPanel class >> eventRecorderIcon [

	Icon ifNil: [ Icon := self eventRecorderIconForm ].
	^Icon
]

{ #category : #'private - icon handling' }
EventRecoderPanel class >> eventRecorderIconForm [

	^(Form
	extent: (16@16)
	depth: 32
	fromArray: #( 0 0 0 0 813991044 2525267076 3632431746 4169171072 4169171072 3632431746 2525201283 813925251 0 0 0 0 0 0 159416448 2558558336 4269439610 4285558896 4286808963 4287730065 4287730065 4286808963 4285558896 4269439610 2558558336 159416448 0 0 0 159153276 3229383804 4285558896 4287532686 4291809231 4293190884 4293519849 4293454056 4292927712 4291546059 4287532686 4285558896 3229383804 159153276 0 0 2558163578 4285361517 4288980132 4293388263 4294111986 4294440951 4294572537 4294506744 4294309365 4293848814 4292796126 4288848546 4285361517 2558163578 0 813135735 4268847473 4287401100 4293454056 4294375158 4294704123 4294835709 4294901502 4294835709 4294835709 4294638330 4294046193 4292796126 4287335307 4268847473 813135735 2524214388 4284900966 4291940817 4294243572 4294769916 4294834681 4293563542 4292690759 4292556603 4293295745 4294768631 4294638330 4293783021 4291480266 4284900966 2524148595 3631181679 4286216826 4293125091 4294506744 4294901502 4293630877 4292953417 4293212732 4293078063 4292549921 4293162874 4294835709 4294243572 4292796126 4286216826 3631181679 4167789419 4287203721 4293190884 4294506744 4294901502 4292691530 4293279811 4293803069 4293734449 4292943136 4292221727 4294835709 4294506744 4293190884 4287203721 4167789419 4167526247 4287137928 4293190884 4294506744 4294835709 4292088343 4292740617 4293462540 4293528076 4292740617 4292088343 4294835709 4294506744 4293190884 4287137928 4167526247 3630589542 4285822068 4292796126 4294243572 4294835709 4293095025 4292281352 4292740617 4292740617 4292281096 4293095025 4294835709 4294243572 4292796126 4285822068 3630589542 2523161700 4284045657 4291414473 4293783021 4294638330 4294768631 4293095025 4292088343 4292088343 4293095025 4294768631 4294638330 4293783021 4291414473 4284045657 2523161700 811754082 4267465820 4286743170 4292796126 4294046193 4294638330 4294835709 4294835709 4294835709 4294835709 4294638330 4294046193 4292796126 4286743170 4267465820 811754082 0 2556321374 4283716692 4288322202 4292796126 4293783021 4294243572 4294506744 4294506744 4294243572 4293783021 4292796126 4288387995 4283716692 2556321374 0 0 157047900 3227146842 4283519313 4286545791 4291414473 4292796126 4293190884 4293190884 4292796126 4291414473 4286545791 4283519313 3227146842 157047900 0 0 0 156784728 2555860823 4266873683 4283387727 4285229931 4286611584 4286611584 4285229931 4283387727 4266873683 2555860823 156784728 0 0 0 0 0 0 810898773 2522109012 3629339475 4166144594 4166144594 3629339475 2522109012 810898773 0 0 0 0)
	offset: (0@0))
]

{ #category : #'class initialization' }
EventRecoderPanel class >> initialize [

	 World on: $e command do: [ EventRecoderPanel open ].
]

{ #category : #'world menu' }
EventRecoderPanel class >> menuCommandOn: aBuilder [ 
	<worldMenu> 
	
	(aBuilder item: #'Event Recorder')
		parent: #Tools;
		icon: self eventRecorderIcon;
		action:[ self open ]
]

{ #category : #'user interface' }
EventRecoderPanel class >> open [
	"
	self open
	"
	
	^(self new) 
		title: 'Event Recorder' ;
		openWithSpec;
		yourself
]

{ #category : #accessing }
EventRecoderPanel >> exportModel [

	^exportModel
]

{ #category : #accessing }
EventRecoderPanel >> importModel [

	^importModel
]

{ #category : #defaults }
EventRecoderPanel >> initialExtent [

	^355@95
]

{ #category : #initialization }
EventRecoderPanel >> initializeWidgets [
	importModel := self newButton.
	exportModel := self newButton.
	
	playModel := self newButton.
	stopModel := self newButton.
	recordModel := self newButton.
	pauseModel := self newButton.
	
	self update
]

{ #category : #accessing }
EventRecoderPanel >> model [

	model ifNil: [ model := EventRecorder new ].
	^model
]

{ #category : #accessing }
EventRecoderPanel >> pauseModel [

	^pauseModel 
]

{ #category : #accessing }
EventRecoderPanel >> playModel [

	^playModel 
]

{ #category : #accessing }
EventRecoderPanel >> recordModel [

	^recordModel 
]

{ #category : #'private - initialization' }
EventRecoderPanel >> setDescriptionModel [
	self title: 'Event Recorder - ', self model stateDescription
]

{ #category : #'private - initialization' }
EventRecoderPanel >> setExportModel [
	exportModel
		enabled: self model canExport;
		label: 'Export...';
		icon: Smalltalk ui icons smallSaveAs;
		action: [ (UIManager default chooseForSaveFileReference: 'Export to .ston file' extensions: #('ston') path: Smalltalk imageFile path)
				ifNotNil: [ :file | 
					file
						ensureDelete;
						writeStreamDo: [ :stream | stream nextPutAll: self model export ].
					self inform: 'Exported to ' , file fullName ] ]  
]

{ #category : #'private - initialization' }
EventRecoderPanel >> setImportModel [
	importModel
		enabled: self model canImport;
		label: 'Import...';
		icon: Smalltalk ui icons smallOpen;
		action: [ (UIManager default chooseExistingFileReference: 'Import from .ston file' extensions: #('ston') path: Smalltalk imageFile path)
				ifNotNil: [ :stream | 
					self model import: stream contents.
					self update ] ]
]

{ #category : #'private - initialization' }
EventRecoderPanel >> setPauseModel [
	
	pauseModel
		enabled: self model canPause;
		label: 'Pause';
		action: [ self model pause.
				 self update ].
]

{ #category : #'private - initialization' }
EventRecoderPanel >> setPlayModel [
	
	playModel
		enabled: self model canPlay;
		label: 'Play';
		icon: Smalltalk ui icons smallDoItIcon;
		action: [ self model play. 
				 self update ].
]

{ #category : #'private - initialization' }
EventRecoderPanel >> setRecordModel [
	
	recordModel
		enabled: self model canRecord;
		label: 'Record';
		icon: self class eventRecorderIcon;
		action: [  self model record. 
				  self update ].
]

{ #category : #'private - initialization' }
EventRecoderPanel >> setStopModel [
	
	stopModel
		enabled: self model canStop;
		label: 'Stop';
		action: [ 
			      self model stop.
				self update ].
]

{ #category : #'private - initialization' }
EventRecoderPanel >> setTitle [
	self title: 'Event Recorder - ', self model stateDescription
]

{ #category : #accessing }
EventRecoderPanel >> stopModel [

	^stopModel 
]

{ #category : #'private - initialization' }
EventRecoderPanel >> update [
	self 
		setTitle;
		setPlayModel;
		setStopModel;
		setRecordModel;
		setPauseModel;
		setImportModel;
		setExportModel
]
