local EspX = {}

EspX.Enable = Menu.AddOptionBool({"Utility", "EspX"}, "Activation", true)
EspX.ESP_type = Menu.AddOptionCombo({"Utility", "EspX"}, "ESP type", {"Enemies", "Friends", "Both"}, 0)

local heroes = {}

function EspX.OnUpdate()
	EspX.Enabled = Menu.IsEnabled( EspX.Enable )
	if not EspX.Enabled then return end
	
	EspX.type = Menu.GetValue( EspX.ESP_type )
	EspX.myHero = Heroes.GetLocal()
	EspX.myPos = Entity.GetAbsOrigin( EspX.myHero )
	
	for i = 1, Heroes.Count() do
		local hero = Heroes.Get(i)
		local heroTeam = Entity.IsSameTeam(EspX.myHero, hero)
		
		if Entity.IsAlive( hero ) and not Entity.IsDormant( hero ) then
			local heroPos = Entity.GetAbsOrigin(hero)
			local X1, Y1 = Renderer.WorldToScreen(heroPos)
			local temp = {}
			
			if EspX.type == 0 and not heroTeam then
				temp = {"enemy", X1, Y1}
			elseif EspX.type == 1 and heroTeam then
				temp = {"friend", X1, Y1}
			elseif EspX.type == 2 then
				temp = {"both", X1, Y1}
			end
			
			heroes[hero] = temp
		else
			if heroes[hero] then
				table.remove( heroes[hero] )
			end
		end
	end
end

function EspX.OnDraw()
	if not EspX.Enabled or not heroes then return end
	
	local myX, myY =  Renderer.WorldToScreen( EspX.myPos )
	
	for hero, data in pairs(heroes) do
		if NPC.IsEntityInRange(EspX.myHero, hero, 3500) and NPC.IsVisible(hero) then 
			if EspX.type == 0 and data[1] == "enemy" then
				Renderer.SetDrawColor(255, 0, 0)
				Renderer.DrawLine(data[2], data[3], myX, myY)
				
			elseif EspX.type == 1 and data[1] == "friend" then
				Renderer.SetDrawColor(0, 255, 0)
				Renderer.DrawLine(data[2], data[3], myX, myY)

			elseif EspX.type == 2 then
				Renderer.SetDrawColor(0, 0, 255)
				Renderer.DrawLine(data[2], data[3], myX, myY)
			end
		end
	end
end 

return EspX