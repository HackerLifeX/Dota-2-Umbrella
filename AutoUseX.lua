local AutoUseX = {}

AutoUseX.optionEnable = Menu.AddOptionBool({"Utility", "AutoUseX"}, "Activation", true)
AutoUseX.AutoUseBottle = Menu.AddOptionBool({"Utility", "AutoUseX", "AutoUseItems"}, "Bottle", true)
AutoUseX.AutoUsePhaseBoots = Menu.AddOptionBool({"Utility", "AutoUseX", "AutoUseItems"}, "Phase Boots", true)
AutoUseX.AutoUseButterfly = Menu.AddOptionBool({"Utility", "AutoUseX", "AutoUseItems"}, "Butterfly", true)
AutoUseX.AutoUseStick = Menu.AddOptionBool({"Utility", "AutoUseX", "AutoUseItems"}, "Magic Stick", true)
AutoUseX.AutoUseWand = Menu.AddOptionBool({"Utility", "AutoUseX", "AutoUseItems"}, "Magic Wand", true)

Menu.AddOptionIcon(AutoUseX.optionEnable, "panorama/images/items/branches_png.vtex_c")
Menu.AddOptionIcon(AutoUseX.AutoUseBottle, "panorama/images/items/bottle_png.vtex_c")
Menu.AddOptionIcon(AutoUseX.AutoUsePhaseBoots, "panorama/images/items/phase_boots_png.vtex_c")
Menu.AddOptionIcon(AutoUseX.AutoUseButterfly, "panorama/images/items/butterfly_png.vtex_c")
Menu.AddOptionIcon(AutoUseX.AutoUseStick, "panorama/images/items/magic_stick_png.vtex_c")
Menu.AddOptionIcon(AutoUseX.AutoUseWand, "panorama/images/items/magic_wand_png.vtex_c")

function AutoUseX.OnUpdate()
myHero = Heroes.GetLocal()

myMana = NPC.GetMana(myHero)
bottle = NPC.GetItem(myHero, "item_bottle")
phaseboots = NPC.GetItem(myHero, "item_phase_boots")
butterfly = NPC.GetItem(myHero, "item_butterfly")
stick = NPC.GetItem(myHero, "item_magic_stick")
wand = NPC.GetItem(myHero, "item_magic_wand")

if not Menu.IsEnabled(AutoUseX.optionEnable) then 
	return
end

if Menu.IsEnabled(AutoUseX.AutoUseBottle) then
	AutoUseX.AutoBottle()
end

if Menu.IsEnabled(AutoUseX.AutoUsePhaseBoots) then
	AutoUseX.AutoPhaseBoots()
end

if Menu.IsEnabled(AutoUseX.AutoUseButterfly) then
	AutoUseX.AutoButterfly()
end

if Menu.IsEnabled(AutoUseX.AutoUseStick) then
	AutoUseX.AutoStick()
end

	if Menu.IsEnabled(AutoUseX.AutoUseWand) then
		AutoUseX.AutoWand()
	end
end

function AutoUseX.AutoBottle()
	if bottle and NPC.HasModifier(myHero, "modifier_fountain_aura_buff") and Ability.IsReady(bottle) then
		if Entity.GetHealth(myHero) < Entity.GetMaxHealth(myHero) or NPC.GetMana(myHero) < NPC.GetMaxMana(myHero) then
			if not NPC.HasModifier(myHero, "modifier_bottle_regeneration") and not NPC.IsChannellingAbility(myHero) then 	
				Ability.CastNoTarget(bottle) 
			end
		end
	end
end

function AutoUseX.AutoPhaseBoots()
	if phaseboots and Ability.IsReady(phaseboots) and NPC.IsRunning(myHero) then 
		if not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then
			Ability.CastNoTarget(phaseboots)
		end
	end
end

function AutoUseX.AutoButterfly()
	if butterfly and Ability.IsReady(butterfly) and NPC.IsRunning(myHero) then 
		if not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then
			Ability.CastNoTarget(butterfly)
		end
	end
end

function AutoUseX.AutoStick()
	if stick and Ability.IsReady(stick) and Item.GetCurrentCharges(stick) > 0 and Entity.GetHealth(myHero) < 80 then
		Ability.CastNoTarget(stick)
	end
end

function AutoUseX.AutoWand()
	if wand and Ability.IsReady(wand) and Item.GetCurrentCharges(wand) > 0 and Entity.GetHealth(myHero) < 80 then
		Ability.CastNoTarget(wand)
	end
end

return AutoUseX