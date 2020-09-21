#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

PS1="\n\[\e[32m\]\w\[\e[m\] \n> "

pfetch | lolcat
