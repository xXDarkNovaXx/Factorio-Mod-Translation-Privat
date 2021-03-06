data:extend({
{
  name = "repair-beam",
  type = "beam",
  action = {
    action_delivery = {
      target_effects = {
        {
          damage = {
            amount = 0,
            type = "repair"
          },
          type = "damage"
        }
      },
      type = "instant"
    },
    type = "direct"
  },
  body = {
    {
      blend_mode = "additive-soft",
      filename = "__aai-vehicles-warden__/graphics/entity/repair-beam/beam-body-1.png",
      frame_count = 16,
      height = 39,
      line_length = 16,
      width = 45
    },
    {
      blend_mode = "additive-soft",
      filename = "__aai-vehicles-warden__/graphics/entity/repair-beam/beam-body-2.png",
      frame_count = 16,
      height = 39,
      line_length = 16,
      width = 45
    },
    {
      blend_mode = "additive-soft",
      filename = "__aai-vehicles-warden__/graphics/entity/repair-beam/beam-body-3.png",
      frame_count = 16,
      height = 39,
      line_length = 16,
      width = 45
    },
    {
      blend_mode = "additive-soft",
      filename = "__aai-vehicles-warden__/graphics/entity/repair-beam/beam-body-4.png",
      frame_count = 16,
      height = 39,
      line_length = 16,
      width = 45
    },
    {
      blend_mode = "additive-soft",
      filename = "__aai-vehicles-warden__/graphics/entity/repair-beam/beam-body-5.png",
      frame_count = 16,
      height = 39,
      line_length = 16,
      width = 45
    },
    {
      blend_mode = "additive-soft",
      filename = "__aai-vehicles-warden__/graphics/entity/repair-beam/beam-body-6.png",
      frame_count = 16,
      height = 39,
      line_length = 16,
      width = 45
    }
  },
  damage_interval = 20,
  flags = {
    "not-on-map"
  },
  head = {
    animation_speed = 0.5,
    blend_mode = "additive-soft",
    filename = "__aai-vehicles-warden__/graphics/entity/repair-beam/beam-head.png",
    frame_count = 16,
    height = 39,
    line_length = 16,
    width = 45
  },
  tail = {
    blend_mode = "additive-soft",
    filename = "__aai-vehicles-warden__/graphics/entity/repair-beam/beam-tail.png",
    frame_count = 16,
    height = 39,
    line_length = 16,
    width = 45
  },
  width = 0.5,
  working_sound = {
    {
      filename = "__aai-vehicles-warden__/sound/repair.ogg",
      --filename = "__base__/sound/fight/electric-beam.ogg",
      volume = 1
    }
  },
}})
