data.raw["offshore-pump"]["offshore-pump"] = nil
data:extend({{
  type = "offshore-pump",
  name = "offshore-pump",
  icon = "__aai-industry__/graphics/icons/offshore-pump.png",
  flags = {"placeable-neutral", "player-creation", "filter-directions"},
  minable = {mining_time = 1, result = "offshore-pump"},
  max_health = 150,
  corpse = "small-remnants",
  fluid = "water",
  resistances =   { { type = "fire", percent = 70 }, { type = "impact",   percent = 30 } },
  collision_box = {{-0.9, -0.45}, {0.9, 0.45}}, --{{-0.6, -0.45}, {0.6, 0.3}},
  selection_box = {{-1, -1.5}, {1, 0.5}}, --{{-1, -1.49}, {1, 0.49}},
  fluid_box = {
    base_area = 1,
    base_level = 1,
    pipe_covers = pipecoverspictures(),
    pipe_connections = { { position = {0, -1} }, }, -- {0, 1}
  },
  pumping_speed = 20,
  tile_width = 1,
  vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  picture = {
    north = {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-north.png",
      priority = "high",
      shift = util.by_pixel(5, -18),
      width = 89,
      height = 69
    },
    east = {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-east.png",
      priority = "high",
      shift = util.by_pixel(31, -5),
      width = 94,
      height = 78
    },
    south = {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-south.png",
      priority = "high",
      shift = util.by_pixel(5, 22),
      width = 90,
      height = 76
    },
    west = {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-west.png",
      priority = "high",
      shift = util.by_pixel(-17, -7),
      width = 66,
      height = 75
    }
  },
  circuit_wire_connection_points =
  {
    {
      shadow = {
        red = {2.71875, 0.375},
        green = {2.5, 0.375},
      },
      wire = {
        red = {0.84375, -0.09375},
        green = {0.6875, -0.09375},
      }
    },
    {
      shadow = {
        red = {0.765625, 0.546875},
        green = {0.765625, 0.421875},
      },
      wire = {
        red = {-0.28125, -0.09375},
        green = {-0.28125, -0.21875},
      }
    },
    {
      shadow = {
        red = {-0.09375, 0.5625},
        green = {0.0625, 0.5625},
      },
      wire = {
        red = {-0.90625, -0.53125},
        green = {-0.75, -0.53125},
      }
    },
    {
      shadow = {
        red = {1.78125, -0.46875},
        green = {1.78125, -0.3125},
      },
      wire = {
        red = {0.34375, -1.40625},
        green = {0.34375, -1.25},
      }
    }
  },
  circuit_connector_sprites =
  {
    get_circuit_connector_sprites({0.90625, -0.15625}, nil, 0),
    get_circuit_connector_sprites({0, 0.03125}, nil, 6),
    get_circuit_connector_sprites({-0.9375, -0.25}, nil, 4),
    get_circuit_connector_sprites({0.125, -1.3125}, nil, 2),
  },
  circuit_wire_max_distance = 7.5
}})

local offshore_pump_output = {
  type = "pump",
  name = "offshore-pump-output",
  --selection_box = {{-1.1, -0.4}, {1.1, 0.4}},
  selectable_in_game = false,
  selection_box = {{-1, -1.5}, {1, 0.5}},
  collision_box = {{-0.9, -1.25}, {0.9, 0}},
  fluid_box =
  {
    base_area = 1,
    height = 2,
    pipe_covers = pipecoverspictures(),
    pipe_connections =
    {
      { position = {0, 0.9}, type="output" },
      { position = {0, 0.1}, type="input" },
    },
  },
  order="z",
  icon = "__aai-industry__/graphics/icons/offshore-pump.png",
  flags = {"placeable-neutral", "player-creation", "not-deconstructable", "not-blueprintable", "placeable-off-grid"},
  max_health = 150,
  resistances =
  {
    {
      type = "fire",
      percent = 70
    },
    {
      type = "impact",
      percent = 30
    }
  },
  corpse = "small-remnants",
  energy_source =
  {
    type = "electric",
    usage_priority = "secondary-input",
    emissions = 0.01 / 2.5
  },
  energy_usage = "30kW",
  pumping_speed = 200, -- limited by offshore section
  vehicle_impact_sound =  { filename = "__base__/sound/car-metal-impact.ogg", volume = 0.65 },
  animations =
  {
    north =
    {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-north-animation.png",
      width = 152/8,
      height = 80/4,
      line_length =8,
      frame_count =32,
      animation_speed = 0.5,
      shift = util.by_pixel(0, -25),
    },
    east =
    {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-east-animation.png",
      width = 232/8,
      height = 164/4,
      line_length =8,
      frame_count =32,
      animation_speed = 0.5,
      shift = util.by_pixel(-16+32-7.5, 4-7),
    },
    south =
    {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-south-animation.png",
      width = 152/8,
      height = 48/4,
      line_length =8,
      frame_count =32,
      animation_speed = 0.5,
      shift = util.by_pixel(0, -6),
    },
    west =
    {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-west-animation.png",
      width = 216/8,
      height = 164/4,
      line_length =8,
      frame_count =32,
      animation_speed = 0.5,
      shift = util.by_pixel(-6, -2),
    },
  },
  fluid_animation =
  {
    north =
    {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-north-liquid.png",
      width = 26,
      height = 55,
      line_length =8,
      frame_count =32,
      shift = util.by_pixel(3, -11),
      hr_version = {
        filename = "__aai-industry__/graphics/entity/offshore-pump/hr-offshore-pump-north-liquid.png",
        width = 38,
        height = 45,
        scale = 0.5,
        line_length =8,
        frame_count =32,
        shift = util.by_pixel(3, -11)
      },
    },
    east =
    {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-east-liquid.png",
      width = 18,
      height = 24,
      line_length =8,
      frame_count =32,
      shift = util.by_pixel(10, -11),
      hr_version = {
        filename = "__aai-industry__/graphics/entity/offshore-pump/hr-offshore-pump-east-liquid.png",
        width = 35,
        height = 47,
        scale = 0.5,
        line_length =8,
        frame_count =32,
        shift = util.by_pixel(10, -11),
      },
    },
    south =
    {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-south-liquid.png",
      apply_runtime_tint = true,
      width = 20,
      height = 13,
      line_length =8,
      frame_count =32,
      shift = util.by_pixel(-0.500, -6),
      hr_version = {
        filename = "__aai-industry__/graphics/entity/offshore-pump/hr-offshore-pump-south-liquid.png",
        apply_runtime_tint = true,
        width = 38,
        height = 22,
        scale = 0.5,
        line_length =8,
        frame_count =32,
        shift = util.by_pixel(-0.500, -6),
      }
    },
    west =
    {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-west-liquid.png",
      width = 18,
      height = 24,
      line_length =8,
      frame_count =32,
      shift = util.by_pixel(-9, -10),
      hr_version = {
        filename = "__aai-industry__/graphics/entity/offshore-pump/hr-offshore-pump-west-liquid.png",
        width = 35,
        height = 46,
        scale = 0.5,
        line_length =8,
        frame_count =32,
        shift = util.by_pixel(-9, -10),
      },
    },
  },
  glass_pictures =
  {
    north = {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-north-glass.png",
      width = 18,
      height = 21,
      shift = util.by_pixel(-0.5, -26),
      hr_version = {
        filename = "__aai-industry__/graphics/entity/offshore-pump/hr-offshore-pump-north-glass.png",
        width = 18*2,
        height = 21*2,
        scale = 0.5,
        shift = util.by_pixel(-0.5, -26)
      },
    },
    east = {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-east-glass.png",
      width = 16,
      height = 16,
      shift = util.by_pixel(9, -15),
      hr_version = {
        filename = "__aai-industry__/graphics/entity/offshore-pump/hr-offshore-pump-east-glass.png",
        width = 16*2,
        height = 16*2,
        scale = 0.5,
        shift = util.by_pixel(9, -15),
      },
    },
    south = {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-south-glass.png",
      width = 17,
      height = 12,
      shift = util.by_pixel(0, -6),
      hr_version = {
        filename = "__aai-industry__/graphics/entity/offshore-pump/hr-offshore-pump-south-glass.png",
        width = 17*2,
        height = 12*2,
        scale = 0.5,
        shift = util.by_pixel(0, -6),
      },
    },
    west = {
      filename = "__aai-industry__/graphics/entity/offshore-pump/offshore-pump-west-glass.png",
      width = 15,
      height = 16,
      shift = util.by_pixel(-9, -13),
      hr_version = {
        shift = util.by_pixel(-9, -13),
        filename = "__aai-industry__/graphics/entity/offshore-pump/hr-offshore-pump-west-glass.png",
        width = 15*2,
        height = 16,
        scale = 0.5,
      },
    },
  },
  circuit_wire_max_distance = 0
}
data:extend({offshore_pump_output})
