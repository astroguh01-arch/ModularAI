local NormalAI = {}
NormalAI.__index = NormalAI











local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")
local ServerRunning = false
local Connection
local combattable = require(game.ServerStorage.CombatTable)

local TS = game:GetService("TweenService")
local Responses = game.ReplicatedStorage.Responses
local Alive = {}
local function CheckDistance(Character,Target)
	if Character.HumanoidRootPart and Target.HumanoidRootPart then
		return (Character.HumanoidRootPart.Position - Target.HumanoidRootPart.Position).Magnitude
	end
end
local function GetTargetData(Target,Info)

	local key
	if Target:IsA("Player") then
	 key = Target.UserId 
	else
		key = Target.Name
	end
	local data = combattable[key]
    
	if not data then
		warn("No combat data for target:", key)
		return nil
	end

	Info.TargetTable = data

	
	
	return data

end
local function State(Info)
	local nextPhaseHealth = Info.PhaseHP[Info.Phase + 1]
	if nextPhaseHealth and Info.Stat._Char.Humanoid.Health <= nextPhaseHealth then
		Info.Phase += 1
	end

	local conditions = Info.Stat.Conditions[Info.Phase]
	if not conditions then
		return
	end

	for _, condition in pairs(conditions) do
		if condition.Condition then
			if condition.Condition(Info) == condition.Limit then
				Info.State = condition.State
			end
		elseif condition.Stat and Info.Stat[condition.Stat] == condition.Limit then
			Info.State = condition.State
		end
	end
end
	local function AiRuntime()
		ServerRunning = true

	

		Connection = RunService.Heartbeat:Connect(function(deltaTime)
		for i,Info in ipairs(Alive) do
		
			if Info.Stat._Char then
				
			
						if Info.Stat.CombatTag then
							GetTargetData(Info.Stat.CombatTag,Info)
						
							local RUN_SPEED = 16
						
							Info.Stat._Char.Humanoid.WalkSpeed = RUN_SPEED
							
						

					if not  Info.TargetTable.Stat.plr.Character then return end
					
					local char = Info.TargetTable.Stat.plr.Character
						
					Info.AO.CFrame = CFrame.lookAt(Info.Character.HumanoidRootPart.CFrame.Position, Vector3.new(char.HumanoidRootPart.CFrame.Position.X,char.HumanoidRootPart.CFrame.Position.Y,char.HumanoidRootPart.CFrame.Position.Z))
							
					local TargetCF = CFrame.lookAt(Info.Character.HumanoidRootPart.CFrame.Position, Vector3.new(char.HumanoidRootPart.CFrame.Position.X,char.HumanoidRootPart.CFrame.Position.Y,char.HumanoidRootPart.CFrame.Position.Z))
					Info.Character.HumanoidRootPart.CFrame = Info.Character.HumanoidRootPart.CFrame:lerp(TargetCF,0.1)
								   
								
							
									
					State(Info)
					
					local Response = Info.Stat.Responses[Info.State]
					
					if Response then
						local responseModule = Responses:FindFirstChild(Info.Boss)
						if responseModule and responseModule:IsA("ModuleScript") then
							require(responseModule).Activate(Response, Info)
						else
							warn("Missing boss response module:", Info.Boss)
						end
					end    
									
								
							
						
					
			
				
			
				
	              end
			if #Alive <= 0 then
				ServerRunning = false
				Connection:Disconnect()
			end
          end
		end
		end)

	end



function NormalAI.New(CombatData,Weapon)
	--CharacterSetUp.SetupCharacter(Character,true,{Weapon = Weapon})
	local Info = {}
	local CombatData = CombatData
	local RUN_SPEED = 20


	Info.Stat = CombatData.Stat
	Info.Character = Info.Stat._Char
	Info.Weapon = Weapon
	
	--Character:SetAttribute("Weapon","Fists")
	Info.Stat._Char.Humanoid.WalkSpeed = RUN_SPEED


	Info.UsingMove = CombatData.Stat._Move
	Info.Phase = 1

	Info.Combo = 1
	Info.State = "None"
	Info.Boss = CombatData.Stat.Boss
	Info.Stat.Conditions = require(game.ReplicatedStorage.BossTable)[Info.Boss].Conditions
	Info.Stat.Responses = require(game.ReplicatedStorage.BossTable)[Info.Boss].Responses
	Info.PhaseHP = require(game.ReplicatedStorage.BossTable)[Info.Boss].PhaseHP

	Info.Connections = {}
	Info.AO = Instance.new("AlignOrientation", Info.Stat._Char.HumanoidRootPart)
	local Attachment = Instance.new("Attachment",Info.Stat._Char.HumanoidRootPart)
	Info.AO.Attachment0 = Attachment
	Info.AO.AlignType = Enum.AlignType.AllAxes
	Info.AO.Mode = Enum.OrientationAlignmentMode.OneAttachment


	local humanoid = Info.Stat._Char:FindFirstChildOfClass("Humanoid")
	if humanoid then
		Info.Connections.Died = humanoid.Died:Connect(function()
			for index = #Alive, 1, -1 do
				if Alive[index] == Info then
					table.remove(Alive, index)
					break
				end
			end
		
			if Info.Character and Info.Character.Parent then
				game.Debris:AddItem(Info.Character, 1)
			end
			if #Alive == 0 then
				ServerRunning = false
				if Connection then
					Connection:Disconnect()
					Connection = nil
				end
			end
		end)
	end

	Alive[#Alive + 1] = Info
	if not ServerRunning then
		AiRuntime()
	end

end

return NormalAI
