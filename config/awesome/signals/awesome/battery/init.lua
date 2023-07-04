-- This uses UPowerGlib.Device (https://lazka.github.io/pgi-docs/UPowerGlib-1.0/classes/Device.html)
-- Provides:
-- signal::battery
--      percentage
--      state
--
local upower = require("lgi").require("UPowerGlib")
local awesome = awesome

local function enable()
    if upower.Client():get_devices() ~= nil then
        local upower_widget = require("modules.battery_widget")

        upower_widget({
            device_path = "/org/freedesktop/UPower/devices/battery_BAT0",
            instant_update = true,
        }):connect_signal("upower::update", function(_, device)
            local time_to_empty = device.time_to_empty / 60
            local time_to_full = device.time_to_full / 60
            awesome.emit_signal(
                "signal::battery",
                tonumber(string.format("%.0f", device.percentage)),
                device.state,
                tonumber(string.format("%.0f", time_to_empty)),
                tonumber(string.format("%.0f", time_to_full)),
                device.battery_level
            )
        end)
    end

    require("signals.awesome.battery.notif")
end

return { enable = enable }
