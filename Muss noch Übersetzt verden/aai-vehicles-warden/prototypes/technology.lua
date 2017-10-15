data:extend( { {
    type = "technology",
    name = "vehicle-warden",
    icon = "__aai-vehicles-warden__/graphics/technology/warden.png",
    icon_size = 128,
    order = "c-m-a",
    effects = {
        {
            type = "unlock-recipe",
            recipe = "vehicle-warden",
        },
        {
            type = "unlock-recipe",
            recipe = "electroshock-pulse-ammo",
        },
    },
    prerequisites = {"automobilism"},
    unit = {
        count = 100,
        ingredients = {
            {"science-pack-1", 1},
            {"science-pack-2", 1},
        },
        time = 10
    },
}, } )
