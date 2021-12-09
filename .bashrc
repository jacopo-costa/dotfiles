#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source bash-completion
[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion

# Source command-not-found
source /usr/share/doc/pkgfile/command-not-found.bash

# Pretend cd when only path
shopt -s autocd

# Plex
alias startplex='sudo systemctl start plexmediaserver.service'
alias stopplex='sudo systemctl stop plexmediaserver.service'

# navigation
alias ..='cd ..'
alias ls='ls -lAh --group-directories-first --color=auto'
alias grep='grep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# adding flags
alias df='df -h'                          # human-readable sizes

# git
alias addall='git add .'
alias checkout='git checkout'
alias clone='git clone'
alias commit='git commit -m'
alias fetch='git fetch'
alias pull='git pull origin'
alias push='git push origin'
alias status='git status'

# shutdown or reboot
alias ssn="sudo shutdown now"
alias sr="sudo reboot"

# youtube-dl
alias ydl='youtube-dl'

PS1="\n\[\e[32m\]\w\[\e[m\] \n> "

pfetch
