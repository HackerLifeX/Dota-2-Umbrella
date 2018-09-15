local AutoUse = {}

AutoUse.optionStick = Menu.AddOptionBool({"Hero Specific", "AutoUse"}, "Stick", false)
AutoUse.optionBottle = Menu.AddOptionBool({"Hero Specific", "AutoUse"}, "Bottle", false)

function AutoUse.OnUpdate()
	if not Menu.IsEnabled(AutoUse.optionEnableStick) then return end
	
	local myHero = Heroes.GetLocal()
	local stick1 = NPC.GetItem(myHero, "item_magic_stick")

	if not stick1 or not Entity.IsAlive(myHero) then return end

	if Ability.IsReady(stick1) and Entity.GetHealth(myHero) < 75 then 
		Ability.CastNoTarget(stick1) 
    end
	
	if not Menu.IsEnabled(AutoUse.optionBottle) then return end
	
	local bottle = NPC.GetItem(myHero, "item_bottle")
   
	if bottle NPC.HasModifier(myHero, "modifier_fountain_aura_buff") and Ability.IsReady(bottle) then 
	if Entity.GetHealth(myHero) < Entity.GetMaxHealth(myHero) or NPC.GetMana(myHero) < NPC.GetMaxMana(myHero)
	    Ability.CastNoTarget(bottle) 
	    end
    end
end 
	
return AutoUse
