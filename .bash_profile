#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

export WINEPREFIX="$HOME/Giochi/Wine"
export PATH=$PATH:"$HOME/.scripts"

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx /home/jacopo/.config/X11/xinitrc
fi
