local wibox = require("wibox")

local helpers = {}

function helpers.vertical_pad(height)
    return wibox.widget({
        forced_height = height,
        layout = wibox.layout.fixed.vertical,
    })
end

function helpers.horizontal_pad(width)
    return wibox.widget({
        forced_width = width,
        layout = wibox.layout.fixed.horizontal,
    })
end

-- Add a hover cursor to a widget by changing the cursor on
-- mouse::enter and mouse::leave
-- You can find the names of the available cursors by opening any
-- cursor theme and looking in the "cursors folder"
-- For example: "hand1" is the cursor that appears when hovering over
-- links
function helpers.add_hover_cursor(w, hover_cursor)
    local original_cursor = "left_ptr"

    w:connect_signal("mouse::enter", function()
        local w = _G.mouse.current_wibox
        if w then
            w.cursor = hover_cursor
        end
    end)

    w:connect_signal("mouse::leave", function()
        local w = _G.mouse.current_wibox
        if w then
            w.cursor = original_cursor
        end
    end)
end

return helpers
