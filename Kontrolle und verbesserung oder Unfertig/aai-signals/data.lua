local signals_increment_current = 0;
local signals_increment_order = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","v","w","x","y","z","z-a", "z-b"}
function signals_increment()
  signals_increment_current = signals_increment_current + 1
  return "a-" .. signals_increment_order[signals_increment_current]
end
data:extend(
{
  {
    type = "item-subgroup",
    name = "virtual-signal-utility",
    group = "signals",
    order = "1",
  },
  {
    type = "virtual-signal",
    name = "signal-player",
    icon = "__aai-signals__/graphics/signal/signal-player.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-player-cursor",
    icon = "__aai-signals__/graphics/signal/signal-player-cursor.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-inventory-slot",
    icon = "__aai-signals__/graphics/signal/signal-inventory-slot.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-energy",
    icon = "__aai-signals__/graphics/signal/signal-energy.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-battery-percent",
    icon = "__aai-signals__/graphics/signal/signal-battery-percent.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-health",
    icon = "__aai-signals__/graphics/signal/signal-health.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-angle",
    icon = "__aai-signals__/graphics/signal/signal-angle.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-speed",
    icon = "__aai-signals__/graphics/signal/signal-speed.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-range",
    icon = "__aai-signals__/graphics/signal/signal-range.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-time-target",
    icon = "__aai-signals__/graphics/signal/signal-time-target.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-time-move",
    icon = "__aai-signals__/graphics/signal/signal-time-move.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-time-command",
    icon = "__aai-signals__/graphics/signal/signal-time-command.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-surface",
    icon = "__aai-signals__/graphics/signal/signal-surface.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-x-tile",
    icon = "__aai-signals__/graphics/signal/signal-x-tile.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-y-tile",
    icon = "__aai-signals__/graphics/signal/signal-y-tile.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-x-sub",
    icon = "__aai-signals__/graphics/signal/signal-x-sub.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-y-sub",
    icon = "__aai-signals__/graphics/signal/signal-y-sub.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-enemy-unit",
    icon = "__aai-signals__/graphics/signal/signal-enemy-unit.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-enemy-unit-spawner",
    icon = "__aai-signals__/graphics/signal/signal-enemy-unit-spawner.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-enemy-turret",
    icon = "__aai-signals__/graphics/signal/signal-enemy-turret.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-land",
    icon = "__aai-signals__/graphics/signal/signal-land.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-water",
    icon = "__aai-signals__/graphics/signal/signal-water.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-count",
    icon = "__aai-signals__/graphics/signal/signal-count.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-id",
    icon = "__aai-signals__/graphics/signal/signal-id.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-follow-id",
    icon = "__aai-signals__/graphics/signal/signal-follow-id.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-follow-player",
    icon = "__aai-signals__/graphics/signal/signal-follow-player.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
  {
    type = "virtual-signal",
    name = "signal-minimum-fuel",
    icon = "__aai-signals__/graphics/signal/signal-minimum-fuel.png",
    subgroup = "virtual-signal-utility",
    order = ""..signals_increment()
  },
})
