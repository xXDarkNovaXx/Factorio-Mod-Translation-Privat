local util = require("data-util")

data.raw.technology["logistics"].unit.count = 20
data.raw.technology["logistics"].prerequisites = {"basic-logistics"}

data.raw.technology["automation"].unit.count = 100
data.raw.technology["automation"].prerequisites = {"basic-automation", "electricity"}

data.raw.technology["automation-2"].prerequisites = {"automation"}
data.raw.technology["automation-2"].unit.count = 150

data.raw.technology["optics"].prerequisites = {"electricity"}
data.raw.technology["turrets"].prerequisites = {"basic-automation", "military"}

data.raw.technology["logistics"].unit.count = 10

data.raw.technology["fluid-handling"].prerequisites = {"basic-fluid-handling", "steel-processing"}

data.raw.technology["oil-processing"].prerequisites = {"automation", "fluid-handling"}


-- effects are added in technology-update
data:extend{
    {
        type = "technology",
        name = "basic-automation",
        icon = "__base__/graphics/technology/automation.png",
        icon_size = 128,
        order = "a",
        unit = {
            count = 10,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        },
    },
    {
        type = "technology",
        name = "basic-logistics",
        icon = "__base__/graphics/technology/logistics.png",
        icon_size = 128,
        order = "a",
        unit = {
            count = 10,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        },
    },
    {
        type = "technology",
        name = "electricity",
        icon = "__base__/graphics/technology/electric-engine.png",
        icon_size = 128,
        order = "a",
        prerequisites = {"basic-automation"},
        unit = {
            count = 50,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        },
    },
    {
        type = "technology",
        name = "filter-inserters",
        icon = "__aai-industry__/graphics/technology/filter-inserters.png",
        icon_size = 128,
        order = "a",
        prerequisites = {"automation-2", "electronics"},
        unit = {
            count = 150,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        },
    },
    {
        type = "technology",
        name = "radar",
        icon = "__aai-industry__/graphics/technology/radar.png",
        icon_size = 128,
        order = "a",
        prerequisites = {"optics"},
        unit = {
            count = 40,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        },
    },
    {
        type = "technology",
        name = "basic-fluid-handling",
        icon = "__base__/graphics/technology/fluid-handling.png",
        icon_size = 128,
        order = "a",
        prerequisites = {"electricity"},
        unit = {
            count = 50,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        },
    },
    {
        type = "technology",
        name = "steam-power",
        icon = "__aai-industry__/graphics/technology/steam-power.png",
        icon_size = 128,
        order = "a",
        prerequisites = {"basic-fluid-handling"},
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
        name = "electric-lab",
        icon = "__aai-industry__/graphics/technology/electric-lab.png",
        icon_size = 128,
        order = "a",
        prerequisites = {"electricity"},
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
        name = "electric-mining",
        icon = "__aai-industry__/graphics/technology/electric-mining.png",
        icon_size = 128,
        order = "a",
        prerequisites = {"electricity"},
        unit = {
            count = 150,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        },
    },
    {
        type = "technology",
        name = "concrete-walls",
        icon = "__base__/graphics/technology/stone-walls.png",
        icon_size = 128,
        order = "a",
        prerequisites = {"stone-walls", "concrete"},
        unit = {
            count = 200,
            ingredients = {
                {"science-pack-1", 1},
                {"science-pack-2", 1},
            },
            time = 20
        },
    },
    {
        type = "technology",
        name = "fuel-processing",
        icon = "__aai-industry__/graphics/technology/fuel-processing.png",
        icon_size = 128,
        order = "a",
        prerequisites = {"electricity"},
        unit = {
            count = 20,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        },
    },
}
