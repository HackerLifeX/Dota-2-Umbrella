local CrazyX = {}

CrazyX.optionEnable = Menu.AddOptionBool({"Utility", "CrazyX"}, "Activation", true)
CrazyX.AutoUseBottle = Menu.AddOptionBool({"Utility", "CrazyX", "AutoUseItems"}, "Bottle", true)
CrazyX.AutoUsePhaseBoots = Menu.AddOptionBool({"Utility", "CrazyX", "AutoUseItems"}, "Phase Boots", true)
CrazyX.AutoUseStick = Menu.AddOptionBool({"Utility", "CrazyX", "AutoUseItems"}, "Magic Stick", true)
CrazyX.AutoUseWand = Menu.AddOptionBool({"Utility", "CrazyX", "AutoUseItems"}, "Magic Wand", true)
CrazyX.AutoDisableOrchid = Menu.AddOptionBool({"Utility", "CrazyX", "Disabler"}, "Orchid", true)
CrazyX.AutoDisableBloodthorn = Menu.AddOptionBool({"Utility", "CrazyX", "Disabler"}, "Bloodthorn", true)
CrazyX.AutoDisableHex = Menu.AddOptionBool({"Utility", "CrazyX", "Disabler"}, "Hex", true)
CrazyX.AutoDisableCyclone = Menu.AddOptionBool({"Utility", "CrazyX", "Disabler"}, "Eul's", true)

Menu.AddOptionIcon(CrazyX.optionEnable, "panorama/images/items/branches_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoUseBottle, "panorama/images/items/bottle_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoUsePhaseBoots, "panorama/images/items/phase_boots_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoUseStick, "panorama/images/items/magic_stick_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoUseWand, "panorama/images/items/magic_wand_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoDisableOrchid, "panorama/images/items/orchid_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoDisableBloodthorn, "panorama/images/items/bloodthorn_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoDisableHex, "panorama/images/items/sheepstick_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoDisableCyclone, "panorama/images/items/cyclone_png.vtex_c")

function CrazyX.OnUpdate()
myHero = Heroes.GetLocal()
myMana = NPC.GetMana(myHero)
bottle = NPC.GetItem(myHero, "item_bottle")
phaseboots = NPC.GetItem(myHero, "item_phase_boots")
stick = NPC.GetItem(myHero, "item_magic_stick")
wand = NPC.GetItem(myHero, "item_magic_wand")
orchid = NPC.GetItem(myHero, "item_orchid")
hex = NPC.GetItem(myHero, "item_sheepstick")
bloodthorn = NPC.GetItem(myHero, "item_bloodthorn")
cyclone = NPC.GetItem(myHero, "item_cyclone")
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

if Menu.IsEnabled(CrazyX.AutoUseStick) then
	CrazyX.AutoStick()
end

if Menu.IsEnabled(CrazyX.AutoUseWand) then
	CrazyX.AutoWand()
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
	
if Menu.IsEnabled(CrazyX.AutoDisableCyclone) then
		CrazyX.AutoDisableEnemyCyclone()
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
		if not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then
			Ability.CastNoTarget(phaseboots)
		end
	end
end

function CrazyX.AutoStick()
	if stick and Ability.IsReady(stick) and Item.GetCurrentCharges(stick) > 0 and Entity.GetHealth(myHero) < 80 then
		Ability.CastNoTarget(stick)
	end
end


function CrazyX.AutoWand()
	if wand and Ability.IsReady(wand) and Item.GetCurrentCharges(wand) > 0 and Entity.GetHealth(myHero) < 80 then
		Ability.CastNoTarget(wand)
	end
end

function CrazyX.AutoDisableEnemyOrchid()
	if orchid and enemy and Ability.IsReady(orchid) and Ability.IsCastable(orchid, myMana) and NPC.IsEntityInRange(myHero, enemy, 600) then
		if not NPC.HasModifier(enemy, "modifier_bloodthorn_debuff") and not NPC.HasModifier(enemy, "modifier_sheepstick_debuff") and not NPC.HasModifier(enemy, "modifier_orchid_malevolence_debuff") and not NPC.HasModifier(enemy, "modifier_eul_cyclone") then
			Ability.CastTarget(orchid, enemy)
		end
	end
end

function CrazyX.AutoDisableEnemyBloodthorn()
	if bloodthorn and enemy and Ability.IsReady(bloodthorn) and Ability.IsCastable(bloodthorn, myMana) and NPC.IsEntityInRange(myHero, enemy, 600) then
		if not NPC.HasModifier(enemy, "modifier_bloodthorn_debuff") and not NPC.HasModifier(enemy, "modifier_sheepstick_debuff") and not NPC.HasModifier(enemy, "modifier_orchid_malevolence_debuff") and not NPC.HasModifier(enemy, "modifier_eul_cyclone") then
			Ability.CastTarget(bloodthorn, enemy)
		end
	end
end
	
function CrazyX.AutoDisableEnemyHex()
	if hex and enemy and Ability.IsReady(hex) and Ability.IsCastable(hex, myMana) and NPC.IsEntityInRange(myHero, enemy, 600) then
		if not NPC.HasModifier(enemy, "modifier_bloodthorn_debuff") and not NPC.HasModifier(enemy, "modifier_sheepstick_debuff") and not NPC.HasModifier(enemy, "modifier_orchid_malevolence_debuff") and not NPC.HasModifier(enemy, "modifier_eul_cyclone") then
			Ability.CastTarget(hex, enemy)
		end
	end
end

function CrazyX.AutoDisableEnemyCyclone()
	if cyclone and enemy and Ability.IsReady(cyclone) and Ability.IsCastable(cyclone, myMana) and NPC.IsEntityInRange(myHero, enemy, 600) then 
		if not NPC.HasModifier(enemy, "modifier_bloodthorn_debuff") and not NPC.HasModifier(enemy, "modifier_sheepstick_debuff") and not NPC.HasModifier(enemy, "modifier_orchid_malevolence_debuff") and not NPC.HasModifier(enemy, "modifier_eul_cyclone") then
			Ability.CastTarget(cyclone, enemy)
		end
	end
end

return CrazyX
