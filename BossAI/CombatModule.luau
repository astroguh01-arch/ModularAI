local Combat = {}
local CombatTable = require(game.ServerStorage.CombatTable)
function Combat.Initiate(Player)

	print(Player)
	if not Player:IsA("Model") then
	CombatTable[Player.UserId] =  {}
	CombatTable[Player.UserId] = {Stat = {
		Stun = false;
		IFrames = false;
		Knocked = false;
		Gripped = false;
		Gripping = false;
		Killed = false;
		Counter = 0;
		Posture = 0;
		MaxStamina = 100;
		MaxPosture = 200;
		UID = Player.UserId;
        MaxMana = 200;
		Stamina = 100;
		Mana = 200;
		plr = Player;
		Damage = 5;
		Blocking = false;
		HeavyDMG = 20;
		CombatTag = "";
		ParryFrames =  false;
		Status = {};
		_PostureDecay = false;
		_StaminaRegen = false;
		_ManaRegen = false;
		_counterToken = false;
		_ParryLock = false ;
		_CombatStun = false;
		_Dash = false;
		_Hitbox = Vector3.new(5,5,5);
		_LastSwing = nil;
		_Duration = 0;
		_StunCheck = nil;
		_Char = Player.Character;
		_Move = false;
		_State = "Idle";
		_Action = "None";
		_DIH = 270;
		_CD = {};
		
	}}
	else
	
		CombatTable[Player.Name] =  {}
		CombatTable[Player.Name] = {Stat = {
			Stun = false;
			IFrames = false;
			Counter = 0;
			Posture = 0;
			Damage = 5;
			HeavyDMG = 20;
			MaxStamina = 100;
			Stamina = 100;
			CombatTag = false;
			Status = {};
			ParryFrames =  false;
			_PostureDecay = false;
			_StaminaRegen = false;
			_counterToken = false;
			_ParryLock = false ;
			_CombatStun = false;
			_Hitbox = Vector3.new(5,5,5);
			_LastSwing = nil;
			_Dash = false;
			_Duration = 0;
			_StunCheck = nil;
			_AI = true;
			_Char = Player;
			_Move = false;
			_State = "Idle";
			_Action = "None";
			_CD = {};
		}}
	  end



end
return Combat
