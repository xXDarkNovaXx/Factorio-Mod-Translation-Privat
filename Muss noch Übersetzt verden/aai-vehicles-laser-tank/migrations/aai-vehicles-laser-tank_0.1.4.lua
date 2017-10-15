-- active recipes
for _, force in pairs(game.forces) do
	if force.technologies["tanks"] and force.technologies["tanks"].researched then
		force.recipes["vehicle-laser-tank"].enabled = true
		force.recipes["laser-cannon-battery-piercing"].enabled = true
		force.recipes["laser-cannon-battery-focussed"].enabled = true
	end
	force.reset_technologies()
end