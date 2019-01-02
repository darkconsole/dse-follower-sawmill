Scriptname dse_saw_EffectFollowerHelp extends activemagiceffect  

Quest Property QuestFollowerHelp Auto

Event OnEffectStart(Actor Who, Actor Caster)

	dse_saw_QuestFollowerHelp Main = (QuestFollowerHelp As dse_saw_QuestFollowerHelp)

	If(Main.IsRunning())
		Main.Prepare(FALSE)
		Debug.Notification("We are done with the sawmill.")
	Else
		Main.Start()
		Main.Help(None)
	EndIf

	Return
EndEvent
