local awful = require("awful")
local beautiful = require("beautiful")
local xresources = beautiful.xresources
local dpi = xresources.apply_dpi
local wibox = require("wibox")

local helpers = require("helpers")
local vars = require("config.vars")
local wibar_widgets = require("widgets").wibar

local screen_bg = helpers.math.lighten(beautiful.bg_normal, 5)

screen.connect_signal("request::wallpaper", function(s)
    awful.wallpaper({
        screen = s,
        bg = screen_bg,
        widget = {
            {
                {
                    image = beautiful.theme_assets.awesome_icon(dpi(50), beautiful.bg_focus, screen_bg),
                    resize = false,
                    point = awful.placement.bottom_right,
                    widget = wibox.widget.imagebox,
                },
                widget = wibox.layout.manual,
            },
            margins = dpi(20),
            widget = wibox.container.margin,
        },
    })

    --[[
    awful.wallpaper({
        screen = s,
        bg = "#0000ff",
        widget = {
            {
                image = beautiful.wallpaper,
                resize = false,
                widget = wibox.widget.imagebox,
            },
            tiled = true,
            widget = wibox.container.tile,
        },
    })
    --]]
end)

screen.connect_signal("request::desktop_decoration", function(s)
    awful.tag(vars.tags, s, awful.layout.layouts[1])
    s.promptbox = wibar_widgets.create_promptbox()
    s.layoutbox = wibar_widgets.create_layoutbox(s)
    s.taglist = wibar_widgets.create_taglist(s)
    s.tasklist = wibar_widgets.create_tasklist(s)
    s.wibox = wibar_widgets.create_wibox(s)
end)
