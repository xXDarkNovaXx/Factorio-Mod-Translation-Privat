-- active recipes
for _, force in pairs(game.forces) do
    if force.technologies["circuit-network"] and force.technologies["circuit-network"].researched then
        force.recipes["zone-scan"].enabled = true
        force.recipes["zone-control"].enabled = true
        force.recipes["tile-scan"].enabled = true
    end
end
