local helpers = {}

function helpers.colorize_text(txt, fg)
    return "<span foreground='" .. fg .. "'>" .. txt .. "</span>"
end

function helpers.bold_text(txt)
    return "<b>" .. txt .. "</b>"
end

return helpers
