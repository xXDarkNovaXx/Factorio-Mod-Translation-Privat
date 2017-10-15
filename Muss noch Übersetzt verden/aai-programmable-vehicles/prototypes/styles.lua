data.raw["gui-style"]["default"]["units-scroll-pane"] =
{
    type = "scroll_pane_style",
    parent = "scroll_pane_style",
    vertical_scroll_bar_spacing = 5,
    maximal_height = 600
}

data.raw["gui-style"]["default"]["units-table"] =
{
    type = "table_style",
    cell_spacing = 1,
    horizontal_spacing = 1,
    vertical_spacing = 1,
    scalable = false
}
local label_padding_left = 1
local label_padding_top = 15

data.raw["gui-style"]["default"]["unit-button-label"] =
{
    type = "label_style",
    parent = "label_style",
    minimal_width = 36,
    top_padding = label_padding_top,
    right_padding = 1,
    bottom_padding = 1,
    left_padding = label_padding_left,
    scalable = false,
    scale = 0.5,
    align = "right",
    font = "default-semibold",
}
data.raw["gui-style"]["default"]["unit-button-label-black-t"] =
{
    type = "label_style",
    parent = "label_style",
    minimal_width = 36,
    top_padding = label_padding_top-1,
    right_padding = 1,
    bottom_padding = 2,
    left_padding = label_padding_left,
    scalable = false,
    scale = 0.5,
    align = "right",
    font_color = {
      b = 0,
      g = 0,
      r = 0
    },
    font = "default-semibold",
}
data.raw["gui-style"]["default"]["unit-button-label-black-b"] =
{
    type = "label_style",
    parent = "label_style",
    minimal_width = 36,
    top_padding = label_padding_top+1,
    right_padding = 1,
    bottom_padding = 0,
    left_padding = label_padding_left,
    scalable = false,
    scale = 0.5,
    align = "right",
    font_color = {
      b = 0,
      g = 0,
      r = 0
    },
    font = "default-semibold",
}
data.raw["gui-style"]["default"]["unit-button-label-black-l"] =
{
    type = "label_style",
    parent = "label_style",
    minimal_width = 36,
    top_padding = label_padding_top,
    right_padding = 2,
    bottom_padding = 1,
    left_padding = label_padding_left-1,
    scalable = false,
    scale = 0.5,
    align = "right",
    font_color = {
      b = 0,
      g = 0,
      r = 0
    },
    font = "default-semibold",
}
data.raw["gui-style"]["default"]["unit-button-label-black-r"] =
{
    type = "label_style",
    parent = "label_style",
    minimal_width = 36,
    top_padding = label_padding_top,
    right_padding = 0,
    bottom_padding = 1,
    left_padding = label_padding_left+1,
    scalable = false,
    scale = 0.5,
    align = "right",
    font_color = {
      b = 0,
      g = 0,
      r = 0
    },
    font = "default-semibold",
}

data.raw["gui-style"]["default"]["unit-button-fixed"] =
{
    type = "button_style",
    parent = "button_style",
    minimal_width = 40,
    minimal_height = 40,
    top_padding = 0,
    right_padding = 0,
    bottom_padding = 0,
    left_padding = 0,
    scalable = false,
}
data.raw["gui-style"]["default"]["unit-button"] =
{
    type = "button_style",
    parent = "button_style",
    minimal_width = 32,
    minimal_height = 32,
    top_padding = 0,
    right_padding = 0,
    bottom_padding = 0,
    left_padding = 0,
    scalable = false
}
data.raw["gui-style"]["default"]["unit-button-active"] =
{
    type = "button_style",
    parent = "button_style",
    minimal_width = 32,
    minimal_height = 32,
    top_padding = 0,
    right_padding = 0,
    bottom_padding = 0,
    left_padding = 0,
    scalable = false,
    default_graphical_set =
    {
        type = "composition",
        filename = "__core__/graphics/gui.png",
        priority = "extra-high-no-scale",
        corner_size = {3, 3},
        position = {0, 16}
        --position = {0, 8}
    },
    hovered_graphical_set =
    {
        type = "composition",
        filename = "__core__/graphics/gui.png",
        priority = "extra-high-no-scale",
        corner_size = {3, 3},
        position = {0, 16}
    },
}
