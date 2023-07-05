-- awesome_mode: api-level=4:screen=on

-- load luarocks if installed
pcall(require, "luarocks.loader")

-- load theme
local beautiful = require("beautiful")
local gears = require("gears")
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- load key and mouse bindings
require("bindings")

-- load rules
require("rules")

-- load signals
local signals = require("signals")
-- signals.awesome.battery.enable() -- enable battery signal and notifs
