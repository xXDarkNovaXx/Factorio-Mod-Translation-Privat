local util = require("data-util")

local basic_circuit = data.raw.item["basic-circuit-board"] and "basic-circuit-board" or "electronic-circuit"

-- replace iron plate with stone tablet in "electronic-circuit"
-- skip if bobs mods ["wooden-board"]
if data.raw.recipe["electronic-circuit"] and not data.raw.recipe["wooden-board"] then

  local base = data.raw.recipe["electronic-circuit"]

  local wood_version = table.deepcopy(base)

  if wood_version.ingredients then util.replace_or_add_ingredient_sub(wood_version, "iron-plate", "wood", 1) end
  if wood_version.normal then util.replace_or_add_ingredient_sub(wood_version.normal, "iron-plate", "wood", 1) end
  if wood_version.expensive then util.replace_or_add_ingredient_sub(wood_version.expensive, "iron-plate", "wood", 2) end

  local stone_version = table.deepcopy(base)
  stone_version.name = "electronic-circuit-stone"
  if stone_version.ingredients then util.replace_or_add_ingredient_sub(stone_version, "iron-plate", "stone-tablet", 1) end
  if stone_version.normal then util.replace_or_add_ingredient_sub(stone_version.normal, "iron-plate", "stone-tablet", 1) end
  if stone_version.expensive then util.replace_or_add_ingredient_sub(stone_version.expensive, "iron-plate", "stone-tablet", 2) end

  data:extend({
    wood_version,
    stone_version
  })
end

-- if bobs mods ["wooden-board"]
if data.raw.recipe["wooden-board"] then
  if data.raw.recipe["wooden-board"].ingredients then
    table.insert(data.raw.recipe["wooden-board"].ingredients, {"stone-tablet", 1})
    data.raw.recipe["wooden-board"].enabled = false
  end
  if data.raw.recipe["wooden-board"].normal then
    table.insert(data.raw.recipe["wooden-board"].normal.ingredients, {"stone-tablet", 1})
    data.raw.recipe["wooden-board"].normal.enabled = false
  end
  if data.raw.recipe["wooden-board"].expensive then
    table.insert(data.raw.recipe["wooden-board"].expensive.ingredients, {"stone-tablet", 2})
    data.raw.recipe["wooden-board"].expensive.enabled = false
  end
end

-- if bobs mods ["wooden-board-synthetic"]
if data.raw.recipe["wooden-board-synthetic"] then
  if data.raw.recipe["wooden-board-synthetic"].ingredients then
    table.insert(data.raw.recipe["wooden-board-synthetic"].ingredients, {"stone-tablet", 1})
    data.raw.recipe["wooden-board-synthetic"].enabled = false
   end
  if data.raw.recipe["wooden-board-synthetic"].normal then
    table.insert(data.raw.recipe["wooden-board-synthetic"].normal.ingredients, {"stone-tablet", 1})
    data.raw.recipe["wooden-board-synthetic"].normal.enabled = false
  end
  if data.raw.recipe["wooden-board-synthetic"].expensive then
    table.insert(data.raw.recipe["wooden-board-synthetic"].expensive.ingredients, {"stone-tablet", 2})
    data.raw.recipe["wooden-board-synthetic"].expensive.enabled = false
  end
end

util.conditional_modify({
  type = "recipe",
  name = "repair-pack",
  normal = {
    ingredients = {
      {type="item", name="iron-plate", amount=3},
      {type="item", name="copper-plate", amount=3},
      {type="item", name="stone", amount=2},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="iron-plate", amount=4},
      {type="item", name="copper-plate", amount=4},
      {type="item", name="stone", amount=3},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "science-pack-1",
  normal = {
    ingredients = {
      {type="item", name="iron-gear-wheel", amount=1},
      {type="item", name="copper-plate", amount=2},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="iron-gear-wheel", amount=1},
      {type="item", name="copper-plate", amount=2},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "engine-unit",
  category = "crafting", -- engine can be hand crafted
  normal = {
    ingredients = {
      {type="item", name="steel-plate", amount=2},
      {type="item", name="iron-gear-wheel", amount=2},
      {type="item", name="pipe", amount=2},
      {type="item", name="motor", amount=1},
    },
    results= { {type="item", name="engine-unit", amount=1} },
  },
  expensive = {
    ingredients = {
      {type="item", name="steel-plate", amount=2},
      {type="item", name="iron-gear-wheel", amount=2},
      {type="item", name="pipe", amount=2},
      {type="item", name="motor", amount=2},
    },
    results= { {type="item", name="engine-unit", amount=1} },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "electric-engine-unit",
  normal = {
    ingredients = {
      {type="fluid", name="lubricant", amount=4},
      {type="item", name="electronic-circuit", amount=1},
      {type="item", name="electric-motor", amount=1},
      {type="item", name="engine-unit", amount=1},
    },
    results= { {type="item", name="electric-engine-unit", amount=1} },
  },
  expensive = {
    ingredients = {
      {type="fluid", name="lubricant", amount=10},
      {type="item", name="electronic-circuit", amount=2},
      {type="item", name="electric-motor", amount=1},
      {type="item", name="engine-unit", amount=1},
    },
    results= { {type="item", name="electric-engine-unit", amount=1} },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "concrete",
  normal = {
    ingredients = {
      {type="item", name="stone-brick", amount=5},
      {type="item", name="iron-stick", amount=2},
      {type="fluid", name="water", amount=100}
    },
    results= { {type="item", name="concrete", amount=10} },
  },
  expensive = {
    ingredients = {
      {type="item", name="stone-brick", amount=6},
      {type="item", name="iron-stick", amount=3},
      {type="fluid", name="water", amount=100}
    },
    results= { {type="item", name="concrete", amount=10} },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "stone-furnace",
  normal = {
    ingredients = {
      {"stone", 5}
    },
  },
  expensive = {
    ingredients = {
      {"stone", 10}
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "steel-furnace",
  normal = {
    ingredients = {
      {"stone-brick", 10},
      {"steel-plate", 6},
      {"stone-furnace", 1},
    },
  },
  expensive = {
    ingredients = {
      {"stone-brick", 20},
      {"steel-plate", 12},
      {"stone-furnace", 1},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "electric-furnace",
  normal = {
    ingredients = {
      {"steel-plate", 10},
      {"advanced-circuit", 5},
      {"stone-brick", 10},
      {"steel-furnace", 1}
    },
  },
  expensive = {
    ingredients = {
      {"steel-plate", 20},
      {"concrete", 20},
      {"advanced-circuit", 10},
      {"steel-furnace", 1}
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "burner-inserter",
  normal = {
    enabled = false,
    ingredients = {
      {type="item", name="iron-plate", amount=1},
      {type="item", name="motor", amount=1},
    },
  },
  expensive = {
    enabled = false,
    ingredients = {
      {type="item", name="iron-plate", amount=2},
      {type="item", name="motor", amount=2},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "inserter",
  normal = {
    enabled = false,
    ingredients = {
      {type="item", name="burner-inserter", amount=1},
      {type="item", name="electric-motor", amount=2},
    },
  },
  expensive = {
    enabled = false,
    ingredients = {
      {type="item", name="burner-inserter", amount=1},
      {type="item", name="electric-motor", amount=2},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "transport-belt",
  normal = {
    ingredients = {
      {type="item", name="iron-plate", amount=1},
      {type="item", name="motor", amount=1},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="iron-plate", amount=4},
      {type="item", name="motor", amount=1},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "boiler",
  normal = {
    enabled = false,
    ingredients = {
      {"stone-furnace", 1},
      {"pipe", 4}
    },
  },
  expensive = {
    enabled = false,
    ingredients = {
      {"stone-furnace", 1},
      {"pipe", 20}
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "steam-engine",
  normal = {
    enabled = false,
    ingredients =
    {
      {type="item", name="iron-plate", amount=10},
      {type="item", name="iron-gear-wheel", amount=5},
      {type="item", name="electric-motor", amount=3},
    },
  },
  expensive = {
    enabled = false,
    ingredients =
    {
      {type="item", name="iron-plate", amount=20},
      {type="item", name="iron-gear-wheel", amount=20},
      {type="item", name="electric-motor", amount=6},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "burner-mining-drill",
  normal = {
    ingredients = {
      {type="item", name="stone-brick", amount=4},
      {type="item", name="iron-plate", amount=4},
      {type="item", name="motor", amount=1},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="stone-brick", amount=8},
      {type="item", name="iron-plate", amount=8},
      {type="item", name="motor", amount=2},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "electric-mining-drill",
  normal = {
    enabled = false,
    ingredients = {
      {type="item", name="iron-gear-wheel", amount=4},
      {type="item", name="electric-motor", amount=2},
      {type="item", name="burner-mining-drill", amount=1},
    },
  },
  expensive = {
    enabled = false,
    ingredients = {
      {type="item", name="iron-gear-wheel", amount=8},
      {type="item", name="electric-motor", amount=4},
      {type="item", name="burner-mining-drill", amount=2},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "assembling-machine-1",
  normal = {
    ingredients = {
      {type="item", name="iron-gear-wheel", amount=4},
      {type="item", name="electric-motor", amount=1},
      {type="item", name="burner-assembling-machine", amount=1},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="iron-gear-wheel", amount=8},
      {type="item", name="electric-motor", amount=4},
      {type="item", name="burner-assembling-machine", amount=1},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "assembling-machine-2",
  normal = {
    ingredients = {
      {type="item", name="iron-gear-wheel", amount=4},
      {type="item", name="electronic-circuit", amount=4},
      {type="item", name="electric-motor", amount=2},
      {type="item", name="assembling-machine-1", amount=1},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="iron-gear-wheel", amount=4},
      {type="item", name="electronic-circuit", amount=8},
      {type="item", name="electric-motor", amount=4},
      {type="item", name="assembling-machine-1", amount=1},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "assembling-machine-3",
  normal = {
    ingredients = {
      {type="item", name="concrete", amount=8},
      {type="item", name="iron-gear-wheel", amount=4},
      {type="item", name="advanced-circuit", amount=8},
      {type="item", name="electric-motor", amount=4},
      {type="item", name="assembling-machine-2", amount=1},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="concrete", amount=16},
      {type="item", name="iron-gear-wheel", amount=4},
      {type="item", name="advanced-circuit", amount=16},
      {type="item", name="electric-engine-unit", amount=4},
      {type="item", name="assembling-machine-2", amount=1},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "chemical-plant",
  normal = {
    ingredients = {
      {type="item", name="steel-plate", amount=5},
      {type="item", name=basic_circuit, amount=5},
      {type="item", name="pipe", amount=5},
      {type="item", name="stone-brick", amount=5},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="steel-plate", amount=5},
      {type="item", name=basic_circuit, amount=10},
      {type="item", name="pipe", amount=10},
      {type="item", name="stone-brick", amount=10},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "lab",
  normal = {
    ingredients = {
      {type="item", name="electronic-circuit", amount=5},
      {type="item", name="electric-motor", amount=5},
      {type="item", name="burner-lab", amount=1},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="electronic-circuit", amount=12},
      {type="item", name="electric-motor", amount=6},
      {type="item", name="burner-lab", amount=1},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "beacon",
  normal = {
    ingredients = {
      {type="item", name="advanced-circuit", amount=20},
      {type="item", name="concrete", amount=10},
      {type="item", name="steel-plate", amount=10},
      {type="item", name="electric-motor", amount=10},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="advanced-circuit", amount=80},
      {type="item", name="concrete", amount=40},
      {type="item", name="steel-plate", amount=40},
      {type="item", name="electric-motor", amount=40},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "offshore-pump",
  normal = {
    enabled = false,
    ingredients = {
      {type="item", name="electric-motor", amount=2},
      {type="item", name="pipe", amount=4},
    },
  },
  expensive = {
    enabled = false,
    ingredients = {
      {type="item", name="electric-motor", amount=8},
      {type="item", name="pipe", amount=8},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "pump",
  normal = {
    ingredients = {
      {type="item", name="electric-motor", amount=2},
      {type="item", name="pipe", amount=2},
      {type="item", name="steel-plate", amount=1},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="electric-motor", amount=4},
      {type="item", name="pipe", amount=8},
      {type="item", name="steel-plate", amount=4},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "pumpjack",
  normal = {
    ingredients = {
      {type="item", name="steel-plate", amount=15},
      {type="item", name="iron-gear-wheel", amount=10},
      {type="item", name="electric-motor", amount=10},
      {type="item", name="pipe", amount=10},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="steel-plate", amount=20},
      {type="item", name="iron-gear-wheel", amount=20},
      {type="item", name="electric-motor", amount=15},
      {type="item", name="pipe", amount=50},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "small-electric-pole",
  normal = {
    enabled = false,
    ingredients = {
      {type="item", name="raw-wood", amount=1},
      {type="item", name="copper-cable", amount=1},
    },
    results= { {type="item", name="small-electric-pole", amount=1} }
  },
  expensive = {
    enabled = false,
    ingredients = {
      {type="item", name="raw-wood", amount=1},
      {type="item", name="copper-cable", amount=1},
    },
    results= { {type="item", name="small-electric-pole", amount=1} }
  }
})

util.conditional_modify({
  type = "recipe",
  name = "medium-electric-pole",
  ingredients = {
    {type="item", name="steel-plate", amount=2},
    {type="item", name="copper-cable", amount=4},
    {type="item", name="small-iron-electric-pole", amount=1},
  }
})

util.conditional_modify({
  type = "recipe",
  name = "big-electric-pole",
  ingredients = {
    {type="item", name="steel-plate", amount=5},
    {type="item", name="copper-cable", amount=10},
  }
})

util.conditional_modify({
  type = "recipe",
  name = "substation",
  normal = {
    ingredients = {
      {type="item", name="copper-cable", amount=20},
      {type="item", name="steel-plate", amount=10},
      {type="item", name="concrete", amount=5},
      {type="item", name="advanced-circuit", amount=5},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="copper-cable", amount=40},
      {type="item", name="steel-plate", amount=20},
      {type="item", name="concrete", amount=10},
      {type="item", name="advanced-circuit", amount=10},
    },
  }
})

if data.raw.recipe["roboport-door-1"] then
  -- modify bobs roboport components

  util.replace_or_add_ingredient (data.raw.recipe["roboport-antenna-1"], nil, "electric-motor", 10)
  util.replace_or_add_ingredient (data.raw.recipe["roboport-antenna-1"], "steel-plate", "steel-plate", 15)
  util.replace_or_add_ingredient (data.raw.recipe["roboport-antenna-1"], "electronic-circuit", "electronic-circuit", 25)
  util.replace_or_add_ingredient (data.raw.recipe["roboport-chargepad-1"], nil, "electric-motor", 3)
  util.replace_or_add_ingredient (data.raw.recipe["roboport-chargepad-1"], "steel-plate", "steel-plate", 10)
  util.replace_or_add_ingredient (data.raw.recipe["roboport-door-1"], nil, "electric-motor", 30)
  util.replace_or_add_ingredient (data.raw.recipe["roboport-door-1"], "steel-plate", "steel-plate", 30)
  util.replace_or_add_ingredient (data.raw.recipe["roboport-door-1"], nil, "concrete", 50)

else
  -- modify vanilla
  util.conditional_modify({
    type = "recipe",
    name = "roboport",
    normal = {
      ingredients = {
        {type="item", name="steel-plate", amount=50},
        {type="item", name="electric-motor", amount=50},
        {type="item", name="advanced-circuit", amount=50},
        {type="item", name="concrete", amount=50},
      },
    },
    expensive = {
      ingredients = {
        {type="item", name="steel-plate", amount=100},
        {type="item", name="electric-motor", amount=100},
        {type="item", name="advanced-circuit", amount=100},
        {type="item", name="concrete", amount=100},
      },
    }
  })
end

util.conditional_modify({
  type = "recipe",
  name = "car",
  ingredients = {
    {type="item", name="iron-gear-wheel", amount=10},
    {type="item", name="steel-plate", amount=5},
    {type="item", name="engine-unit", amount=5},
  }
})

util.conditional_modify({
  type = "recipe",
  name = "locomotive",
  ingredients = {
    {type="item", name="steel-plate", amount=30},
    {type="item", name="engine-unit", amount=15},
    {type="item", name="iron-gear-wheel", amount=10},
    {type="item", name="electronic-circuit", amount=10},
  }
})

util.conditional_modify({
  type = "recipe",
  name = "flying-robot-frame",
  normal = {
    ingredients = {
      {type="item", name="electric-engine-unit", amount=4},
      {type="item", name="battery", amount=4},
      {type="item", name="electronic-circuit", amount=4},
      {type="item", name="steel-plate", amount=4},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="electric-engine-unit", amount=16},
      {type="item", name="battery", amount=24},
      {type="item", name="electronic-circuit", amount=16},
      {type="item", name="steel-plate", amount=16},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "gun-turret",
  normal = {
    ingredients = {
      {type="item", name="iron-plate", amount=16},
      {type="item", name=basic_circuit, amount=6},
      {type="item", name="iron-gear-wheel", amount=8},
      {type="item", name="motor", amount=2},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="iron-plate", amount=16},
      {type="item", name=basic_circuit, amount=8},
      {type="item", name="iron-gear-wheel", amount=16},
      {type="item", name="motor", amount=4},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "laser-turret",
  normal = {
    ingredients = {
      {type="item", name="steel-plate", amount=20},
      {type="item", name="electronic-circuit", amount=20},
      {type="item", name="battery", amount=12},
      {type="item", name="electric-motor", amount=2},
    },
  },
  expensive = {
    ingredients = {
      {type="item", name="steel-plate", amount=20},
      {type="item", name="electronic-circuit", amount=30},
      {type="item", name="battery", amount=40},
      {type="item", name="electric-motor", amount=4},
    },
  }
})

util.conditional_modify({
  type = "recipe",
  name = "gate",
  ingredients = {
    {type="item", name="stone-wall", amount=1},
    {type="item", name="steel-plate", amount=2},
    {type="item", name=basic_circuit, amount=2},
    {type="item", name="motor", amount=2},
  }
})

util.conditional_modify({
  type = "recipe",
  name = "radar",
  normal = {
    enabled = false,
    ingredients = {
      {type="item", name="iron-plate", amount=20},
      {type="item", name="electronic-circuit", amount=8},
      {type="item", name="stone-brick", amount=4},
      {type="item", name="electric-motor", amount=4},
    },
  },
  expensive = {
    enabled = false,
    ingredients = {
      {type="item", name="iron-plate", amount=20},
      {type="item", name="electronic-circuit", amount=20},
      {type="item", name="stone-brick", amount=20},
      {type="item", name="electric-motor", amount=12},
    },
  }
})

-- armour upgrade path
if data.raw.armor["light-armor"] and data.raw.recipe["heavy-armor"] then
  util.replace_or_add_ingredient(data.raw.recipe["heavy-armor"], nil, "light-armor", 1)
end
if data.raw.armor["heavy-armor"] and data.raw.recipe["modular-armor"] then
  util.replace_or_add_ingredient(data.raw.recipe["modular-armor"], nil, "heavy-armor", 1)
end
if data.raw.armor["modular-armor"] and data.raw.recipe["power-armor"] then
  util.replace_or_add_ingredient(data.raw.recipe["power-armor"], nil, "modular-armor", 1)
end
if data.raw.armor["power-armor"] and data.raw.recipe["power-armor-mk2"] then
  util.replace_or_add_ingredient(data.raw.recipe["power-armor-mk2"], nil, "power-armor", 1)
end
