#!/usr/bin/env zsh 

[[ -f ~/.Xdefaults ]] && xrdb -merge ~/.Xdefaults &

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

feh --bg-scale ~/.wallpaper/1.jpg &
compton -b &
urxvtd -f &

exec dwm


