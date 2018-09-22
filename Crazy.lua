local CrazyX = {}

CrazyX.optionEnable = Menu.AddOptionBool({"Utility", "CrazyX"}, "Activation", true)
CrazyX.AutoUseBottle = Menu.AddOptionBool({"Utility", "CrazyX", "AutoUseItems"}, "Bottle", true)
CrazyX.AutoUsePhaseBoots = Menu.AddOptionBool({"Utility", "CrazyX", "AutoUseItems"}, "Phase Boots", true)
CrazyX.AutoUseButterfly = Menu.AddOptionBool({"Utility", "CrazyX", "AutoUseItems"}, "Butterfly", true)
CrazyX.AutoUseStick = Menu.AddOptionBool({"Utility", "CrazyX", "AutoUseItems"}, "Magic Stick", true)
CrazyX.AutoUseWand = Menu.AddOptionBool({"Utility", "CrazyX", "AutoUseItems"}, "Magic Wand", true)


Menu.AddOptionIcon(CrazyX.optionEnable, "panorama/images/items/branches_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoUseBottle, "panorama/images/items/bottle_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoUsePhaseBoots, "panorama/images/items/phase_boots_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoUseButterfly, "panorama/images/items/butterfly_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoUseStick, "panorama/images/items/magic_stick_png.vtex_c")
Menu.AddOptionIcon(CrazyX.AutoUseWand, "panorama/images/items/magic_wand_png.vtex_c")

function CrazyX.OnUpdate()
myHero = Heroes.GetLocal()

myMana = NPC.GetMana(myHero)
bottle = NPC.GetItem(myHero, "item_bottle")
phaseboots = NPC.GetItem(myHero, "item_phase_boots")
butterfly = NPC.GetItem(myHero, "item_butterfly")
stick = NPC.GetItem(myHero, "item_magic_stick")
wand = NPC.GetItem(myHero, "item_magic_wand")

------------------------------------------
for i = 1, Heroes.Count() do
		enemyX = Heroes.Get(i)          -------ЭТО ВРАГ ДЛЯ ESP
enemyPos = Entity.GetAbsOrigin(enemyX)
myPos = Entity.GetAbsOrigin(myHero)
------------------------------------------


if not Menu.IsEnabled(CrazyX.optionEnable) then 
	return
end

if Menu.IsEnabled(CrazyX.AutoUseBottle) then
	CrazyX.AutoBottle()
end

if Menu.IsEnabled(CrazyX.AutoUsePhaseBoots) then
	CrazyX.AutoPhaseBoots()
end

if Menu.IsEnabled(CrazyX.AutoUseButterfly) then
	CrazyX.AutoButterfly()
end

if Menu.IsEnabled(CrazyX.AutoUseStick) then
	CrazyX.AutoStick()
end

if Menu.IsEnabled(CrazyX.AutoUseWand) then
	CrazyX.AutoWand()
end

	if Menu.IsEnabled(CrazyX.ESP) then
			CrazyX.OnDraw()
		end
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

function CrazyX.AutoButterfly()
	if butterfly and Ability.IsReady(butterfly) and NPC.IsRunning(myHero) then 
		if not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then
			Ability.CastNoTarget(butterfly)
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

return CrazyX
