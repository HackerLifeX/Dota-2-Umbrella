local Invok = {}

Invok.optionHelper = Menu.AddOptionBool({ "Utility", "Invoker" }, "Sun Strike Helper", false)

local Enemies = {}

function Invok.OnUpdate()
	Invok.Helper = Menu.IsEnabled( Invok.optionHelper )
	if not Invok.Helper then return end
	
	local myHero = Heroes.GetLocal()
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_invoker" then return end
	
	local SunStrike = NPC.GetAbility(myHero, "invoker_sun_strike")
	
	for i = 1, Heroes.Count() do
		local enemy = Heroes.Get(i)
		
		if not Entity.IsSameTeam(myHero, enemy) and not Entity.IsDormant(enemy) then
		
			local delay = Ability.GetCastPoint(SunStrike) + 1.7 + (NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) * 2)
			local pred = Invok.castPrediction(enemy, delay)
			local pos = Entity.GetAbsOrigin(enemy)
			
			local X1, Y1 = Renderer.WorldToScreen(pos)
			local X2, Y2, visible = Renderer.WorldToScreen(pred)
			
			Enemies[enemy] = {visible, X1, Y1, X2, Y2}
		else
			if Enemies[enemy] then
				table.remove( Enemies[enemy] )
			end
		end
	end
end

function Invok.OnDraw()
	if not Invok.Helper or not Enemies then return end
	
	for hero, data in pairs( Enemies ) do
		if data[1] and Entity.IsAlive(hero) then
			Renderer.SetDrawColor(255, 0, 0)
			Renderer.DrawLine(data[2], data[3], data[4], data[5])
			Renderer.DrawFilledRect(data[4] -5, data[5] -5, 15, 15)
		end
	end
end

function Invok.castPrediction(enemy, delay)

	local speed = Invok.GetMoveSpeed(enemy)
	local angle = Entity.GetRotation(enemy)
	local angleOffset = Angle(0, 0, 0)
		angle:SetYaw(angle:GetYaw() + angleOffset:GetYaw())
	local x,y,z = angle:GetVectors()
	local direction = x + y + z
		direction:SetZ(0)
		direction:Normalize()
		direction:Scale(speed * delay)
	
	local pos = Entity.GetAbsOrigin(enemy)
	
	if not NPC.IsRunning( enemy ) then
		return pos
	else
		return pos + direction
	end
end

function Invok.GetMoveSpeed(enemy)

	if not enemy then return end

	local base_speed = NPC.GetBaseSpeed(enemy)
	local bonus_speed = NPC.GetMoveSpeed(enemy) - NPC.GetBaseSpeed(enemy)
	local modifierHex
    	local modSheep = NPC.GetModifier(enemy, "modifier_sheepstick_debuff")
    	local modLionVoodoo = NPC.GetModifier(enemy, "modifier_lion_voodoo")
    	local modShamanVoodoo = NPC.GetModifier(enemy, "modifier_shadow_shaman_voodoo")

	if modSheep then
		modifierHex = modSheep
	end
	if modLionVoodoo then
		modifierHex = modLionVoodoo
	end
	if modShamanVoodoo then
		modifierHex = modShamanVoodoo
	end

	if modifierHex then
		if math.max(Modifier.GetDieTime(modifierHex) - GameRules.GetGameTime(), 0) > 0 then
			return 140 + bonus_speed
		end
	end

    	if NPC.HasModifier(enemy, "modifier_invoker_ice_wall_slow_debuff") then 
		return 100 
	end

	if NPC.HasModifier(enemy, "modifier_invoker_cold_snap_freeze") or NPC.HasModifier(enemy, "modifier_invoker_cold_snap") then
		return (base_speed + bonus_speed) * 0.5
	end

	if NPC.HasModifier(enemy, "modifier_spirit_breaker_charge_of_darkness") then
		local chargeAbility = NPC.GetAbility(enemy, "spirit_breaker_charge_of_darkness")
		if chargeAbility then
			local specialAbility = NPC.GetAbility(enemy, "special_bonus_unique_spirit_breaker_2")
			if specialAbility then
				 if Ability.GetLevel(specialAbility) < 1 then
					return Ability.GetLevel(chargeAbility) * 50 + 550
				else
					return Ability.GetLevel(chargeAbility) * 50 + 1050
				end
			end
		end
	end
			
    return base_speed + bonus_speed
end

return Invok