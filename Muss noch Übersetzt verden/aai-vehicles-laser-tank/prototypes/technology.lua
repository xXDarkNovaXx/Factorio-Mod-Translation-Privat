if data.raw["technology"]["tanks"] then
	table.insert(data.raw["technology"]["tanks"].effects, {type = "unlock-recipe", recipe = "vehicle-laser-tank"})
	table.insert(data.raw["technology"]["tanks"].effects, {type = "unlock-recipe", recipe = "laser-cannon-battery-piercing"})
	table.insert(data.raw["technology"]["tanks"].effects, {type = "unlock-recipe", recipe = "laser-cannon-battery-focussed"})
end

local i = 1
while data.raw["technology"]["laser-turret-damage-"..i] do 
	local tech = data.raw["technology"]["laser-turret-damage-"..i]
	if tech.effects then
		for _, effect in pairs(tech.effects) do 
			if effect.type == "ammo-damage" and effect.ammo_category == "laser-turret" then
				table.insert(tech.effects, 
				{
					type = "ammo-damage",
					ammo_category = "laser-cannon",
					modifier = effect.modifier
				})
			end
		end
	end
	i = i + 1
end