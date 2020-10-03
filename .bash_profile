#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export WINEPREFIX="$HOME/Giochi/Wine"
export PATH=$PATH:"$HOME/.scripts"
export XDG_SESSION_CLASS=jacopo
export XDG_MENU_PREFIX=lxde- # for pcmanfm to work nicely
export XDG_SESSION_DESKTOP=openbox
export XDG_CURRENT_DESKTOP=openbox
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export XDG_CONFIG_DIRS="/usr/share/upstart/xdg:/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share/"

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  [[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1 &> /dev/null
fi
