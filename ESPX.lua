local EspX = {}

EspX.optionEnable = Menu.AddOptionBool({"Utility", "EspX"}, "Activation", true)

EspX.ESP_enemy = Menu.AddOptionBool({"Utility", "EspX", "ESP"}, "ESP Enemy", true)
EspX.ESP_myteam = Menu.AddOptionBool({"Utility", "EspX", "ESP"}, "ESP My Team", true)
EspX.ESP_allteam = Menu.AddOptionBool({"Utility", "EspX", "ESP"}, "ESP All Team", true)

local myHero = nil
local myPos = nil
local xp = nil
local yp = nil

function EspX.OnUpdate()
	if Menu.IsEnabled(EspX.optionEnable) then
		myHero = Heroes.GetLocal()
		myPos = Entity.GetAbsOrigin(myHero)
		xp, yp =  Renderer.WorldToScreen(myPos)		
	end
end

function EspX.OnDraw()
if myHero and Menu.IsEnabled(EspX.optionEnable) and Menu.IsEnabled(EspX.ESP_enemy) then 
	for i = 1, Heroes.Count() do
			local enemyX = Heroes.Get(i)          
			local enemyPos = Entity.GetAbsOrigin(enemyX)
			local xz, yz = Renderer.WorldToScreen(enemyPos)
		if not Entity.IsSameTeam(myHero, enemyX) and Entity.IsAlive(enemyX) and NPC.IsVisible(enemyX) then
			Renderer.SetDrawColor(255, 0, 0)                             
			Renderer.DrawFilledRect(xp - 5, yp - 5, 10, 10)
			Renderer.DrawLine(xz, yz, xp, yp)
		end
	end
end

if myHero and Menu.IsEnabled(EspX.optionEnable) and Menu.IsEnabled(EspX.ESP_myteam) then 
	for i = 1, Heroes.Count() do
			local enemyX = Heroes.Get(i)          
			local enemyPos = Entity.GetAbsOrigin(enemyX)
			local xz, yz = Renderer.WorldToScreen(enemyPos)
		if Entity.IsSameTeam(enemyX, myHero) and Entity.IsAlive(enemyX) then
			Renderer.SetDrawColor(255, 0, 0)                             
			Renderer.DrawFilledRect(xp - 5, yp - 5, 10, 10)
			Renderer.DrawLine(xz, yz, xp, yp)
		end
	end
end

	if myHero and Menu.IsEnabled(EspX.optionEnable) and Menu.IsEnabled(EspX.ESP_allteam) then 
		for i = 1, Heroes.Count() do
				local enemyX = Heroes.Get(i)          
				local enemyPos = Entity.GetAbsOrigin(enemyX)
				local xz, yz = Renderer.WorldToScreen(enemyPos)
			if NPC.IsVisible(enemyX) and Entity.IsAlive(enemyX) then
				Renderer.SetDrawColor(255, 0, 0)                             
				Renderer.DrawFilledRect(xp - 5, yp - 5, 10, 10)
				Renderer.DrawLine(xz, yz, xp, yp)
			end
		end
	end
end
	
return EspX