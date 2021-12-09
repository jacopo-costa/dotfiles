#!/usr/bin/env bash

function run {
  if ! pgrep -f $1 ;
  then
    $@&
  fi
}

run setxkbmap -option compose:ralt
run polkit-gnome-authentication-agent-1
run picom -b --experimental-backends --backend glx --config $HOME/.config/picom/picom.conf
run wmname LG3D
