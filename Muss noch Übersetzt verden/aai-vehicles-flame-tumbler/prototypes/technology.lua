if data.raw["technology"]["automobilism"] then
    table.insert(data.raw["technology"]["automobilism"].effects, {type = "unlock-recipe", recipe = "vehicle-flame-tumbler"})

    -- fix ammo after 0.15
    table.insert(data.raw["technology"]["flamethrower"].effects, {type = "unlock-recipe", recipe = "flamejet-ammo"})
end
