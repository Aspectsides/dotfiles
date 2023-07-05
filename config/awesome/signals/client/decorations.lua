local awful = require("awful")
local beautiful = require("beautiful")
-- local gshape = require("gears.shape")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local client = client
-- local helpers = require("helpers")

--[[
local close_bg = wibox.container.background()
close_bg.bg = helpers.math.lighten(beautiful.bg_urgent, 30)
close_bg.shape = gshape.circle
local close_bg_surface = wibox.widget.draw_to_image_surface(close_bg, dpi(256), dpi(256))

local close_bg_pressed = wibox.container.background()
close_bg_pressed.bg = helpers.math.lighten(beautiful.bg_urgent, 30)
close_bg_pressed.opacity = 0.6
close_bg_pressed.shape = gshape.circle
local close_bg_pressed_surface = wibox.widget.draw_to_image_surface(close_bg_pressed, dpi(256), dpi(256))
--]]

client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = {
        awful.button({
            modifiers = {},
            button = 1,
            on_press = function()
                c:activate({ context = "titlebar", action = "mouse_move" })
            end,
        }),
        awful.button({
            modifiers = {},
            button = 3,
            on_press = function()
                c:activate({ context = "titlebar", action = "mouse_resize" })
            end,
        }),
    }

    --[[
    local closebutton = awful.widget.button({
        image = close_bg_surface,
        buttons = {
            awful.button({}, 1, nil, function()
                c:kill()
            end),
        },
    })

    closebutton:connect_signal("button::press", function()
        closebutton:set_image(close_bg_pressed_surface)
    end)

    closebutton:connect_signal("button::release", function()
        closebutton:set_image(close_bg_surface)
    end)
    --]]

    awful.titlebar(c, { size = beautiful.titlebar_height }).widget = {
        -- left
        nil,
        -- middle
        {
            -- title
            { align = "center", widget = awful.titlebar.widget.titlewidget(c) },
            buttons = buttons,
            layout = wibox.layout.flex.horizontal,
        },
        -- right
        --[[
        {
            { closebutton, layout = wibox.layout.fixed.horizontal() },
            margins = dpi(8),
            widget = wibox.container.margin,
        },
        ]]
        --
        nil,
        layout = wibox.layout.align.horizontal,
    }
end)
