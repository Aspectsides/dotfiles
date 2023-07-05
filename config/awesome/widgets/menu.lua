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

local apps = require("config.apps")
local mod = require("bindings.mod")

_M.awesomemenu = {
    {
        "hotkeys",
        function()
            hotkeys_popup.show_help(nil, awful.screen.focused())
        end,
    },
    { "manual", apps.manual_cmd },
    { "edit config", apps.editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    {
        "quit",
        function()
            awesome.quit()
        end,
    },
}

_M.mainmenu = awful.menu({
    items = {
        { "awesome", _M.awesomemenu, beautiful.awesome_icon },
        { "open terminal", apps.terminal },
    },
})

return _M
