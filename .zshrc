# The following lines were added by compinstall

zstyle ':completion:*' menu select
zstyle :compinstall filename '/home/jacopo/.zshrc'

autoload -Uz compinit
compinit
autoload -Uz promptinit
promptinit
prompt fade red
unsetopt MULTIBYTE
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

export PATH="$HOME/.scripts:$PATH"

bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
bindkey  "^[[3~"  delete-char
