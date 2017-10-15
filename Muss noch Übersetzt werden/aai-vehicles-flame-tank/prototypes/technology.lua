data:extend( { {
    type = "technology",
    name = "vehicle-flame-tank",
    icon = "__aai-vehicles-flame-tank__/graphics/technology/flame-tank.png",
    icon_size = 128,
    order = "c-m-a",
    effects = {
        {
            type = "unlock-recipe",
            recipe = "vehicle-flame-tank",
        },
        {
            type = "unlock-recipe",
            recipe = "flamejet-ammo",
        }
    },
    prerequisites = {"automobilism", "flamethrower"},
    unit = {
        count = 75,
        ingredients = {
            {"science-pack-1", 1},
            {"science-pack-2", 1},
            {"military-science-pack", 1},
        },
        time = 10
    },
}, } )
