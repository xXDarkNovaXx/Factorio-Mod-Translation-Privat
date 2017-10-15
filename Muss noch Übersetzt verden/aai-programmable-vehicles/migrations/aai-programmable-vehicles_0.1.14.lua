-- active recipes
for _, force in pairs(game.forces) do
    if force.technologies["circuit-network"] and force.technologies["circuit-network"].researched then
        force.recipes["unit-scan"].enabled = true
        force.recipes["unit-control"].enabled = true
        force.recipes["unitdata-scan"].enabled = true
        force.recipes["unitdata-control"].enabled = true
    end
    if force.technologies["automobilism"] and force.technologies["automobilism"].researched then
        force.recipes["cannon-shell-precision"].enabled = true
        force.recipes["explosive-cannon-shell-precision"].enabled = true
    end
end
