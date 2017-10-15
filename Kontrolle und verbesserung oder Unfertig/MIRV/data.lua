data:extend({
  {
    type = "item",
    name = "mirv-item",
    icon = "__MIRV__/mirv_item.png",
    flags = {"goes-to-quickbar"},
    subgroup = "capsule",
    order = "z[MIRV]",
    place_result = "mirv-entity",
    stack_size = 50
  },
  {
    type = "item",
    name = "mirv-rocket",
    icon = "__MIRV__/mirv_rocket.png",
    flags = {"goes-to-quickbar"},
    subgroup = "defensive-structure",
    order = "z[MIRV]",
    stack_size = 1
  },
  {
    type = "recipe",
    name = "mirv-rocket",
    energy_required = 10,
    enabled = false,
    category = "crafting",
    ingredients =
    {
      {"atomic-bomb", 20},
      {"rocket-fuel", 50},
      {"rocket-control-unit", 10}
    },
    result= "mirv-rocket",
    order = "z[MIRV]"
  },
  {
    type = "simple-entity-with-owner",
    name = "mirv-entity",
    render_layer = "object",
    icon = "__MIRV__/mirv_item.png",
    flags = {"placeable-neutral", "player-creation", "placeable-off-grid"},
    selectable_in_game = false,
    order = "z[MIRV]",
    max_health = 1,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{-0.5, -0.5}, {0.5, 0.5}},
    drawing_box = {{-32, -32},{32,32}},
    picture =
    {
      layers =
      {
        {
          filename = "__MIRV__/mirv_template.png",
          priority = "extra-high",
          width = 768,
          height = 548,
          scale = 3,
          shift = util.by_pixel(0,-32)
        },
      }
    }
  },
  {
    type = "smoke",
    name = "mirv-smoke",
    flags = {"not-on-map"},
    duration = 440,
    fade_in_duration = 0,
    fade_away_duration = 0,
    spread_duration = 380,
    start_scale = 3,
    end_scale = 1,
    cyclic = true,
    affected_by_wind = false,
    movement_slow_down_factor = 1,
    color = {r = 1, g = 1, b = 1},
    render_layer = "lower-object",
    animation = 
    {
      width = 624,
      height = 440,
      line_length = 3,
      frame_count = 12,
      axially_symmetrical = false,
      direction_count = 1,
      priority = "high",
      animation_speed = 0.25,
      filename = "__MIRV__/mirv_anim.png"
    }
  },
  {
    type = "smoke",
    name = "mirv-smoke-2",
    flags = {"not-on-map"},
    duration = 440,
    fade_in_duration = 0,
    fade_away_duration = 0,
    spread_duration = 380,
    start_scale = 3,
    end_scale = 1,
    cyclic = true,
    affected_by_wind = false,
    movement_slow_down_factor = 1,
    color = {r = 1, g = 1, b = 1},
    render_layer = "lower-object",
    animation = 
    {
      width = 800,
      height = 565,
      line_length = 1,
      frame_count = 1,
      axially_symmetrical = false,
      direction_count = 1,
      priority = "high",
      animation_speed = 0.25,
      filename = "__MIRV__/mirv_static.png"
    }
  },
  {
    type = "simple-entity-with-force",
    name = "mirv-target",
    render_layer = "object",
    icon = "__MIRV__/mirv-target.png",
    flags = {},
    order = "z[MIRV]",
    max_health = 1,
    selectable_in_game = false,
    collision_box = {{0, 0}, {0, 0}},
    selection_box = {{0, 0}, {0, 0}},
    picture =
    {
      filename = "__core__/graphics/empty.png",
      priority = "extra-high",
      width = 1,
      height = 1
    }
  },
  {
    type = "technology",
    name = "mirv-technology",
    icon = "__MIRV__/mirv-technology.png",
    icon_size = 128,
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "mirv-rocket"
      }
    },
    prerequisites = {"rocket-silo", "atomic-bomb"},
    unit =
    {
      count = 10000,
      ingredients =
      {
        {"science-pack-1", 1},
        {"science-pack-2", 1},
        {"science-pack-3", 1},
        {"military-science-pack", 1},
        {"production-science-pack", 1},
        {"high-tech-science-pack", 1}
      },
      time = 45
    },
    order = "e-a-c"
  },
  {
    type = "explosion",
    name = "mirv-sound",
    flags = {"not-on-map"},
    animations =
    {
      {
        filename = "__core__/graphics/empty.png",
        priority = "extra-high",
        width = 1,
        height = 1,
        frame_count = 1,
        animation_speed = 1
      }
    },
    sound =
    {
      aggregation =
      {
        max_count = 1,
        remove = true
      },
      variations =
      {
        {
          filename = "__MIRV__/launch-sound.ogg",
          volume = 1
        }
      }
    }
  },
})

table.insert(data.raw["rocket-silo-rocket"]["rocket-silo-rocket"].result_items, {"mirv-item", 5, "mirv-rocket"})