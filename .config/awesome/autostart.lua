--             _            _             _   
--   __ _ _   _| |_ ___  ___| |_ __ _ _ __| |_ 
--  / _` | | | | __/ _ \/ __| __/ _` | '__| __|
-- | (_| | |_| | || (_) \__ \ || (_| | |  | |_ 
--  \__,_|\__,_|\__\___/|___/\__\__,_|_|   \__|
local awful = require("awful")

-- Network Manager Applet
run_once("nm-applet")

-- Compositor
run_once("picom -b --experimental-backends --backend glx --config $HOME/.config/picom/picom.conf")

-- Compose key
run_once("setxkbmap -option compose:rctrl")

-- Polkit
run_once("lxpolkit")

-- Wallpaper & desktop
run_once("pcmanfm --desktop")

-- Keyboard lights
run_once("g213-led -a FF2233")

-- Mpd Cleanup
run_once([[
    ps aux | grep "mpc idleloop player" | grep -v grep | awk '{print $2}' | xargs kill
    ]])

return autostart
