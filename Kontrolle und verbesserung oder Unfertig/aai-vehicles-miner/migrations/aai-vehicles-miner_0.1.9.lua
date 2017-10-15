for _, force in pairs(game.forces) do
    force.reset_technologies()
    force.recipes["vehicle-miner-mk2"].enabled = false
    force.recipes["vehicle-miner-mk3"].enabled = false
    force.recipes["vehicle-miner-mk4"].enabled = false
    force.recipes["vehicle-miner-mk5"].enabled = false
end
