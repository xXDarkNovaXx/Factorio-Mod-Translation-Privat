local zone_data = require("zones")

--Stolen from util since that is all that is used!
local function remove_from_table(list, item)
    local index = 0
    for _,_item in ipairs(list) do
        if item == _item then
            index = _
            break
        end
    end
    if index > 0 then
        table.remove(list, index)
    end
end

local function xy_to_string(x, y)
    return math.floor(x or 0) .. "_" .. math.floor(y or 0)
end
--
-- local function position_to_xy_string(position)
-- return xy_to_string(position.x or position[1], position.y or position[2])
-- end

local function zone_count_of_type(data)
    --zone_force_update()
    local force = data.force
    local zone_name = data.type
    if global.forces[force.name].zones_by_type[zone_name] then
        return #global.forces[force.name].zones_by_type[zone_name]
    end
    return 0
end

local function zone_for_xy(force, x, y)
    --zone_force_update()
    local xy_string = xy_to_string(x,y)
    if global.forces[force.name].zones[xy_string] then
        return global.forces[force.name].zones[xy_string].type
    end
end

local function get_zone_for_position(data)
    return zone_for_xy(data.force, data.position.x, data.position.y)
end

local function get_zonedata_for_position(data)
    if not (data.force and data.position) then return end
    local xy_string = xy_to_string(data.position.x, data.position.y)
    local zone_type = zone_for_xy(data.force, data.position.x, data.position.y)
    if zone_type then
        for i, try_xy_string in pairs(global.forces[data.force.name].zones_by_type[zone_type]) do
            if try_xy_string == xy_string then
                return {name=zone_type, index=i}
            end
        end
    end
end

local function zone_get_player_selection(player_index)
    if not global.player_zone_selection then global.player_zone_selection = {} end
    local selection
    if global.player_zone_selection[player_index]
    and global.player_zone_selection[player_index].colour
    and global.player_zone_selection[player_index].pattern then
        selection = global.player_zone_selection[player_index]
    else
        selection = {pattern = zone_data.zone_patterns[1], colour = zone_data.zone_colours[1]}
    end
    selection.zone = "zone-"..selection.pattern.."-"..selection.colour
    return selection
end

local function zone_set_player_selection(player_index, pattern, colour)
    local selection = zone_get_player_selection(player_index)
    if pattern then selection.pattern = pattern end
    if colour then selection.colour = colour end
    global.player_zone_selection[player_index] = selection
end

local function zone_gui_rebuild(player)

    local selection = zone_get_player_selection(player.index)
    local frame = player.gui.left.zone

    for _, child_name in pairs(frame.zone_colour_table.children_names) do
        frame.zone_colour_table[child_name].destroy()
    end
    for _, child_name in pairs(frame.zone_pattern_table.children_names) do
        frame.zone_pattern_table[child_name].destroy()
    end

    for _, colour in ipairs(zone_data.zone_colours) do
        frame.zone_colour_table.add{
            type = "sprite-button",
            name = colour,
            sprite="virtual-signal/".."zone-"..selection.pattern.."-"..colour,
            tooltip = colour,
            style= colour == selection.colour and "zone-button-active" or "zone-button"}
    end

    for _, pattern in ipairs(zone_data.zone_patterns) do
        frame.zone_pattern_table.add{
            type = "sprite-button",
            name = pattern,
            sprite="virtual-signal/".."zone-"..pattern.."-"..selection.colour,
            tooltip = pattern,
            style= pattern == selection.pattern and "zone-button-active" or "zone-button"}
    end
end

local function zone_show_gui(player)
    --zone_force_update()
    if player.gui.left.zone == nil then
        local zone_frame = player.gui.left.add{type = "frame", name = "zone", caption = {"text-zone-planner"}, direction = "vertical"}

        --zone_colour_table
        zone_frame.add{type ="table", name = "zone_colour_table", colspan = 6, style = "zones-table"}
        zone_frame.add{type ="table", name = "zone_pattern_table", colspan = 6, style = "zones-table"}

        zone_gui_rebuild(player)

        zone_frame.add{type ="label", name = "zones_alt_tip", caption = {"text-zone-planner-alt"}}
    end
end

local function zone_hide_gui(player)
    if player.gui.left.zone ~= nil then
        player.gui.left.zone.destroy()
    end
end

local function zone_on_player_cursor_stack_changed(event)
    local player = game.players[event.player_index]
    if player.cursor_stack and player.cursor_stack.valid and player.cursor_stack.valid_for_read then
        if player.cursor_stack.name == "zone-planner" then
            zone_show_gui(player)
        else
            zone_hide_gui(player)
        end
    else
        zone_hide_gui(player)
    end
end

local function zone_on_gui_click(event)
    local player_index = event.player_index
    local player = game.players[player_index];
    if game.players[player_index].gui.left.zone ~= nil and event.element.parent then -- avoid looping if menu is closed
        if event.element.parent.name == "zone_colour_table" then
            zone_set_player_selection(player_index, nil, event.element.name)
            zone_gui_rebuild(player)
        elseif event.element.parent.name == "zone_pattern_table" then
            zone_set_player_selection(player_index, event.element.name, nil)
            zone_gui_rebuild(player)
        end
    end
end

local function zone_apply_to_area(data)
    local surface = data.surface
    local force = data.force
    local area = data.area
    local zone_name = data.type

    if surface and force and area then
        -- if zone_name is nil the action will be remove only
        --zone_force_update()

        local minX = math.floor(area.left_top.x);
        local maxX = math.floor(area.right_bottom.x);
        if maxX - minX <= 0 then
            maxX = minX
        end
        local minY = math.floor(area.left_top.y);
        local maxY = math.floor(area.right_bottom.y);
        if maxY - minY <= 0 then
            maxY = minY
        end

        for y = minY, maxY, 1 do
            for x = minX, maxX, 1 do
                local xy_string = xy_to_string(x, y)
                if global.forces[force.name].zones[xy_string] then
                    local zone = global.forces[force.name].zones[xy_string]
                    if global.forces[force.name].zones_by_type[zone.type] then
                        remove_from_table(global.forces[force.name].zones_by_type[zone.type], xy_string)
                    end
                    if zone.entity.valid then
                        zone.entity.destroy()
                    end
                    global.forces[force.name].zones[xy_string] = nil
                end
            end
        end

        if zone_name then
            for y = minY, maxY, 1 do
                for x = minX, maxX, 1 do
                    local xy_string = xy_to_string(x, y)
                    local newzone = surface.create_entity{name = zone_name, position={x+0.5,y+0.5}, force = force}
                    global.forces[force.name].zones[xy_string] = {
                        type = zone_name,
                        position = newzone.position,
                        entity = newzone, -- may get removed by concrete but the zone will still work without the entity
                    }
                    if not global.forces[force.name].zones_by_type[zone_name] then
                        global.forces[force.name].zones_by_type[zone_name] = {}
                    end
                    table.insert(global.forces[force.name].zones_by_type[zone_name], xy_string)
                end
            end
        end
    end
end

local function zone_by_type_and_index(force, zone_type, index)
    --zone_force_update()
    if global.forces[force.name].zones_by_type[zone_type] and #global.forces[force.name].zones_by_type[zone_type] > 0 then
        local xy_string
        local real_index = nil
        if index > 0 and index <= #global.forces[force.name].zones_by_type[zone_type] then
            real_index = index
        elseif index < 0 and -index <= #global.forces[force.name].zones_by_type[zone_type] then
            real_index = #global.forces[force.name].zones_by_type[zone_type] + index + 1
        end
        xy_string = global.forces[force.name].zones_by_type[zone_type][real_index]
        if xy_string and global.forces[force.name].zones[xy_string] then
            local zone = global.forces[force.name].zones[xy_string]
            return {type = zone.type,
                position = zone.position,
                entity = zone.entity,
                index = real_index}

        end
    end
end

local function zone_player_selected_area(event)
    if (event.item == "zone-planner") then
        local alt = event.name == defines.events.on_player_alt_selected_area
        --local player = game.players[event.player_index];
        --zone_force_update()
        local zone_name = nil
        if not alt then
            zone_name = zone_get_player_selection(event.player_index).zone
        end
        zone_apply_to_area{
            surface = game.players[event.player_index].surface,
            force = game.players[event.player_index].force,
            area = event.area,
            type = zone_name
        }
    end
end

script.on_event(defines.events.on_player_selected_area, zone_player_selected_area)
script.on_event(defines.events.on_player_alt_selected_area, zone_player_selected_area)
script.on_event(defines.events.on_gui_click, zone_on_gui_click)
script.on_event(defines.events.on_player_cursor_stack_changed, zone_on_player_cursor_stack_changed)

-------------------------------------------------------------------------------
--[[INIT]]--
-------------------------------------------------------------------------------
local function on_init()
    global.forces = global.forces or {}

    for _, force in pairs(game.forces) do
        global.forces[force.name] = global.forces[force.name] or {}
        global.forces[force.name].zones = global.forces[force.name].zones or {} -- by x_y string. each element is {type = name, position = position, entity = zone}
        global.forces[force.name].zones_by_type = global.forces[force.name].zones_by_type or {} -- {zone-diagonal-blue = {"x_y_string", "x_y_string"}}
        for _, zone in ipairs(zone_data.zones) do
            global.forces[force.name].zones_by_type[zone.name] = global.forces[force.name].zones_by_type[zone.name] or {} -- by indexed as x_y string
        end
    end

    global.player_zone_selection = global.player_zone_selection or {} -- just the zone name
end
script.on_init(on_init)
script.on_configuration_changed(on_init)
script.on_event(defines.events.on_force_created, on_init)

-------------------------------------------------------------------------------
--[[REMOTE]]--
-------------------------------------------------------------------------------
remote.add_interface("aai-zones", {
        get_zone_types = function() return zone_data.zones end,
        is_zone_type = function(zone_type) return zone_data.zones_by_name[zone_type] ~= nil end,
        apply_zone_to_area = zone_apply_to_area,
        get_zonedata_for_position = get_zonedata_for_position, -- data.force, data.position, Returns: {name=zone_type, index=zone_tile_index}
        get_zone_for_position = get_zone_for_position, -- data.force, data.position, Returns: zone_type string
        get_zone_count_of_type = zone_count_of_type, -- data.force, data.type
        get_zone_by_index = function (data) return zone_by_type_and_index(data.force, data.type, data.index) end,-- data.force, data.type, data.index
        write_global = function() game.write_file("AAI/zones.global.lua", serpent.block(global, {comment=false, sparse=true, nocode=true}), false) end,
    }
)
