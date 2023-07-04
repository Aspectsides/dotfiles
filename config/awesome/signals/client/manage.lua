local awful = require("awful")
local beautiful = require("beautiful")
local gsurface = require("gears.surface")

local awesome = awesome
local client = client

local fallback_icon = gsurface(beautiful.theme_assets.awesome_icon(256, beautiful.bg_focus, beautiful.bg_normal))

client.connect_signal("request::manage", function(c, _)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then
        awful.client.setslave(c)
    end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end

    -- Fallback icon for clients
    if c.icon == nil then
        c.icon = fallback_icon._native
    end
end)
