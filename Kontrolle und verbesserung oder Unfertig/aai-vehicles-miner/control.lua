require("stdlib/table")
require("stdlib/string")

--local miner_variants = require("miner-variants")
local util = require("util")
--local Position = require("stdlib/area.position")
local high_fuel_item = "rocket-fuel"
local fuel, trunk = defines.inventory.fuel, defines.inventory.car_trunk
local inv_nums = {fuel, trunk}
local min_speed = 0.001

-- run mining 2 times per second
local tick_skip = 30

-- in-game miners are over suppsedt to be 10
local fluid_efficiency = 10

-------------------------------------------------------------------------------
--[[HELPERS]]--
-------------------------------------------------------------------------------

local get_fuel = {
    --Build a table of fuel items, index as fuel name, value as table with name, fuel_value
    build = function()
        return table.map(game.item_prototypes,
            function(item, name)
                local fuel_item = {}
                if item.fuel_value and item.fuel_value > 0 then
                    fuel_item.fuel_value = item.fuel_value
                    fuel_item.name = name
                end
                --Return: index as item_name, value as fuel_value
                return fuel_item.name and fuel_item or nil
            end
        )
    end,

    --Return a fuel item table if a fuel item is in the contents.
    item = function(contents)
        local fuel_items = global.fuel_items
        for name in pairs(contents) do
            if fuel_items[name] then
                return fuel_items[name]
            end
        end
    end
}

local miners = {
    --global refrence to all saved miners, set in on_load and on_init
    miners = {},

    --variant types of miners, TODO in future move to sub-objects
    variants = require("miner-variants"),

    --metamethods for miners.miners
    mt = {
        --miners[number] will return miners.miners[number]
        __index = function(tab, key)
            return type(key) == "number" and tab.miners[key]
        end,
        --__newindex: miners[number] = value store in miners.miners[number]
        __newindex = function(tab, key, value)
            if type(key) == "number" then
                tab.miners[key] = value
            else
                rawset(tab, key, value)
            end
        end
    }
}
setmetatable(miners, miners.mt)

function miners:new(entity)
    if entity.valid and self.variants[entity.name] then
        local miner = {
            unit_number = entity.unit_number,
            entity = entity,
            name = entity.name
        }
        -- starting energy to collect a tree
        miner.entity.burner.currently_burning = high_fuel_item
        miner.entity.burner.remaining_burning_fuel = game.item_prototypes[high_fuel_item].fuel_value * 0.001
        --metatables are not saved to global. Iterate and re-assign in on_load
        setmetatable(miner, {__index = miners})
        self[entity.unit_number] = miner
        return miner
    end
end

--Replace and rekey the miner entity
function miners.replace(event)
    if miners[event.old_entity_unit_number] then
        local miner = table.deepcopy(miners[event.old_entity_unit_number])
        miner.entity = event.new_entity
        miner.unit_number = event.new_entity_unit_number
        miners[event.new_entity_unit_number] = miner
        miners[event.old_entity_unit_number] = nil
    end
end

--Destroy attachments, then destroy miner record
function miners:die()
    if not self.entity.valid then
        self.miners[self.unit_number] = nil
        self = nil
    end
    return not self
end


local function get_fluid_stack_from_product(product)
    -- it's ok to have fractional fluid amounts so treat probability as averages
    -- predictability is good to ensure that there will be enough fluid to mine an item
    local amount = 0
    if product.probability and product.probability < 1 then
        amount = product.probability
    elseif product.amount then
        amount = product.amount
    elseif product.amount_max then
        amount = ((product.amount_min or 0) + product.amount_max) / 2
    end
    return {
        type = "fluid",
        name = product.name,
        amount = amount
    }
end

local function get_item_stack_from_product(product)
    local probability = not product.probability or (product.probability and math.random() < product.probability)
    return {
        name = product.name,
        count = probability and (product.amount or math.random(product.amount_min, product.amount_max)) or 0
    }
end

-- get the amount of fluid available from lua storage and barrels
local function get_fluid_available_lua(miner, fluid_name)
    -- lua storage
    if miner.fluids and miner.fluids[fluid_name] then
        return miner.fluids[fluid_name].amount
    end
    return 0
end

-- get the amount of fluid available from lua storage and barrels
local function get_fluid_available_items(miner, fluid_name)
    local available = 0
    -- get barrel empty recipe to see what the yield is per barrel
    local recipe = game.recipe_prototypes["empty-" .. fluid_name .. "-barrel"]
    if recipe then
        -- got the recipe
        if #recipe.ingredients == 1 then
            -- only simple recipes for now
            local inv = miner.entity.get_inventory(defines.inventory.car_trunk)
            local inv_items = inv.get_item_count(recipe.ingredients[1].name)
            local completable_recipes = math.floor(inv_items / recipe.ingredients[1].amount)
            if completable_recipes > 0 then
                for _, product in pairs(recipe.products) do
                    if product.type == "fluid" and product.name == fluid_name then
                        local yield_per_recipe = get_fluid_stack_from_product(product).amount
                        available = available + yield_per_recipe * completable_recipes
                    end
                end
            end
        end
    end
    return available
end

-- get the amount of fluid available from lua storage and barrels
local function is_fluid_available(miner, fluid_name, min_amount)
    local available = 0

    available = available + get_fluid_available_lua(miner, fluid_name)
    if available >= min_amount then return true end

    available = available + get_fluid_available_items(miner, fluid_name)
    if available >= min_amount then return true end
    return false

end

-- get the amount of fluid available from lua storage and barrels
local function get_fluid_available(miner, fluid_name)

    return get_fluid_available_lua(miner, fluid_name) + get_fluid_available_items(miner, fluid_name)

end

-- consume fluid only from lua, return amount consumed
local function consume_fluid_lua(miner, fluid_name, fluid_amount)
    if miner.fluids and miner.fluids[fluid_name] then
        local consume_lua = math.min(fluid_amount, miner.fluids[fluid_name].amount)
        miner.fluids[fluid_name].amount = miner.fluids[fluid_name].amount - consume_lua
        return consume_lua
    end
    return 0
end

local function insert_fluid(miner, fluid_stack)

    -- fluid stack is like item stack: name, amount... could support emperature in the future
    miner.fluids = miner.fluids or {}
    miner.fluids[fluid_stack.name] = miner.fluids[fluid_stack.name] or {}
    miner.fluids[fluid_stack.name].name = fluid_stack.name
    miner.fluids[fluid_stack.name].amount = (miner.fluids[fluid_stack.name].amount or 0) + fluid_stack.amount

    return miner
end

local function insert_products(miner, products, multiplier)
    --go through products and process
    if not products then return end
    for _, product in pairs(products) do
        if product.type == "fluid" then
            -- fluid stack can be multiplied because random has been averaged
            local fluid_stack = get_fluid_stack_from_product(product)
            fluid_stack.amount = fluid_stack.amount * multiplier
            insert_fluid(miner, get_fluid_stack_from_product(product))
        elseif product.type == "item" then
            for _ = 1, multiplier, 1 do
                -- run the recipe multiple times, don't multiply becusae of random item yields
                local stack = get_item_stack_from_product(product)
                if stack.count > 0 then
                    miner.entity.insert(stack)
                end
            end
        end
    end
end

-- get the amount of fluid available from lua storage and barrels
local function consume_fluid(miner, fluid_name, fluid_amount)
    local consume_remaining = fluid_amount

    consume_remaining = consume_remaining - consume_fluid_lua(miner, fluid_name, consume_remaining)
    if consume_remaining <= 0 then return miner end

    -- consume from items
    -- fluids feeds directly into lua storage for 2nd consume_fluid_lua call
    local recipe = game.recipe_prototypes["empty-" .. fluid_name .. "-barrel"]
    if recipe then
        -- got the recipe
        if #recipe.ingredients == 1 then
            -- only simple recipes for now
            local inv = miner.entity.get_inventory(defines.inventory.car_trunk)
            if inv.get_item_count(recipe.ingredients[1].name) >= recipe.ingredients[1].amount then
                -- consume items
                local yield_per_recipe = 0
                --go through products for yield
                for _, product in pairs(recipe.products) do
                    if product.type == "fluid" and product.name == fluid_name then
                        yield_per_recipe = yield_per_recipe + get_fluid_stack_from_product(product).amount
                    end
                end

                local recipes_to_complete = math.ceil(consume_remaining / yield_per_recipe)
                inv.remove({name=recipe.ingredients[1].name, amount=recipe.ingredients[1].amount * recipes_to_complete})

                --go through products and process
                insert_products(miner, recipe.products, recipes_to_complete)
            end
        end
    end

    consume_fluid_lua(miner, fluid_name, consume_remaining)

    return miner
end


local function mining_particles(miner, particle_name, multiplier)
    if particle_name then
        local forward = util.orientation_to_vector(miner.entity.orientation, 1)
        for _ = 1, (multiplier or 1), 1 do
            local height = math.random()
            local fm = 0.9 + math.random() * 0.1
            miner.entity.surface.create_entity{
                name = particle_name,
                position = util.vectors_add(miner.entity.position, {x = (math.random() - 0.5) * 0.75 + fm * forward.x * 3, y = (math.random() - 0.5) * 0.75 +fm * forward.y * 3}),
                source = miner.entity,
                speed = 0.1,
                movement = {(math.random() - 0.5)*0.15 + forward.x / 20, (math.random() - 0.5)*0.15 + forward.y / 20},
                frame_speed = 1,
                vertical_speed = height*0.1,
                height = height*0.1
            } -- needs more testing
        end
    end
end

local function barrel_fluids(miner)
    if miner.fluids then
        local inv = miner.entity.get_inventory(defines.inventory.car_trunk)
        for _, fluid in pairs(miner.fluids) do
            local recipe = game.recipe_prototypes["fill-" .. fluid.name .. "-barrel"]
            if recipe and #recipe.ingredients == 2 then
                -- no complicated recipes for now, just fluid + barrel
                if recipe.ingredients[1].type == "item" and recipe.ingredients[2].type == "fluid" and recipe.ingredients[2].name == fluid.name and fluid.amount >= recipe.ingredients[2].amount then
                    local item_count = inv.get_item_count(recipe.ingredients[1].name)
                    if item_count >= recipe.ingredients[1].amount then
                        local max_cycles = math.floor(math.min(fluid.amount / recipe.ingredients[2].amount, item_count / recipe.ingredients[1].amount))
                        if max_cycles > 0 then
                            fluid.amount = fluid.amount - max_cycles * recipe.ingredients[2].amount
                            inv.remove({name = recipe.ingredients[1].name, count=recipe.ingredients[1].amount * max_cycles})
                            insert_products(miner, recipe.products, max_cycles)
                        end
                    end
                end
            end
        end
    end
end

local function mine_resource(miner, resource, required_fluid)
    -- required fluid is {name=fluid_name, per_cycle=fluid_per_cycle} or nil
    local variant = miner.variants[miner.name]
    local proto = resource.prototype
    local def = remote.call("data-raw", "prototype", "resource", resource.name)

    -- TODO factor in modules
    -- TODO factor in productivity research
    local mining_speed = variant.mining_speed
    local mining_power = variant.mining_power

    -- (Mining power - Mining hardness) * Mining speed / Mining time = Production rate (in resource/sec)
    local mining_rate_per_sec = (mining_power - proto.mineable_properties.hardness ) * mining_speed / (proto.mineable_properties.miningtime or 1)
    if def.normal and def.normal > 0 then
        -- normal on a resource should mean that the output is at 100% at normal amount
        -- if the amount is different the the yield is different
        mining_rate_per_sec = mining_rate_per_sec * resource.amount / def.normal
    end
    miner.mining_progress = (miner.mining_progress or 0) + mining_rate_per_sec / 60 * tick_skip

    -- consume energy
    miner.entity.burner.remaining_burning_fuel = miner.entity.burner.remaining_burning_fuel - variant.mining_energy_use / 60 * tick_skip

    -- add pollution
    miner.entity.surface.pollute(miner.entity.position, variant.mining_pollution * tick_skip)

    mining_particles(miner, proto.mineable_properties.miningparticle, 1)
    -- mining results:
    -- can't exceed fluid limit
    if miner.mining_progress >= 1 then
        local complete_cycles = math.floor(miner.mining_progress)
        if required_fluid then
            local required_fluid_available = get_fluid_available(miner, required_fluid.name)
            complete_cycles = math.min(complete_cycles, math.floor(required_fluid_available / required_fluid.per_cycle))
        end
        -- productivity
        miner.mining_bonus = (miner.mining_bonus or 0) + complete_cycles * (miner.entity.force.mining_drill_productivity_bonus or 0)
        miner.mining_progress = miner.mining_progress - complete_cycles


        if required_fluid then
            consume_fluid(miner, required_fluid.name, required_fluid.per_cycle * complete_cycles)
        end
        -- insert the products
        insert_products(miner, proto.mineable_properties.products, complete_cycles)
        if miner.mining_bonus >= 1 then
          insert_products(miner, proto.mineable_properties.products, math.floor(miner.mining_bonus))
          miner.mining_bonus = miner.mining_bonus -  math.floor(miner.mining_bonus)
        end

        -- barrel up fluids if possible
        barrel_fluids(miner)

        -- reduce resource amount
        -- TODO check if resource amount should drop by more than 1 per cycle if the products yield more than 1 item count
        local amount_remaining = resource.amount - complete_cycles
        if proto.minimum_resource_amount and proto.minimum_resource_amount > 0 then
            amount_remaining = math.max(amount_remaining, proto.minimum_resource_amount)
        end
        if def.infinite_depletion_amount and def.infinite_depletion_amount > 0 then
            amount_remaining = math.max(amount_remaining, (resource.initial_amount or 0) * def.infinite_depletion_amount / 100)
        end
        if amount_remaining > 0 then
            resource.amount = amount_remaining
        else
            resource.amount = 1
            script.raise_event(defines.events.on_resource_depleted, {entity = resource})
            resource.destroy()
        end
    end

    return miner
end

local function mine_area(miner)

    if (game.tick + miner.entity.unit_number) % tick_skip == 0 then
        local variant = miner.variants[miner.name]
        local area = {
            {miner.entity.position.x - variant.mining_range, miner.entity.position.y - variant.mining_range},
            {miner.entity.position.x + variant.mining_range, miner.entity.position.y + variant.mining_range}
        }
        local resources = miner.entity.surface.find_entities_filtered{type = "resource", area = area}

        table.sort(
            resources,
            function(a,b)
                -- choose basic-solid over basic-fluid
                if a.prototype.resource_category ~= b.prototype.resource_category then return a.prototype.resource_category > b.prototype.resource_category end
                -- choose higher amount
                return a.amount > b.amount
            end
        )
        -- mine higher value resource chunks first, more effective if only a small portion of tiles are scanned
        for _, resource in ipairs(resources) do
            if resource.minable then
                local proto = resource.prototype
                if proto.mineable_properties then
                    local def = remote.call("data-raw", "prototype", "resource", resource.name)

                    if def.minable and def.minable.required_fluid and def.minable.fluid_amount > 0 then
                        -- fluid is required
                        local fluid_name = def.minable.required_fluid
                        local fluid_per_cycle = def.minable.fluid_amount / fluid_efficiency
                        if is_fluid_available(miner, fluid_name, fluid_per_cycle) then
                            -- there is enough fluid for at least 1 cycle
                            -- this can be mined
                            mine_resource(miner, resource, {name=fluid_name, per_cycle=fluid_per_cycle})
                            break
                        --else -- can't mine becuase of fluid requirement, move on to next resource
                        end
                    else
                        -- fluid is not required
                        -- this can be mined
                        mine_resource(miner, resource, nil)
                        break
                    end
                end
            end
        end
    end

    return miner
end




--[[
The mining attachment is supposed to pull energy from vehicle
but if a vehicle is stationary it won't consume fuel even if it's energy is 0.
Instead, pull a burnable item from the vehicle's inventory and add it to a lua energy buffer.
feed the enrgy buffer into the attachment.
]]--

--Consume fuel from a list of fuels generated on init and changed

local function consume_fuel_or_equipment(miner)
    if miner.entity.grid and miner.entity.grid.available_in_batteries > 10000 then
        --Added by Undarl; basic battery fueling logic courtesy of Sirenfal
        ---Modified by the Nexela
        miner.entity.burner.currently_burning = high_fuel_item
        local energy_deficit = game.item_prototypes[high_fuel_item].fuel_value - miner.entity.burner.remaining_burning_fuel --use initial energy value as baseline
        local batteries = table.filter(miner.entity.grid.equipment, function(v) return v.type == "battery-equipment" end)
        local num_batteries = #batteries
        while num_batteries > 0 and energy_deficit > 0 do
            local battery = batteries[num_batteries]
            local energy_used = energy_deficit - math.max(battery.energy, energy_deficit)
            battery.energy = battery.energy - energy_used
            miner.entity.burner.remaining_burning_fuel = miner.entity.burner.remaining_burning_fuel + energy_used
            energy_deficit = energy_deficit - energy_used
            num_batteries = num_batteries - 1
        end
    else
        for _, inv_num in pairs(inv_nums) do
            local inventory = miner.entity.get_inventory(inv_num)
            if inventory then
                local fuel_item = get_fuel.item(inventory.get_contents())
                if fuel_item then
                    miner.entity.burner.currently_burning = fuel_item.name
                    miner.entity.burner.remaining_burning_fuel = miner.entity.burner.remaining_burning_fuel + fuel_item.fuel_value
                    inventory.remove({name=fuel_item.name, count=1})
                    return true
                end
            end
        end
    end
end

local function smoke_particles(miner)
    -- smoke
    if (game.tick + miner.entity.unit_number) % 10 == 0 then
        local forward = util.orientation_to_vector(miner.entity.orientation, 1)
        miner.entity.surface.create_entity{
            name = "smoke",
            position = util.vectors_add(miner.entity.position, util.vectors_add({x=0, y=-0.8}, {x= forward.x * 0.05, y=forward.y * 0.05})),
            source = miner.entity,
            speed = 0.1,
            movement = {((math.random(100)/100) - 0.5)*0.1, ((math.random(100)/100) - 0.5)*0.1},
            frame_speed = 1,
            vertical_speed = 0.1,
            height = 0.1
        } -- needs more testing
        return true
    end
end

local function collect_floor_items(miner)
    if game.tick % 30 == 0 or miner.entity.burner.remaining_burning_fuel < 10 then
        local area = {
            {miner.entity.position.x - 2.5, miner.entity.position.y - 2.5},
            {miner.entity.position.x + 2.5, miner.entity.position.y + 2.5}
        }
        for _, item_entity in pairs(miner.entity.surface.find_entities_filtered{name = "item-on-ground", area = area}) do
            local hoovered = {name=item_entity.stack.name, count=item_entity.stack.count}
            item_entity.stack.count = item_entity.stack.count - miner.entity.insert(hoovered)
        end

        -- collect trees, rocks, and other shit needing collecting, set in the filter!
        local _filter = function(ent)
            return (ent.type == "tree" or ent.name == "stone-rock") and ent.health < 10000
        end

        local fm = (game.tick % 12 == 0) and 1.5 or 0
        local forward = util.orientation_to_vector(miner.entity.orientation, fm)
        local range = miner.variants[miner.name].tree_range

        local tree_area={
            {forward.x + miner.entity.position.x - range, forward.y + miner.entity.position.y - range},
            {forward.x + miner.entity.position.x + range, forward.y + miner.entity.position.y + range}
        }

        for _, ent in pairs(table.filter(miner.entity.surface.find_entities(tree_area), _filter)) do
            for _, product in pairs(ent.prototype.mineable_properties.products) do
                local item = get_item_stack_from_product(product)
                if item.count > 0 then
                    item.count = item.count - miner.entity.insert(item)
                end
            end
            --TODO check for corpse spawning/death sounds etc just in case
            if ent.prototype.loot then ent.destroy() else ent.die() end
        end
    end
end


--local function on_tick(event)
local function on_tick()

    for _, miner in pairs(miners.miners) do
        if miner.entity.valid then

            if (not miner.entity.burner.currently_burning) or (miner.entity.burner.remaining_burning_fuel < miner.entity.burner.currently_burning.fuel_value * 0.02 + 1) then
                consume_fuel_or_equipment(miner)
            end

            if miner.entity.burner.remaining_burning_fuel > 0 then
                local can_insert = miner.entity.can_insert("rocket-part")
                --if not Position.equals(miner.entity.position, miner.last_position) or can_insert then

                -- force animation
                if can_insert and miner.entity.speed < min_speed and miner.entity.speed > -min_speed and not miner.entity.passenger then
                    miner.entity.speed = math.random() < 0.5 and min_speed or -min_speed
                end
                miner.last_position = miner.entity.position

                if can_insert then
                    mine_area(miner)
                    collect_floor_items(miner)
                    smoke_particles(miner)
                end

            end
        else -- not miner.entity.valid
            miner:die()
        end

    end
end

-------------------------------------------------------------------------------
--[[PLAYER]]--
-------------------------------------------------------------------------------
--player object as optional, when not present loop through all players
--insert could still fail to insert because of a full inventory, but at this point the player should have
--enough raw resources to make them
local function player_insert_items(event)
  if settings.startup["start-with-vehicle-miner"] and settings.startup["start-with-vehicle-miner"].value == true then
    local player = event and game.players[event.player_index]
    if player then
        player.insert{name="vehicle-miner", count = 1}
    else
        for _, p in pairs(game.players) do
            p.insert{name="vehicle-miner", count = 1}
        end
    end
  end
end

-------------------------------------------------------------------------------
--[[EVENTS]]--
-------------------------------------------------------------------------------
script.on_event(defines.events.on_player_created, player_insert_items)
script.on_event(defines.events.on_tick, on_tick)
script.on_event(defines.events.on_built_entity, function(event) miners:new(event.created_entity) end)
script.on_event(defines.events.on_preplayer_mined_item, function(event) if miners[event.entity.unit_number] then miners[event.entity.unit_number]:die() end end)

-------------------------------------------------------------------------------
--[[INIT]]--
-------------------------------------------------------------------------------
local function on_load()
    miners.miners = global.miners
    for _, miner in pairs(miners.miners) do
        setmetatable(miner, {__index = miners})
    end
end
script.on_load(on_load)

local function on_configuration_changed()
    --migrate unit_numbers
    for _, miner in pairs(miners.miners) do
        if not miner.unit_number and miner.entity and miner.entity.valid then
            miner.unit_number = miner.entity.unit_number
        end
        miner.attachments = nil
        miner.attachment_idles = nil
    end

    --update fuel items every change
    global.fuel_items = get_fuel.build()
end
script.on_configuration_changed(on_configuration_changed)

local function on_init()
    global.miners = global.miners or {}
    miners.miners = global.miners
    global.fuel_items = get_fuel.build()
    player_insert_items()
end
script.on_init(on_init)

-------------------------------------------------------------------------------
--[[REMOTE]]--
-------------------------------------------------------------------------------
local function write_global()
    game.write_file("AAI/miner.global.lua", serpent.dump(global, {comment=false, sparse=true, indent = "\t", nocode=true, name="global"}), false)
    game.write_file("AAI/miner.miners.lua", serpent.dump(miners, {comment=false, sparse=true, indent = "\t", nocode=true, name="miners"}), false)
    game.write_file("AAI/miner._ENV.lua", serpent.block(_ENV, {comment=false, sparse=true, indent = "\t", nocode=true}), false)
end

remote.add_interface(
    "aai-vehicles-miner",
    {
        -- sent by aai-programmable-structures
        on_entity_deployed = function(event) miners:new(event.entity) end,
        -- sent by aai-programmable-vehicles -- replaced by equivalent
        on_entity_replaced = function(event) miners.replace(event) end,
        write_global = write_global
    }
)
