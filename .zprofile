#!/bin/zsh

# Default programs:
export EDITOR="vim"
export TERMINAL="termite"
export BROWSER="chromium"
export READER="zathura"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
