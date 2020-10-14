#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# navigation
alias ..='cd ..' 
alias ls='ls -lA --color=auto'
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

# merge Xresources
alias merge='xrdb -merge ~/.Xresources'

# the terminal rickroll
alias rr='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# updates
alias yayf='yay && flatpak update'

PS1="\n\[\e[32m\]\w\[\e[m\] \n> "

pfetch | lolcat
