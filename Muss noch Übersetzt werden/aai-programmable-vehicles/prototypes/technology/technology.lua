data:extend({
    {
        type = "technology",
        name = "vehicle-deployment",
        icon = "__aai-programmable-vehicles__/graphics/technology/vehicle-deployment.png",
        icon_size = 128,
        order = "c-m-a",
        effects = {
            {type = "unlock-recipe", recipe = "vehicle-deployer"},
        },
        unit = {
            count = 20,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        },
    },
    {
        type = "technology",
        name = "vehicle-depot",
        icon = "__aai-programmable-vehicles__/graphics/technology/vehicle-depot.png",
        icon_size = 128,
        order = "c-m-a",
        effects = {
            {type = "unlock-recipe", recipe = "vehicle-depot"},
        },
        unit = {
            count = 10,
            ingredients = {
                {"science-pack-1", 1},
            },
            time = 10
        },
    }
})
if data.raw.technology["basic-vehicles"] then
  data.raw.technology["vehicle-deployment"].prerequisites = {"basic-vehicles"}
  data.raw.technology["vehicle-depot"].prerequisites = {"basic-vehicles"}
end

-- make it easier to get to vehicles
if data.raw["technology"]["engine"] then
    data.raw["technology"]["engine"].prerequisites = {"steel-processing"}
    data.raw["technology"]["engine"].unit = {
        count = 100,
        ingredients =
        {
            {"science-pack-1", 1},
        },
        time = 10
    }
end

if data.raw["technology"]["automobilism"] then
    data.raw["technology"]["automobilism"].unit = {
        count = 100,
        ingredients =
        {
            {"science-pack-1", 1},
        },
        time = 15
    }
end

if data.raw["technology"]["programmable-structures"] then
    table.insert(data.raw["technology"]["programmable-structures"].effects, {type = "unlock-recipe", recipe = "unit-scan"})
    table.insert(data.raw["technology"]["programmable-structures"].effects, {type = "unlock-recipe", recipe = "unit-control"})
    table.insert(data.raw["technology"]["programmable-structures"].effects, {type = "unlock-recipe", recipe = "unitdata-scan"})
    table.insert(data.raw["technology"]["programmable-structures"].effects, {type = "unlock-recipe", recipe = "unitdata-control"})
elseif data.raw["technology"]["circuit-network"] then
    table.insert(data.raw["technology"]["circuit-network"].effects, {type = "unlock-recipe", recipe = "unit-scan"})
    table.insert(data.raw["technology"]["circuit-network"].effects, {type = "unlock-recipe", recipe = "unit-control"})
    table.insert(data.raw["technology"]["circuit-network"].effects, {type = "unlock-recipe", recipe = "unitdata-scan"})
    table.insert(data.raw["technology"]["circuit-network"].effects, {type = "unlock-recipe", recipe = "unitdata-control"})
end

if data.raw["technology"]["tanks"] then
    table.insert(data.raw["technology"]["tanks"].effects, {type = "unlock-recipe", recipe = "cannon-shell-precision"})
    table.insert(data.raw["technology"]["tanks"].effects, {type = "unlock-recipe", recipe = "explosive-cannon-shell-precision"})
end
