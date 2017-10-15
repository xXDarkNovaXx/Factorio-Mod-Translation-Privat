-- active recipes
for _, force in pairs(game.forces) do
	if force.technologies["automobilism"] and force.technologies["automobilism"].researched then
		force.recipes["vehicle-flame-tumbler"].enabled = true
	end
end