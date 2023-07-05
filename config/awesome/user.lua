-- General

modkey = "Mod4"
batt = "macsmc-battery"
passwd = "0331"
sessionlock = true
shotdir = "~/Pictures/Screenshots/"
-- pfp = os.getenv("HOME") .. "/Pictures/Misc/pfp.png"

-- Apps

terminal = "alacritty"
browser = "firefox"
files = "nemo"
editor = "vim"
editorcmd = terminal .. ' -e  "' .. editor .. '"'
config = terminal .. ' -e "' .. editor .. " " .. require("gears").filesystem.get_configuration_dir() .. '"'

-- Commands

lock = "awesome-client command 'lock()'"
exit = "awesome-client command 'awesome.quit()'"
shutdown = "systemctl poweroff"
reboot = "systemctl reboot"

-- Theme

color = require("color.sakura")
font = "RobotoMono Bold 11"
fontalt = "RobotoMono Italic Bold 11"
fonticon = "Material Icons 16"
titlecontrols = false
panelcontrols = true
-- wallpaper = os.getenv("HOME") .. "/Pictures/Wallpaper/Fog.png"
