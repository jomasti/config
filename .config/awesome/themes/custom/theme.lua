-- {{{ Main
theme = {}
--theme.wallpaper_cmd = {}
-- }}}

-- {{{ Styles
theme.font      = "droid sans 8"

-- {{{ Colors
theme.fg_normal = "#757575"
theme.fg_focus  = "#93d44f"
theme.fg_urgent = "#929392"
theme.bg_normal = "#181818"
theme.bg_focus  = "#181818"
theme.bg_urgent = "#34353488"
-- }}}

-- {{{ Borders
theme.border_width  = "0"
theme.border_focus = "#2d41a3"
theme.border_normal = "#7273a2"
theme.border_marked = "#CC9393"
-- }}}

-- {{{ Titlebars
theme.titlebar_bg_focus  = "#181818"
theme.titlebar_bg_normal = "#181818"
-- }}}

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- Example:
--theme.taglist_bg_focus = "#CC9393"
-- }}}

-- {{{ Widgets
-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.fg_widget        = "#AECF96"
--theme.fg_center_widget = "#88A175"
--theme.fg_end_widget    = "#FF5656"
--theme.bg_widget        = "#494B4F"
--theme.border_widget    = "#3F3F3F"
-- }}}

-- {{{ Mouse finder
theme.mouse_finder_color = "#CC9393"
-- mouse_finder_[timeout|animate_timeout|radius|factor]
-- }}}

-- {{{ Menu
-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_height = "15"
theme.menu_width  = "130"
--theme.menu_bg_focus  = "#2d3030"
theme.menu_bg_focus  = "#5e656f"
-- }}}

-- {{{ Icons
-- {{{ Taglist
theme.taglist_squares_sel   = "/home/josh/.config/awesome/themes/custom/taglist/squarefz.png"
theme.taglist_squares_unsel = "/home/josh/.config/awesome/themes/custom/taglist/squarez.png"
--theme.taglist_squares_resize = "false"
-- }}}

-- {{{ Misc
theme.awesome_icon           = "/home/josh/.config/awesome/themes/custom/awesome-icon.png"
theme.menu_submenu_icon      = "/home/josh/.config/awesome/themes/default/submenu.png"
theme.tasklist_floating_icon = "/home/josh/.config/awesome/themes/default/tasklist/floatingw.png"
-- }}}

-- {{{ Layout
theme.layout_tile       = "/home/josh/.config/awesome/themes/custom/layouts/tile.png"
theme.layout_tileleft   = "/home/josh/.config/awesome/themes/custom/layouts/tileleft.png"
theme.layout_tilebottom = "/home/josh/.config/awesome/themes/custom/layouts/tilebottom.png"
theme.layout_tiletop    = "/home/josh/.config/awesome/themes/custom/layouts/tiletop.png"
theme.layout_fairv      = "/home/josh/.config/awesome/themes/custom/layouts/fairv.png"
theme.layout_fairh      = "/home/josh/.config/awesome/themes/custom/layouts/fairh.png"
theme.layout_spiral     = "/home/josh/.config/awesome/themes/custom/layouts/spiral.png"
theme.layout_dwindle    = "/home/josh/.config/awesome/themes/custom/layouts/dwindle.png"
theme.layout_max        = "/home/josh/.config/awesome/themes/custom/layouts/max.png"
theme.layout_fullscreen = "/home/josh/.config/awesome/themes/custom/layouts/fullscreen.png"
theme.layout_magnifier  = "/home/josh/.config/awesome/themes/custom/layouts/magnifier.png"
theme.layout_floating   = "/home/josh/.config/awesome/themes/custom/layouts/floating.png"
-- }}}

-- {{{ Titlebar
theme.titlebar_close_button_focus  = "/home/josh/.config/awesome/themes/custom/titlebar/close_focus.png"
theme.titlebar_close_button_normal = "/home/josh/.config/awesome/themes/custom/titlebar/close_normal.png"

theme.titlebar_ontop_button_focus_active  = "/home/josh/.config/awesome/themes/custom/titlebar/ontop_focus_active.png"
theme.titlebar_ontop_button_normal_active = "/home/josh/.config/awesome/themes/custom/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_inactive  = "/home/josh/.config/awesome/themes/custom/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_inactive = "/home/josh/.config/awesome/themes/custom/titlebar/ontop_normal_inactive.png"

theme.titlebar_sticky_button_focus_active  = "/home/josh/.config/awesome/themes/custom/titlebar/sticky_focus_active.png"
theme.titlebar_sticky_button_normal_active = "/home/josh/.config/awesome/themes/custom/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_inactive  = "/home/josh/.config/awesome/themes/custom/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_inactive = "/home/josh/.config/awesome/themes/custom/titlebar/sticky_normal_inactive.png"

theme.titlebar_floating_button_focus_active  = "/home/josh/.config/awesome/themes/custom/titlebar/floating_focus_active.png"
theme.titlebar_floating_button_normal_active = "/home/josh/.config/awesome/themes/custom/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_inactive  = "/home/josh/.config/awesome/themes/custom/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_inactive = "/home/josh/.config/awesome/themes/custom/titlebar/floating_normal_inactive.png"

theme.titlebar_maximized_button_focus_active  = "/home/josh/.config/awesome/themes/custom/titlebar/maximized_focus_active.png"
theme.titlebar_maximized_button_normal_active = "/home/josh/.config/awesome/themes/custom/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_inactive  = "/home/josh/.config/awesome/themes/custom/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_inactive = "/home/josh/.config/awesome/themes/custom/titlebar/maximized_normal_inactive.png"
-- }}}
-- }}}

return theme
