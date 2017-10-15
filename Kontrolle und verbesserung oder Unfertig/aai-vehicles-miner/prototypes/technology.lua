data:extend{
    {
        type = "technology",
        name = "vehicle-miner",
        icon = "__aai-vehicles-miner__/graphics/technology/miner.png",
        icon_size = 128,
        order = "a-q-a",
        effects = {
            {
                type = "unlock-recipe",
                recipe = "vehicle-miner",
            }
        },
        unit = {
            count = 10,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        }
    },
    {
        type = "technology",
        name = "vehicle-miner-2",
        icon = "__aai-vehicles-miner__/graphics/technology/miner-mk2.png",
        icon_size = 128,
        order = "a-q-b",
        prerequisites = {
            "vehicle-miner",
            "engine"
        },
        effects = {
            {
                type = "unlock-recipe",
                recipe = "vehicle-miner-mk2",
            }
        },
        unit = {
            count = 100,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        },
    },
    {
        type = "technology",
        name = "vehicle-miner-3",
        icon = "__aai-vehicles-miner__/graphics/technology/miner-mk3.png",
        icon_size = 128,
        order = "a-q-b",
        prerequisites = {
            "vehicle-miner-2",
            "speed-module"
        },
        effects = {
            {
                type = "unlock-recipe",
                recipe = "vehicle-miner-mk3",
            }
        },
        unit = {
            count = 200,
            ingredients = {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
            },
            time = 10
        },
    },
    {
        type = "technology",
        name = "vehicle-miner-4",
        icon = "__aai-vehicles-miner__/graphics/technology/miner-mk4.png",
        icon_size = 128,
        order = "a-q-b",
        prerequisites = {
            "vehicle-miner-3",
            "speed-module-2"
        },
        effects = {
            {
                type = "unlock-recipe",
                recipe = "vehicle-miner-mk4",
            }
        },
        unit = {
            count = 300,
            ingredients = {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
                {"science-pack-3", 1},
            },
            time = 10
        },
    },
    {
        type = "technology",
        name = "vehicle-miner-5",
        icon = "__aai-vehicles-miner__/graphics/technology/miner-mk5.png",
        icon_size = 128,
        order = "a-q-b",
        prerequisites = {
            "vehicle-miner-4",
            "speed-module-3"
        },
        effects = {
            {
                type = "unlock-recipe",
                recipe = "vehicle-miner-mk5",
            }
        },
        unit = {
            count = 400,
            ingredients = {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
                {"science-pack-3", 1},
                {"production-science-pack", 1},
            },
            time = 10
        },
    },
}
