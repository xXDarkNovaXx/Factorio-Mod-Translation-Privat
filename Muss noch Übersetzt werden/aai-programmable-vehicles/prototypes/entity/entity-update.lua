local data_util = require("data-util")

local vehicle_impact_low = 0.01
local vehicle_impact_med = 0.25
local vehicle_impact_max = 1

-- reduce all car entity weight in order to reduce impact damage
-- reduce effectivity to compensate fro reduced weight
-- this makes the tumbler much less effective
for _,vehicle in pairs(data.raw.car) do
    local multiplier = vehicle_impact_low
    if string.find(vehicle.name, "tank", 1, true) then
        multiplier = vehicle_impact_med -- tanks should deal some impact damage
    end
    if string.find(vehicle.name, "tumbler", 1, true) then
        multiplier = vehicle_impact_max -- ramming specialist should deal high damage
    end
    vehicle.weight = (vehicle.weight or 0) * multiplier
    vehicle.effectivity = (vehicle.effectivity or 1) * multiplier
    vehicle.braking_power = (data_util.string_to_number(vehicle.braking_power or 0) * multiplier) .. "W"
end


-- make all walls more more durable
for _, wall in pairs(data.raw.wall) do
    wall.resistances = wall.resistances or {}

    local resistance_updated = false
    for _, resistance in ipairs(wall.resistances) do
        if resistance.type == "impact" then
            resistance_updated = true
            resistance.percent = 100 - ((100 - (resistance.percent or 0)) / 2)
            resistance.decrease = (resistance.decrease or 0) + 100
        end
    end
    if not resistance_updated then
        table.insert(wall.resistances, { type = "impact", percent = 50, decrease=100 })
    end
end

local function add_resistance(resistances, resistance)
    local resistance_updated = false
    for _, old_resistance in ipairs(resistances) do
        if old_resistance.type == resistance.type then
            resistance_updated = true
            local old_pdt = (100 - (old_resistance.percent or 0))/100
            local add_pdt = (100 - (resistance.percent or 0))/100
            local total_pdt = old_pdt * add_pdt

            old_resistance.percent = 100 - (total_pdt * 100)
            old_resistance.decrease = math.max((old_resistance.decrease or 0), (resistance.decrease or 0))
        end
    end
    if not resistance_updated then
        table.insert(resistances, resistance)
    end
end

local function replace_resistance(resistances, resistance)
    local resistance_updated = false
    for _, old_resistance in ipairs(resistances) do
        if old_resistance.type == resistance.type then
            resistance_updated = true
            old_resistance.percent = resistance.percent or 0
            old_resistance.decrease = resistance.decrease or 0
        end
    end
    if not resistance_updated then
        table.insert(resistances, resistance)
    end
end

local function make_composite_unit_from_vehicle(vehicle)

    local localised_name = vehicle.localised_name or { "entity-name.".. vehicle.name}
    vehicle.localised_name = localised_name

    -- do any required vehicle modifications
    if (not vehicle.weight) or vehicle.weight <= 0 or data_util.string_to_number(vehicle.consumption) <= 1 then return end
    vehicle.resistances = vehicle.resistances or {}
    vehicle.fast_replaceable_group = nil
    add_resistance(vehicle.resistances, {type = "impact", percent = 50 }) -- take less damage

    -- only 1 gun per vehicle
    if vehicle.guns and #vehicle.guns > 1 then
        -- assume last gun is best?
        vehicle.guns = {vehicle.guns[#vehicle.guns]}
    end

    -- collision_box should be square otherwise it will get stuck during rotation
    local extent_min = math.min(-vehicle.collision_box[1][1], -vehicle.collision_box[1][2], vehicle.collision_box[2][1], vehicle.collision_box[2][2])
    vehicle.collision_box = {{-extent_min,-extent_min},{extent_min,extent_min}}
    vehicle.order = "z["..data_util.programmable_identifier.."]" -- make sure it's picked up in control.lua
    vehicle.flags = vehicle.flags or {}
    table.insert(vehicle.flags, "player-creation")
    table.insert(vehicle.flags, "placeable-player")
    vehicle.subgroup = "cars"

    -- solid used for auto-vehicle mode base
    local solid = table.deepcopy(vehicle)
    solid.name = solid.name .. data_util.composite_suffix.."solid"
    solid.turret_animation = nil
    solid.order = "z-z"
    table.insert(solid.flags, "player-creation")
    solid.resistances = solid.resistances or {}
    --add_resistance(solid.resistances, {type = "impact", decrease = 200 }) -- immune to small bumps
    -- immune to bumps breaks the nudge anti-stuck function
    --add_resistance(solid.resistances, {type = "impact", percent = 99.5 }) -- take less damage (but not 0)
    replace_resistance(solid.resistances, {type = "impact", percent = 99.99 }) -- take less damage (but not 0)
    data:extend{solid}

    -- ghost used for unit-mode base
    local ghost = table.deepcopy(vehicle)
    ghost.name = ghost.name .. data_util.composite_suffix.."ghost"
    ghost.collision_box = {{-0.0, -0.0}, {0.0, 0.0}}
    ghost.collision_mask = { "not-colliding-with-itself" }
    ghost.turret_animation = nil
    ghost.order = "z-z"
    table.insert(ghost.flags, "player-creation")
    data:extend{ghost}

    -- turret - a dummy vehicle used as a rotatble graphic for the turret
    if vehicle.turret_animation and vehicle.turret_animation.layers and #vehicle.turret_animation.layers > 0 then
        local turret_animation = table.deepcopy(vehicle.turret_animation)
        -- offset by inverse of turret y offset so it can be rendered on top
        for _,layer in pairs(turret_animation.layers) do
            local layer_shift = layer.shift and layer.shift or {0, 0}
            layer_shift[2] = layer_shift[2] - data_util.turret_y_offset
            layer.shift = layer_shift
        end
        data:extend{
            {
                type = "car",
                name = vehicle.name .. data_util.composite_suffix.."turret" ,
                icon = vehicle.icon,
                flags = {"pushable", "placeable-neutral", "player-creation", "placeable-off-grid"},
                selectable_in_game = false,
                order="z-z",
                max_health = 1000,
                healing_per_tick = 1000,
                energy_per_hit_point = 1,
                selection_box = {{-0.0, -0.0}, {0.0, 0.0}},
                collision_box = {{-0.0, -0.0}, {0.0, 0.0}},
                collision_mask = { "not-colliding-with-itself" },
                terrain_friction_modifier = 1,
                friction = 1,
                animation = turret_animation,
                rotation_speed = 0.01,
                weight = 1000,
                inventory_size = 0,
                consumption = "1W",
                braking_power = "1W",
                burner = {
                    effectivity = 1,
                    fuel_inventory_size = 1
                },
                effectivity = 1,
                localised_name = localised_name
            }
        }
    else
        vehicle.turret_animation = nil
    end

    -- damage_target - an invisible unit to force enemies to attack this unit
    local resistances = table.deepcopy(vehicle.resistances)
    replace_resistance(resistances, {type = "impact", percent = 100 })

    replace_resistance(solid.resistances, {type = "impact", percent = 99.9 }) -- take less damage (but not 0)
    data:extend{
        {
            type = "unit",
            alert_when_damaged = true,
            name = vehicle.name.. data_util.composite_suffix.."damage_target",
            icon = vehicle.icon,
            flags = {"player-creation", "placeable-player", "placeable-off-grid"},
            selectable_in_game = false,
            order="z-z",
            max_health = data_util.damage_target_max_health,
            healing_per_tick = 0,
            selection_box = {{0, 0}, {0, 0}},
            collision_box = {{-extent_min,-extent_min},{extent_min,extent_min}},
            collision_mask = { "not-colliding-with-itself" },
            vision_distance = 1,
            movement_speed = 0,
            pollution_to_join_attack = 0.0,
            distraction_cooldown = 0,
            distance_per_frame = 0,
            resistances = resistances,
            run_animation = {
                filename = "__aai-programmable-vehicles__/graphics/blank.png",
                width = 1,
                height = 1,
                frame_count = 1,
                direction_count = 1,
            },
            attack_parameters = {
                ammo_category = "melee",
                ammo_type = {
                    action = {
                        action_delivery = {
                            target_effects = {
                                damage = {
                                    amount = 10, -- the damage needs to be there to simulate drive-crushing damage otherwise unit gets stuck
                                    type = "laser"
                                },
                                type = "damage"
                            },
                            type = "instant"
                        },
                        type = "direct"
                    },
                    category = "melee",
                    target_type = "entity"
                },
                animation = {
                    filename = "__aai-programmable-vehicles__/graphics/blank.png",
                    width = 1,
                    height = 1 ,
                    frame_count = 1,
                    direction_count = 1,
                },
                cooldown = 5,
                range = 0.5,
                type = "projectile"
            },
            localised_name = localised_name
        }
    }

    local show_navigator = false
    -- navigator - an invisible unit to direct the vehicle while in unit (move_to) mode
    local navigator_size = extent_min
    if navigator_size > 0.5 then navigator_size = navigator_size / 2 + 0.25 end
    data:extend{
        {
            type = "unit",
            name = vehicle.name.. data_util.composite_suffix.."navigator",
            icon = vehicle.icon,
            flags = {"placeable-neutral", "placeable-off-grid"},
            selectable_in_game = false,
            order="z-z",
            max_health = 1000000,
            healing_per_tick = 1000000,
            alert_when_damaged = false,
            selection_box = {{-1.0, -1.0}, {1.0, 1.0}},
            collision_box = {{-navigator_size,-navigator_size},{navigator_size,navigator_size}},
            --collision_mask = { "item-layer", "object-layer", "player-layer", "water-tile"},
            --collision_mask = { "item-layer", "object-layer", "water-tile"},
            vision_distance = 1,
            -- should be faster than vehicle speed. The vehicle holds it back
            movement_speed = 1,
            distance_per_frame = 1,
            pollution_to_join_attack = 0.0,
            distraction_cooldown = 0,
            run_animation = (show_navigator and {
                    filename = "__aai-programmable-vehicles__/graphics/entity/debug-navigator.png",
                    width = 128,
                    height = 128,
                    frame_count = 1,
                    direction_count = 1,
                    } or {
                    filename = "__aai-programmable-vehicles__/graphics/blank.png",
                    width = 1,
                    height = 1,
                    frame_count = 1,
                    direction_count = 1,
                }),
            attack_parameters = {
                ammo_category = "melee",
                ammo_type = {
                    action = {
                        action_delivery = {
                            target_effects = {
                                damage = {
                                    amount = 10, -- the damage needs to be there to simulate drive-crushing damage otherwise unit gets stuck
                                    type = "laser"
                                },
                                type = "damage"
                            },
                            type = "instant"
                        },
                        type = "direct"
                    },
                    category = "melee",
                    target_type = "entity"
                },
                animation = {
                    filename = "__aai-programmable-vehicles__/graphics/blank.png",
                    width = 1,
                    height = 1 ,
                    frame_count = 1,
                    direction_count = 1,
                },
                cooldown = 30,
                range = 0.5,
                type = "projectile"
            },
            localised_name = localised_name
        }
    }

    -- buffer - an invisible object used to find open spaces and avoid getting stuck on things
    local buffer = extent_min * 1.5
    data:extend{
        {
            type = "simple-entity",
            name = vehicle.name.. data_util.composite_suffix.."buffer",
            icon = vehicle.icon,
            flags = {"placeable-neutral", "placeable-off-grid"},
            subgroup = "grass",
            order = "z-z",
            collision_box = {{-buffer, -buffer}, {buffer, buffer}},
            collision_mask = vehicle.collision_mask or { "item-layer", "player-layer", "water-tile"},
            selection_box = {{-0.0, -0.0}, {0.0, 0.0}},
            selectable_in_game = false,
            render_layer = "resource",
            pictures = {{
                    filename = "__aai-programmable-vehicles__/graphics/blank.png",
                    width = 1,
                    height = 1
            }},
            localised_name = localised_name
        }
    }

    local lamp = {
        type = "projectile",
        name = vehicle.name.. data_util.composite_suffix.."lamp2",
        flags = {
            "not-on-map"
        },
        light = {
            intensity = 0.2,
            size = 30
        },
        acceleration = 0,
        --[[
        working_sound = {
            max_sounds_per_type = 3,
            sound = {
                filename = "__base__/sound/accumulator-working.ogg",
                volume = 1
            }
        },
        --]]
        action = {
            action_delivery = {
                target_effects = {
                    {
                        entity_name = "smoke",
                        type = "create-entity"
                    }
                },
                type = "instant"
            },
            type = "direct"
        },
        animation = {
            filename = "__aai-programmable-vehicles__/graphics/blank.png",
            frame_count = 1,
            height = 1,
            line_length = 1,
            priority = "high",
            shift = { 0, 0 },
            width = 1
        },
    }

    local lamp_sound = table.deepcopy(lamp)
    --lamp_sound.emissions_per_tick = 0.005

    lamp_sound.name = vehicle.name.. data_util.composite_suffix.."lamp_sound2"
    lamp_sound.light = { intensity = 0.6, size = 40 }

    -- TODO: add activate_sound and deactivate_sound as explosions
    if vehicle.working_sound and (vehicle.working_sound.filename or vehicle.working_sound.sound) then
        lamp_sound.working_sound = {sound = table.deepcopy(vehicle.working_sound.sound or vehicle.working_sound)}
        -- increase volume to compensate for distance
        lamp_sound.working_sound.sound.volume = (lamp_sound.working_sound.volume or 1) * 1.1
        lamp_sound.working_sound.max_sounds_per_type = 3
    end

    data:extend{lamp, lamp_sound}

    -- virtual signal: allows unit to be specified without confusion with inventory items (unit items)
    local virtual_signal = {
        type = "virtual-signal",
        name = vehicle.name.. data_util.composite_suffix.."signal",
        --icon = vehicle.icon,
        icons = {
            {
                icon = "__aai-programmable-vehicles__/graphics/icons/ids/id_background.png"
            },
            {
                icon = vehicle.icon
            },
            {
                icon = "__aai-programmable-vehicles__/graphics/icons/ids/id_overlay.png"
            },
        },
        subgroup = "vehicle-ids",
        order = "a[vehicle]",
        localised_name = { "vehicle-signal", localised_name}
    }
    data:extend{ virtual_signal }

    data_raw_require("car", vehicle.name, {"order", "effectivity", "consumption", "weight", "friction", "rotation_speed",
        "collision_box", "braking_power", "collision_mask", "tank_driving", "turret_animation",
        "turret_rotation_speed", "guns"})
end

-- programmable-warfare vehcile/units
-- add "no-aai" to an entity order string to disable AAI inclusion
-- a weight or consumtion of 0 will also exclude
local vehicles_to_process = {}
for _,vehicle in pairs(data.raw.car) do -- beware loop
    if (not string.find(vehicle.name, data_util.composite_suffix, 1, true))
    and (not string.find(vehicle.name, "nixie-tube", 1, true))
    and (not string.find(vehicle.order or "", "no-aai", 1, true)) then
        table.insert(vehicles_to_process, vehicle)
    end
end

for _,vehicle in pairs(vehicles_to_process) do
    make_composite_unit_from_vehicle(vehicle)
end


-- worms
for _, turret in pairs(data.raw.turret) do
  if string.find(turret.name, "worm", 1, true) then
    if turret.attack_parameters and turret.attack_parameters.range then
      turret.attack_parameters.range = (turret.attack_parameters.range + 5) * 1.25
      turret.attack_parameters.prepare_range = turret.attack_parameters.range + 5
    end
  end
end
