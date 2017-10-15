data.raw.lab.lab.fast_replaceable_group = "lab"
local burner_lab = table.deepcopy(data.raw.lab.lab)
burner_lab.name = "burner-lab"
burner_lab.minable.result = "burner-lab"
burner_lab.energy_source = {
  type = "burner",
  fuel_category = "chemical",
  effectivity = 0.9,
  fuel_inventory_size = 1,
  emissions = 0.05,
  smoke =
  {
    {
      name = "smoke",
      deviation = {0.1, 0.1},
      position = {0.0, -0.9},
      frequency = 4
    }
  }
}
burner_lab.icon = "__aai-industry__/graphics/icons/burner-lab.png"
burner_lab.on_animation =
{
  filename = "__aai-industry__/graphics/entity/burner-lab.png",
  width = 113,
  height = 91,
  frame_count = 33,
  line_length = 11,
  animation_speed = 1 / 3,
  shift = {0.2, 0.15}
}
burner_lab.off_animation =
{
  filename = "__aai-industry__/graphics/entity/burner-lab.png",
  width = 113,
  height = 91,
  frame_count = 1,
  shift = {0.2, 0.15}
}
burner_lab.module_specification = nil

data:extend({ burner_lab })
