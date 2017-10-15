-------------------------------------------------------------------------------
--[[Recipe]]--
-------------------------------------------------------------------------------
data:extend{
    {
        type = "recipe",
        name = "zone-planner",
        category = "crafting",
        enabled = data.raw["technology"]["electronics"] == nil,
        energy_required = 2,
        ingredients =
        {
            {type="item", name="electronic-circuit", amount=5}
        },
        results=
        {
            {type="item", name="zone-planner", amount=1},
        },
    },
}
-------------------------------------------------------------------------------
--[[Item]]--
-------------------------------------------------------------------------------
data:extend{
    {
        type = "selection-tool",
        name = "zone-planner",
        icon = "__aai-zones__/graphics/icons/zone-planner.png",
        flags = {"goes-to-quickbar"},
        subgroup = "tool",
        order = "c[automated-construction]-d[zone-planner]",
        stack_size = 1,
        stackable = false,
        selection_color = {r = 0.3, g = 0.9, b = 0.3},
        alt_selection_color = {r = 0.9, g = 0.1, b = 0.1},
        selection_mode = {"tiles"},
        alt_selection_mode = {"tiles"},
        selection_cursor_box_type = "not-allowed",
        alt_selection_cursor_box_type = "not-allowed"
    },
}

-------------------------------------------------------------------------------
--[[Technology]]--
-------------------------------------------------------------------------------
if data.raw["technology"]["electronics"] then
    table.insert(data.raw["technology"]["electronics"].effects, {type = "unlock-recipe", recipe = "zone-planner"})
end
