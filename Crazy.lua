local CrazyX = {}

CrazyX.optionEnable = Menu.AddOptionBool({"Utility", "CrazyX"}, "Activation", true)
CrazyX.AutoUseBottle = Menu.AddOptionBool({"Utility", "CrazyX", "AutoUseItems"}, "Bottle", true)
CrazyX.AutoUsePhaseBoots = Menu.AddOptionBool({"Utility", "CrazyX", "AutoUseItems"}, "Phase Boots", true)
CrazyX.AutoDisableOrchid = Menu.AddOptionBool({"Utility", "CrazyX", "Disabler"}, "Orchid", true)
CrazyX.AutoDisableBloodthorn = Menu.AddOptionBool({"Utility", "CrazyX", "Disabler"}, "Bloodthorn", true)
CrazyX.AutoDisableHex = Menu.AddOptionBool({"Utility", "CrazyX", "Disabler"}, "Hex", true)

function CrazyX.OnUpdate()
myHero = Heroes.GetLocal()
myMana = NPC.GetMana(myHero)
bottle = NPC.GetItem(myHero, "item_bottle")
phaseboots = NPC.GetItem(myHero, "item_phase_boots")
orchid = NPC.GetItem(myHero, "item_orchid")
hex = NPC.GetItem(myHero, "item_sheepstick")
bloodthorn = NPC.GetItem(myHero, "item_bloodthorn")
enemy = Input.GetNearestHeroToCursor(Entity.GetTeamNum(myHero), Enum.TeamType.TEAM_ENEMY)

if not Menu.IsEnabled(CrazyX.optionEnable) then 
	return
end

if Menu.IsEnabled(CrazyX.AutoUseBottle) then
	CrazyX.AutoBottle()
end

if Menu.IsEnabled(CrazyX.AutoUsePhaseBoots) then
	CrazyX.AutoPhaseBoots()
end

if Menu.IsEnabled(CrazyX.AutoDisableOrchid) then
	CrazyX.AutoDisableEnemyOrchid()
end
	
if Menu.IsEnabled(CrazyX.AutoDisableBloodthorn) then
	CrazyX.AutoDisableEnemyBloodthorn()
end
	
if Menu.IsEnabled(CrazyX.AutoDisableHex) then
		CrazyX.AutoDisableEnemyHex()
	end
end

function CrazyX.AutoBottle()
	if NPC.HasModifier(myHero, "modifier_fountain_aura_buff") and Ability.IsReady(bottle) then
		if Entity.GetHealth(myHero) < Entity.GetMaxHealth(myHero) or NPC.GetMana(myHero) < NPC.GetMaxMana(myHero) then
			if not NPC.HasModifier(myHero, "modifier_bottle_regeneration") and not NPC.IsChannellingAbility(myHero) then 	
				Ability.CastNoTarget(bottle) 
			end
		end
	end
end

function CrazyX.AutoPhaseBoots()
	if phaseboots and Ability.IsReady(phaseboots) and NPC.IsRunning(myHero) then 
		Ability.CastNoTarget(phaseboots)
	end
end

function CrazyX.AutoDisableEnemyOrchid()
	if orchid and enemy and Ability.IsReady(orchid) and Ability.IsCastable(orchid, myMana) and NPC.IsEntityInRange(myHero, enemy, 600) then
		Ability.CastTarget(orchid, enemy)
	end
end

function CrazyX.AutoDisableEnemyBloodthorn()
	if bloodthorn and enemy and Ability.IsReady(bloodthorn) and Ability.IsCastable(bloodthorn, myMana) and NPC.IsEntityInRange(myHero, enemy, 600) then
		Ability.CastTarget(bloodthorn, enemy)
	end
end
	
function CrazyX.AutoDisableEnemyHex()
	if hex and enemy and Ability.IsReady(hex) and Ability.IsCastable(hex, myMana) and NPC.IsEntityInRange(myHero, enemy, 600) then
		Ability.CastTarget(hex, enemy)
	end
end

return CrazyX