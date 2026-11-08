local function getDistance(info)
	local boss = info.Stat and info.Stat._Char
	local targetData = info.TargetTable
	local target = targetData and targetData.Stat and targetData.Stat._Char
	local bossRoot = boss and boss:FindFirstChild("HumanoidRootPart")
	local targetRoot = target and target:FindFirstChild("HumanoidRootPart")

	if not bossRoot or not targetRoot then
		return math.huge
	end

	return (bossRoot.Position - targetRoot.Position).Magnitude
end

local function isClose(info)
	return getDistance(info) <= 12
end

local function isFar(info)
	return getDistance(info) > 12
end

local function isFarReady(info)
	return isFar(info) and info.FarCooldown ~= true
end

local function isFarOnCooldown(info)
	return isFar(info) and info.FarCooldown == true
end
local function isCloseCD(info)
	return isClose(info) and info.CloseCD == true
end


local module = {
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
	CaveGuardian = {
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
}

return module
