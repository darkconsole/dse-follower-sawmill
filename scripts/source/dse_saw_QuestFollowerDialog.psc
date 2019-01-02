Scriptname dse_saw_QuestFollowerDialog extends Quest  

Actor Property Player Auto
Spell Property Toggle Auto

Event OnInit()

	If(!self.Player.HasSpell(self.Toggle))
		self.Player.AddSpell(self.Toggle)
	EndIf

	Return
EndEvent
