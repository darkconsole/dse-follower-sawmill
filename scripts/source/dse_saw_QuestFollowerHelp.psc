Scriptname dse_saw_QuestFollowerHelp extends Quest Conditional

Actor Property Player Auto
ReferenceAlias Property Follower Auto
ReferenceAlias Property Sawmill Auto
Bool Property Triggered = FALSE Auto Hidden

Function Prepare(Bool Begin=FALSE)
{prepare the quest to re-search for usable references.}

	;; reset and stop the quest.

	self.Reset()
	self.Stop()

	;; flush the old references.

	Follower.Clear()
	Sawmill.Clear()

	;; and restart if asked.

	If(Begin)
		self.Start()
	EndIf

	Return
EndFunction

Event OnInit()
{handle quest bootup.}

	self.Triggered = FALSE
	self.RegisterForSingleUpdate(0.5)

	Return
EndEvent

Event OnUpdate()
{handle quest maintenance.}

	;; if the quest was launched and never launched then shut it
	;; back down.

	If(!self.Triggered)
		self.Prepare(FALSE)
		Return
	EndIf	

	Return
EndEvent

Event OnAnimationEvent(ObjectReference What, String Which)
{handle various animation events.}

	Actor Who = Follower.GetActorReference()

	If(Which == "MillLogIdleReset")
		;; when the sawmill resets we will trick the game into
		;; getting the follower to start again as soon as it gives
		;; the gold. otherwise she stands around a while waiting
		;; for her package to notice the saw reset itself.

		Follower.Clear()
		Follower.ForceRefTo(Who)
		Who.EvaluatePackage()
	EndIf

	Return
EndEvent

Function Help(Actor Who=None)
{tell your follower to start helping you.}

	self.Triggered = TRUE

	If(Who == None)
		Who = Follower.GetActorReference()
	Else
		Follower.ForceRefTo(Who)
	EndIf

	If(Who != None && Sawmill.GetReference() != None)
		Who.EvaluatePackage()
		Debug.Notification(Who.GetDisplayName() + " will load logs onto the sawmill.")
		self.RegisterForAnimationEvent(Sawmill.GetReference(),"MillLogIdleReset")
	Else
		self.Prepare(FALSE)
		Debug.Notification("There are no sawmills or followers to help nearby.")
	EndIf

	Return
EndFunction
