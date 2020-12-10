#!/usr/bin/env bash


rofi_command="rofi -theme ~/.config/rofi/rofi-theme/power-menu.rasi"

# Options
shutdown=""
reboot=""
lock=""

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock"

chosen="$(echo -e "$options" | $rofi_command -p "" -dmenu)"
case $chosen in
    $shutdown)
        shutdown now
        ;;
    $reboot)
        reboot
        ;;
    $lock)
        i3lock-fancy
        ;;
esac
