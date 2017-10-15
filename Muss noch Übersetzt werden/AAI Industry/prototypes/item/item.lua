data:extend({
  {
    type = "item",
    name = "stone-tablet",
    icon = "__aai-industry__/graphics/icons/stone-tablet.png",
    flags = {"goes-to-main-inventory"},
    subgroup = "raw-material",
    order = "a[wood]-b[stone-tablet]",
    stack_size = 100,
  },
  {
    type = "item",
    name = "motor",
    icons = {
      {
        icon = "__aai-industry__/graphics/icons/motor-base.png"
      },
      {
        icon = "__aai-industry__/graphics/icons/motor-mask.png",
        tint = { r = 1, g = 0.9, b = 0}
      }
    },
    flags = {"goes-to-main-inventory"},
    subgroup = "intermediate-product",
    order = "g[engine-unit]-a[motor]",
    stack_size = 50,
  },
  {
    type = "item",
    name = "electric-motor",
    icons = {
      {
        icon = "__aai-industry__/graphics/icons/electric-motor-base.png"
      },
      {
        icon = "__aai-industry__/graphics/icons/electric-motor-mask.png",
        tint = { r = 0.4, g = 0.6, b = 1}
      }
    },
    flags = {"goes-to-main-inventory"},
    subgroup = "intermediate-product",
    order = "g[engine-unit]-b[electric-motor]",
    stack_size = 50,
  },
  {
    type = "item",
    name = "small-iron-electric-pole",
    icon = "__aai-industry__/graphics/icons/small-iron-electric-pole.png",
    flags = {"goes-to-quickbar"},
    subgroup = "energy-pipe-distribution",
    order = "a[energy]-a[small-electric-pole]",
    place_result = "small-iron-electric-pole",
    stack_size = 50
  },
  {
    type = "item",
    name = "concrete-wall",
    flags = {
      "goes-to-quickbar"
    },
    icon = "__aai-industry__/graphics/icons/concrete-wall.png",
    order = "a[stone-wall]-b[concrete-wall]",
    place_result = "concrete-wall",
    stack_size = 50,
    subgroup = "defensive-structure",
  },
  {
    type = "item",
    name = "burner-lab",
    icon = "__aai-industry__/graphics/icons/burner-lab.png",
    flags = data.raw.item.lab.flags,
    subgroup = data.raw.item.lab.subgroup,
    order = data.raw.item.lab.order,
    stack_size = data.raw.item.lab.stack_size,
    place_result = "burner-lab",
  },
  {
    type = "item",
    name = "burner-assembling-machine",
    icon = "__aai-industry__/graphics/icons/burner-assembling-machine.png",
    flags = data.raw.item["assembling-machine-1"].flags,
    subgroup = data.raw.item["assembling-machine-1"].subgroup,
    order = data.raw.item["assembling-machine-1"].order .. "-a",
    stack_size = data.raw.item["assembling-machine-1"].stack_size,
    place_result = "burner-assembling-machine",
  },
  {
    type = "item",
    name = "burner-turbine",
    icon = "__aai-industry__/graphics/icons/burner-turbine.png",
    flags = {"goes-to-quickbar"},
    subgroup = "energy",
    order = "a-a",
    place_result = "burner-turbine",
    stack_size = 50
  },
})
data.raw.item["assembling-machine-1"].order = data.raw.item["assembling-machine-1"].order .. "-b"
