data:extend{
    {
        type = "selection-tool",
        name = "unit-remote-control",
        icon = "__aai-programmable-vehicles__/graphics/icons/unit-remote-control.png",
        flags = {"goes-to-quickbar"},
        subgroup = "tool",
        order = "c[automated-construction]-e[unit-remote-control]",
        stack_size = 1,
        stackable = false,
        selection_color = {r = 0.3, g = 0.9, b = 0.3},
        alt_selection_color = {r = 0.3, g = 0.3, b = 0.9},
        selection_mode = {"tiles", "matches-force"},
        alt_selection_mode = {"tiles", "matches-force"},
        selection_cursor_box_type = "not-allowed",
        alt_selection_cursor_box_type = "not-allowed"
    },
    {
        type = "item",
        name = "unit-scan",
        icon = "__aai-programmable-structures__/graphics/icon/unit-scan.png",
        flags = {"goes-to-quickbar", "hidden"}, -- overwritten to {"goes-to-quickbar"} in programmable vehicles
        subgroup = "programmable-structures",
        order = "d",
        stack_size = 50,
        place_result = "unit-scan",
    },
    {
        type = "item",
        name = "unit-control",
        icon = "__aai-programmable-structures__/graphics/icon/unit-control.png",
        flags = {"goes-to-quickbar", "hidden"}, -- overwritten to {"goes-to-quickbar"} in programmable vehicles
        subgroup = "programmable-structures",
        order = "e",
        stack_size = 50,
        place_result = "unit-control",
    },
    {
        type = "item",
        name = "unitdata-scan",
        icon = "__aai-programmable-structures__/graphics/icon/unitdata-scan.png",
        flags = {"goes-to-quickbar", "hidden"}, -- overwritten to {"goes-to-quickbar"} in programmable vehicles
        subgroup = "programmable-structures",
        order = "f",
        stack_size = 50,
        place_result = "unitdata-scan",
    },
    {
        type = "item",
        name = "unitdata-control",
        icon = "__aai-programmable-structures__/graphics/icon/unitdata-control.png",
        flags = {"goes-to-quickbar", "hidden"}, -- overwritten to {"goes-to-quickbar"} in programmable vehicles
        subgroup = "programmable-structures",
        order = "g",
        stack_size = 50,
        place_result = "unitdata-control",
    },
    {
        type = "item",
        name = "vehicle-deployer",
        icon = "__aai-programmable-vehicles__/graphics/icons/vehicle-deployer.png",
        flags = {"goes-to-quickbar"},
        subgroup = "programmable-structures",
        order = "h",
        place_result = "vehicle-deployer",
        stack_size = 10
    },
    {
        type = "item",
        name = "vehicle-depot",
        icon = "__aai-programmable-vehicles__/graphics/icons/vehicle-depot.png",
        flags = {"goes-to-quickbar"},
        subgroup = "programmable-structures",
        order = "i",
        place_result = "vehicle-depot-base",
        stack_size = 10
    },
    {
        type = "item", -- dummy entity to allow deconstruction
        name = "vehicle-depot-chest",
        icon = "__base__/graphics/icons/iron-chest.png",
        flags = {"goes-to-quickbar", "hidden"},
        subgroup = "programmable-structures",
        order = "i",
        place_result = "vehicle-depot-chest",
        stack_size = 10
    },
    {
        type = "item",
        name = "vehicle-depot-combinator",
        icon = "__base__/graphics/icons/constant-combinator.png",
        flags = {"goes-to-quickbar", "hidden"},
        subgroup = "programmable-structures",
        order = "i",
        place_result = "vehicle-depot-combinator",
        stack_size = 10
    },
}

data.raw.item["unit-scan"].flags = {"goes-to-quickbar"}
data.raw.item["unit-control"].flags = {"goes-to-quickbar"}
data.raw.item["unitdata-scan"].flags = {"goes-to-quickbar"}
data.raw.item["unitdata-control"].flags = {"goes-to-quickbar"}
