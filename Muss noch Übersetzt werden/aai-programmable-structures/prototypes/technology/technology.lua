data:extend({
    {
        type = "technology",
        name = "programmable-structures",
        icon = "__aai-programmable-structures__/graphics/technology/programmable-structures.png",
        icon_size = 128,
        order = "c-m-a",
        effects = {
            {type = "unlock-recipe", recipe = "zone-scan"},
            {type = "unlock-recipe", recipe = "zone-control"},
            {type = "unlock-recipe", recipe = "tile-scan"}
        },
        unit = {
            count = 50,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        },
    }
})
if data.raw["technology"]["circuit-network"] then
    data.raw["technology"]["programmable-structures"].prerequisites = {"circuit-network"}
    data.raw["technology"]["circuit-network"].unit = {
        count = 50,
        ingredients =
        {
            {"science-pack-1", 1},
        },
        time = 10
    }
end
