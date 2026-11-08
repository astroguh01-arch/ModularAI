# ModularAI
A lightweight, dependency-free modular AI system for Roblox.

## Guide

Modular AI has Conditions,Limits,States and Responses.

 * A Condition is a value that is expected to be true or false
 * A Limit is for conditions that rely on more than booleans such as hits taken
 * A State is what the result of a condition is such as when Condition Close is true then State is Attack
 * A Response is the action the ai takes when in a given state.
 * A Phase is simply another set of rules followed when the hp of the ai is at some given value,although it could be edited to be changed at any condition
 
 ## Example

	Test = {
		Conditions = {
			[1] = {
				{ Condition = isClose, Limit = true, State = "ShortCombo" },
				{ Condition = isFarReady, Limit = true, State = "Far" },
				{ Condition = isFarOnCooldown, Limit = true, State = "Chase" },
				{ Condition = isCloseCD, Limit = true, State = "Chase" },
			},
			[2] = {
				{ Condition = isClose, Limit = true, State = "LongCombo" },
				{ Condition = isFarReady, Limit = true, State = "Far" },
				{ Condition = isFarOnCooldown, Limit = true, State = "Chase" },
				{ Condition = isCloseCD, Limit = true, State = "Chase" },
			},
		},
		Responses = {
			ShortCombo = "ShortCombo",
			LongCombo = "LongCombo",
			Far = "Far",
			Chase = "Chase",
		},
		PhaseHP = { [2] = 50 },
	},

  # Uses
  AIs for bosses
  AIs with dialogue based on actions 

  For support  https://discord.gg/97dgGFEzh
