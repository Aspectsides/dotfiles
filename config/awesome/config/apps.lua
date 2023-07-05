local _M = {
    terminal = os.getenv("TERMINAL") or "xst",
    editor = os.getenv("EDITOR") or "vi",
}

_M.editor_cmd = _M.terminal .. " -e " .. _M.editor
_M.manual_cmd = _M.terminal .. " -e man awesome"

return _M
