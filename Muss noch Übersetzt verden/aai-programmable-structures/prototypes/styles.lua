local ui_width = 200
data.raw["gui-style"]["default"]["aai_struct_settings_textfield_style"] = {
    minimal_width = 50,
    type = "textfield_style"
}
data.raw["gui-style"]["default"]["aai_struct_settings_label_style"] = {
    minimal_width = ui_width-50,
    maximal_width = ui_width-50,
    parent= "label_style",
    type = "label_style"
}
data.raw["gui-style"]["default"]["aai_struct_settings_fieldset_style"] = {
    minimal_width = ui_width-20,
    maximal_width = ui_width-20,
    type = "frame_style",
    parent = "frame_style"
}
data.raw["gui-style"]["default"]["aai_struct_settings_container_style"] = {
    minimal_width = ui_width,
    maximal_width = ui_width,
    type = "frame_style",
    parent = "frame_style"
}
data.raw["gui-style"]["default"]["aai_struct_settings_button_style"] = {
    type = "button_style",
    parent = "button_style"
}
