local naughty = require("naughty")
local awesome = awesome

local display_high = true
local display_low = true
local display_charge = true

awesome.connect_signal("signal::battery", function(percentage, state)
    local value = percentage

    -- only display message if its not charging and low
    if value < 16 and display_low and state == 2 then
        naughty.notification({
            title = "Battery Status",
            text = "Running low at " .. value .. "%",
            app_name = "AwesomeWM",
        })
        display_low = false
    end

    -- only display message once if its fully charged and high
    if display_high and state == 4 and value > 90 then
        naughty.notification({
            title = "Battery Status",
            text = "Fully charged!",
            app_name = "AwesomeWM",
        })
        display_high = false
    end

    -- only display once if charging
    if display_charge and state == 1 then
        naughty.notification({
            title = "Battery Status",
            text = "Charging",
            app_name = "AwesomeWM",
        })
        display_charge = false
    end

    if value < 88 and value > 18 then
        display_low = true
        display_high = true
    end

    if state == 2 then
        display_charge = true
    end
end)
