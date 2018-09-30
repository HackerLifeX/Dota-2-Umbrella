local Tiny = {}

Tiny.ScriptON = Menu.AddOptionBool({"Hero Specific", "Tiny"}, "Enable", false)
Tiny.ComboKey = Menu.AddKeyOption({ "Hero Specific", "Tiny" }, "Combo Key", Enum.ButtonCode.BUTTON_CODE_NONE)
Tiny.TossEnemyKey = Menu.AddKeyOption({ "Hero Specific", "Tiny" }, "TossEnemy Key", Enum.ButtonCode.BUTTON_CODE_NONE)
Tiny.BlinkCombo = Menu.AddOptionBool({"Hero Specific", "Tiny", "Use", "Items"}, "Blink", false)
Tiny.BKBCombo = Menu.AddOptionBool({"Hero Specific", "Tiny", "Use", "Items"}, "BKB", false)
Tiny.OrchidCombo = Menu.AddOptionBool({"Hero Specific", "Tiny", "Use", "Items"}, "Orchid", false)
Tiny.BloodthornCombo = Menu.AddOptionBool({"Hero Specific", "Tiny", "Use", "Items"}, "Bloodthorn", false)
Tiny.HexCombo = Menu.AddOptionBool({"Hero Specific", "Tiny", "Use", "Items"}, "Hex", false)
Tiny.NullifierCombo = Menu.AddOptionBool({"Hero Specific", "Tiny", "Use", "Items"}, "Nullifier", false)
Tiny.VeilCombo = Menu.AddOptionBool({"Hero Specific", "Tiny", "Use", "Items"}, "Veil of Discord", false)
Tiny.TossCombo = Menu.AddOptionBool({"Hero Specific", "Tiny", "Use", "Ability"}, "Toss", false)
Tiny.AvalancheCombo = Menu.AddOptionBool({"Hero Specific", "Tiny", "Use", "Ability"}, "Avalanche", false)
Tiny.TreeCombo = Menu.AddOptionBool({"Hero Specific", "Tiny", "Use", "Ability"}, "Tree", false)

function Tiny.OnUpdate()

myHero = Heroes.GetLocal()
enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)
enemyPos = Entity.GetAbsOrigin(enemy)
myTeamPOS = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_FRIEND)
Blink = NPC.GetItem(myHero, "item_blink")
BKB = NPC.GetItem(myHero, "item_black_king_bar")
Toss = NPC.GetAbility(myHero, "tiny_toss")
Orchid = NPC.GetItem(myHero, "item_orchid")
Bloodthorn = NPC.GetItem(myHero, "item_bloodthorn")
Sheepstick = NPC.GetItem(me, "item_sheepstick")
Nullifier = NPC.GetItem(me, "item_nullifier")
Veildiscord = NPC.GetItem(me, "item_veil_of_discord")
Avalanche = NPC.GetAbility(myHero, "tiny_avalanche")
treetoss = NPC.GetAbility(myHero, "tiny_toss_tree")

	if not Menu.IsEnabled(Tiny.ScriptON) then
		return
	end
	
	if not Engine.IsInGame() then
		return
	end
	
	if Menu.IsKeyDownOnce(Tiny.TossEnemyKey) then
		Tiny.TossEnemyTeam()
	end
	
	if Menu.IsKeyDownOnce(Tiny.ComboKey) then
		Tiny.UseCombo()
	end
end

function Tiny.UseCombo()
	if Menu.IsEnabled(Tiny.BKBCombo) then
		if BKB and Ability.IsReady(BKB) then
				Ability.CastNoTarget(BKB)
			return
		end
	end	

	if Menu.IsEnabled(Tiny.BlinkCombo) then
		if Blink and Ability.IsReady(Blink) then
				Ability.CastPosition(Blink, enemyPos)
			return
		end
	end
	
	if Menu.IsEnabled(Tiny.HexCombo) then
		if Sheepstick and Ability.IsReady(Sheepstick) then
				Ability.CastTarget(Sheepstick, enemy)
			return
		end
	end	
	
	if Menu.IsEnabled(Tiny.VeilCombo) then
		if Veildiscord and Ability.IsReady(Veildiscord) then
				Ability.CastPosition(Veildiscord, enemyPos)
			return
		end
	end
	
	if Menu.IsEnabled(Tiny.OrchidCombo) then
		if Orchid and Ability.IsReady(Orchid) then
				Ability.CastTarget(Orchid, enemy)
			return
		end
	end	
	
	if Menu.IsEnabled(Tiny.BloodthornCombo) then
		if Bloodthorn and Ability.IsReady(Bloodthorn) then
				Ability.CastTarget(Bloodthorn, enemy)
			return
		end
	end	
	
	if Menu.IsEnabled(Tiny.TossCombo) then
		if Toss and Ability.IsReady(Toss) then
				Ability.CastTarget(Toss, enemy)
			return
		end
	end	

	if Menu.IsEnabled(Tiny.AvalancheCombo) then
		if Avalanche and Ability.IsReady(Avalanche) then
				Ability.CastPosition(Avalanche, enemyPos)
			return
		end
	end
	
	if Menu.IsEnabled(Tiny.NullifierCombo) then
		if Nullifier and Ability.IsReady(Nullifier) then
				Ability.CastTarget(Nullifier, enemy)
			return
		end
	end	
	
	if Menu.IsEnabled(Tiny.TreeCombo) then
		if treetoss and Ability.IsReady(treetoss) then
				Ability.CastTarget(treetoss, enemy)
			return
		end
	end	
end

function Tiny.TossEnemyTeam()
	if Toss and enemy and myHero and myTeamPOS then
		Ability.CastPosition(Blink, enemyPos)
		if NPC.IsEntityInRange(myHero, myTeamPOS, Ability.GetCastRange(Toss)) then
			Ability.CastTarget(Toss, myTeamPOS)
			return
		end
	end
end
		
return Tiny 
