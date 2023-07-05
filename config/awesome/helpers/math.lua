local helpers = {}

-- Rounds to whole number
local function round(num) return math.floor(num + 0.5) end
-- Rounds to hundredths
local function roundH(num) return math.floor((num * 100) + 0.5) / 100 end

-- Converts hexadecimal color to HSL
-- Lightness (L) is changed based on amt
-- Converts HSL back to hex
-- amt (0-100) can be negative to darken or positive to lighten
-- The amt specified is added to the color's existing Lightness
-- e.g., (#000000, 25) L = 25 but (#404040, 25) L = 50

function helpers.lighten(hex_color, amt)
    local r, g, b, a
    local hex = hex_color:gsub("#", "")
    if #hex < 6 then
        local t = {}
        for i = 1, #hex do
            local char = hex:sub(i, i)
            t[i] = char .. char
        end
        hex = table.concat(t)
    end
    r = tonumber(hex:sub(1, 2), 16) / 255
    g = tonumber(hex:sub(3, 4), 16) / 255
    b = tonumber(hex:sub(5, 6), 16) / 255
    if #hex ~= 6 then a = roundH(tonumber(hex:sub(7, 8), 16) / 255) end

    local max = math.max(r, g, b)
    local min = math.min(r, g, b)
    local c = max - min
    -----------------------------
    -- Hue
    local h
    if c == 0 then
        h = 0
    elseif max == r then
        h = ((g - b) / c) % 6
    elseif max == g then
        h = ((b - r) / c) + 2
    elseif max == b then
        h = ((r - g) / c) + 4
    end
    h = h * 60
    -----------------------------
    -- Luminance
    local l = (max + min) * 0.5
    -----------------------------
    -- Saturation
    local s
    if l <= 0.5 then
        s = c / (l * 2)
    elseif l > 0.5 then
        s = c / (2 - (l * 2))
    end
    -----------------------------
    local H, S, L, A
    H = round(h) / 360
    S = round(s * 100) / 100
    L = round(l * 100) / 100

    amt = amt / 100
    if L + amt > 1 then
        L = 1
    elseif L + amt < 0 then
        L = 0
    else
        L = L + amt
    end

    local R, G, B
    if S == 0 then
        R, G, B = round(L * 255), round(L * 255), round(L * 255)
    else
        local function hue2rgb(p, q, t)
            if t < 0 then t = t + 1 end
            if t > 1 then t = t - 1 end
            if t < 1 / 6 then return p + (q - p) * (6 * t) end
            if t < 1 / 2 then return q end
            if t < 2 / 3 then return p + (q - p) * (2 / 3 - t) * 6 end
            return p
        end
        local q
        if L < 0.5 then
            q = L * (1 + S)
        else
            q = L + S - (L * S)
        end
        local p = 2 * L - q
        R = round(hue2rgb(p, q, (H + 1 / 3)) * 255)
        G = round(hue2rgb(p, q, H) * 255)
        B = round(hue2rgb(p, q, (H - 1 / 3)) * 255)
    end

    if a ~= nil then
        A = round(a * 255)
        return string.format("#" .. '%.2x%.2x%.2x%.2x', R, G, B, A)
    else
        return string.format("#" .. '%.2x%.2x%.2x', R, G, B)
    end
end

local hex_color_match = "[a-fA-F0-9][a-fA-F0-9]"

function helpers.mix(color1, color2, ratio)
    ratio = ratio or 0.5
    local result = "#"
    local channels1 = color1:gmatch(hex_color_match)
    local channels2 = color2:gmatch(hex_color_match)
    for _ = 1,3 do
        local bg_numeric_value = math.ceil(
          tonumber("0x"..channels1())*ratio +
          tonumber("0x"..channels2())*(1-ratio)
        )
        if bg_numeric_value < 0 then bg_numeric_value = 0 end
        if bg_numeric_value > 255 then bg_numeric_value = 255 end
        result = result .. string.format("%02x", bg_numeric_value)
    end
    return result
end

return helpers
