data:extend({{
	type = "item-with-entity-data",
	name = "vehicle-laser-tank",
	icon = "__aai-vehicles-laser-tank__/graphics/icons/laser-tank.png",
	flags = {"goes-to-quickbar"},
	subgroup="transport",
    order = "b[personal-transport]-d[laser-tank]",
	stack_size = 1,
	place_result = "vehicle-laser-tank",
},
{
	type = "ammo-category",
	name = "laser-cannon"
},
{
    type = "ammo",
    name = "laser-cannon-battery-piercing",
    icon = "__aai-vehicles-laser-tank__/graphics/icons/laser-cannon-battery-piercing.png",
    flags = {"goes-to-main-inventory"},
    ammo_type =
    {
      category = "laser-cannon",
      target_type = "direction",
      action =
      {
        type = "line",
        range = 30.5,
        width = 0.75,
        source_effects =
        {
          type = "create-explosion",
          entity_name = "laser-cannon-beam"
        },
        action_delivery =
        {
          type = "instant",
          target_effects =
          {
            type = "damage",
            damage = { amount = 160, type="laser"}
          }
        }
      }
    },
    magazine_size = 6,
    subgroup = "ammo",
    order = "q[laser-cannon]-g[laser]",
    stack_size = 100
},
{
    type = "ammo",
    name = "laser-cannon-battery-focussed",
    icon = "__aai-vehicles-laser-tank__/graphics/icons/laser-cannon-battery-focussed.png",
    flags = {"goes-to-main-inventory"},
    ammo_type =
    {
      category = "laser-cannon",
      action =
      {
        type = "direct",
        action_delivery =
        {
          type = "instant",
		  source_effects =
		  {
		    type = "create-explosion",
		    entity_name = "laser-cannon-beam"
		  },
          target_effects =
          {
            {
              type = "damage",
              damage = { amount = 200 , type = "laser"}
            }
          }
        }
      }
    },
    magazine_size = 8,
    subgroup = "ammo",
    order = "q[laser-cannon]-g[laser]",
    stack_size = 100
},
{
    type = "gun",
    name = "laser-tank-cannon",
    icon = "__aai-vehicles-laser-tank__/graphics/icons/laser-tank-cannon.png",
    flags = {"goes-to-main-inventory", "hidden"},
    subgroup = "gun",
    order = "z[tank]-a[cannon]",
    attack_parameters =
    {
      type = "projectile",
      ammo_category = "laser-cannon",
      cooldown = 40,
      movement_slow_down_factor = 0,
      projectile_creation_distance = 1.6,
      projectile_center = {0, -0.07812},
      range = 30,
      sound =
      {
        {
          filename = "__base__/sound/fight/tank-cannon.ogg",
          volume = 1.0
        }
      },
    },
    stack_size = 5
  },
})
