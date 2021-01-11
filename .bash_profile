#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export WINEPREFIX="$HOME/Giochi/Wine"
export PATH=$PATH:"$HOME/.scripts"
export XDG_CURRENT_DESKTOP=Openbox
export VISUAL=nano
export EDITOR=nano

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi
