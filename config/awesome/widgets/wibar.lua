local _M = {}

local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local beautiful = require("beautiful")
local xresources = beautiful.xresources
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local menubar = require("menubar")
local helpers = require("helpers")
local awesome = awesome
local client = client

local mod = require("bindings.mod")

_M.battery_bar = wibox.widget({
    max_value = 100,
    value = 70,
    forced_width = dpi(100),
    color = beautiful.bg_focus,
    background_color = helpers.math.lighten(beautiful.bg_normal, -3),
    widget = wibox.widget.progressbar,
})

-- helpers.widget.add_hover_cursor(_M.battery_bar, "hand2")

local battery_icon = wibox.widget({
    markup = helpers.text.colorize_text(" ", beautiful.bg_focus),
    font = beautiful.font_name .. "40",
    widget = wibox.widget.textbox,
})

local battery_text = wibox.widget({
    markup = "No data available",
    widget = wibox.widget.textbox,
})

local battery_empty = wibox.widget({
    markup = "No data available",
    widget = wibox.widget.textbox,
})

local battery_ratio_container = wibox.widget({
    {
        battery_icon,
        left = dpi(20),
        right = dpi(30),
        widget = wibox.container.margin,
    },
    {
        helpers.widget.vertical_pad(dpi(10)),
        {
            markup = helpers.text.bold_text(helpers.text.colorize_text("Battery Statistics", beautiful.fg_normal)),
            widget = wibox.widget.textbox,
        },
        helpers.widget.vertical_pad(dpi(10)),
        battery_text,
        battery_empty,
        helpers.widget.vertical_pad(dpi(10)),
        layout = wibox.layout.fixed.vertical,
    },
    helpers.widget.horizontal_pad(dpi(20)),
    layout = wibox.layout.fixed.horizontal,
})

_M.battery_popup = awful.popup({
    widget = {
        {
            {
                {
                    battery_ratio_container,
                    margins = dpi(10),
                    widget = wibox.container.margin,
                },
                bg = beautiful.bg_normal,
                shape = helpers.shape.prrect(dpi(6), false, false, true, true),
                widget = wibox.container.background,
            },
            bottom = beautiful.border_width,
            left = beautiful.border_width,
            right = beautiful.border_width,
            widget = wibox.container.margin,
        },
        bg = beautiful.border_color_normal,
        shape = helpers.shape.prrect(dpi(6), false, false, true, true),
        widget = wibox.container.background,
    },
    visible = false,
    ontop = true,
    maximum_height = dpi(450),
    maximum_width = dpi(500),
    placement = function(c)
        awful.placement.next_to(c, {
            preferred_positions = { "bottom", "right", "left", "top" },
            preferred_anchors = { "middle", "front", "back" },
        })
    end,
    bg = beautiful.bg_normal .. "00",
    border_width = dpi(0),
})

_M.battery_bar:connect_signal("mouse::enter", function()
    _M.battery_popup.visible = true
end)

_M.battery_bar:connect_signal("mouse::leave", function()
    _M.battery_popup.visible = false
end)

awesome.connect_signal("signal::battery", function(value, state, time_to_empty, time_to_full, battery_level)
    _M.battery_bar.value = value

    local bat_icon = ""

    if value >= 90 and value <= 100 then
        bat_icon = ""
    elseif value >= 70 and value < 90 then
        bat_icon = ""
    elseif value >= 60 and value < 70 then
        bat_icon = ""
    elseif value >= 50 and value < 60 then
        bat_icon = ""
    elseif value >= 30 and value < 50 then
        bat_icon = ""
    elseif value >= 15 and value < 30 then
        bat_icon = ""
    else
        bat_icon = ""
    end

    battery_empty.markup =
        helpers.text.colorize_text("Time till empty\t: " .. time_to_empty .. " min", beautiful.fg_normal)

    -- if charging
    if state == 1 then
        bat_icon = ""
        battery_empty.markup =
            helpers.text.colorize_text("Time till full\t: " .. time_to_full .. " min", beautiful.fg_normal)
    end

    -- if low battery
    if battery_level == 3 then
        _M.battery_bar.color = helpers.math.lighten(beautiful.bg_urgent, 30)
    end

    battery_icon.markup = helpers.text.colorize_text(bat_icon, beautiful.bg_focus)
    battery_text.markup = helpers.text.colorize_text("Battery level\t: " .. value .. "%", beautiful.fg_normal)
end)

_M.menu = awful.widget.button({
    image = beautiful.theme_assets.awesome_icon(beautiful.wibar_height, beautiful.bg_focus, beautiful.bg_normal),
    clip_shape = helpers.shape.rrect(dpi(6)),
    forced_height = beautiful.wibar_height,
    forced_width = beautiful.wibar_height,
    resize = true,
    buttons = { awful.button({}, 1, nil, function()
        menubar.show()
    end) },
})

_M.keyboardlayout = awful.widget.keyboardlayout()
_M.textclock = wibox.widget.textclock()

function _M.create_promptbox()
    return awful.widget.prompt()
end

function _M.create_layoutbox(s)
    return awful.widget.layoutbox({
        screen = s,
        buttons = {
            awful.button({
                modifiers = {},
                button = 1,
                on_press = function()
                    awful.layout.inc(1)
                end,
            }),
            awful.button({
                modifiers = {},
                button = 3,
                on_press = function()
                    awful.layout.inc(-1)
                end,
            }),
            awful.button({
                modifiers = {},
                button = 4,
                on_press = function()
                    awful.layout.inc(-1)
                end,
            }),
            awful.button({
                modifiers = {},
                button = 5,
                on_press = function()
                    awful.layout.inc(1)
                end,
            }),
        },
    })
end

function _M.create_taglist(s)
    return awful.widget.taglist({
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({
                modifiers = {},
                button = 1,
                on_press = function(t)
                    t:view_only()
                end,
            }),
            awful.button({
                modifiers = { mod.super },
                button = 1,
                on_press = function(t)
                    if client.focus then
                        client.focus:move_to_tag(t)
                    end
                end,
            }),
            awful.button({
                modifiers = {},
                button = 3,
                on_press = awful.tag.viewtoggle,
            }),
            awful.button({
                modifiers = { mod.super },
                button = 3,
                on_press = function(t)
                    if client.focus then
                        client.focus:toggle_tag(t)
                    end
                end,
            }),
            awful.button({
                modifiers = {},
                button = 4,
                on_press = function(t)
                    awful.tag.viewprev(t.screen)
                end,
            }),
            awful.button({
                modifiers = {},
                button = 5,
                on_press = function(t)
                    awful.tag.viewnext(t.screen)
                end,
            }),
        },
        widget_template = {
            {
                { id = "text_role", widget = wibox.widget.textbox },
                top = dpi(10),
                bottom = dpi(10),
                right = dpi(12),
                left = dpi(12),
                widget = wibox.container.margin,
            },
            id = "background_role",
            widget = wibox.container.background,
        },
    })
end

function _M.create_tasklist(s)
    return awful.widget.tasklist({
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        layout = { spacing = 1, layout = wibox.layout.fixed.horizontal },
        buttons = {
            awful.button({
                modifiers = {},
                button = 1,
                on_press = function(c)
                    c:activate({
                        context = "tasklist",
                        action = "toggle_minimization",
                    })
                end,
            }),
            awful.button({
                modifiers = {},
                button = 3,
                on_press = function()
                    awful.menu.client_list({ theme = { width = 250 } })
                end,
            }),
            awful.button({
                modifiers = {},
                button = 4,
                on_press = function()
                    awful.client.focus.byidx(-1)
                end,
            }),
            awful.button({
                modifiers = {},
                button = 5,
                on_press = function()
                    awful.client.focus.byidx(1)
                end,
            }),
        },
        widget_template = {
            {
                wibox.widget.base.make_widget(),
                forced_height = dpi(2),
                id = "background_role",
                widget = wibox.container.background,
            },
            {
                awful.widget.clienticon,
                margins = dpi(6),
                widget = wibox.container.margin,
            },
            nil,
            layout = wibox.layout.align.vertical,
        },
    })
end

function _M.create_wibox(s)
    return awful.wibar({
        screen = s,
        position = "top",
        height = beautiful.wibar_height,
        widget = {
            layout = wibox.layout.align.horizontal,
            -- left widgets
            {
                layout = wibox.layout.fixed.horizontal,
                { _M.menu, margins = dpi(8), widget = wibox.container.margin },
                s.taglist,
                s.promptbox,
            },
            -- middle widgets
            s.tasklist,
            -- right widgets
            {
                layout = wibox.layout.fixed.horizontal,
                spacing = dpi(5),
                {
                    wibox.widget.systray(),
                    margins = dpi(8),
                    widget = wibox.container.margin,
                },
                { _M.battery_bar, margins = dpi(12), widget = wibox.container.margin },
                _M.textclock,
                { s.layoutbox, margins = dpi(8), widget = wibox.container.margin },
            },
        },
    })
end

return _M
