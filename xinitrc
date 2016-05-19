#!/usr/bin/env zsh 

[[ -f ~/.Xdefaults ]] && xrdb -merge -I$HOME ~/.Xdefaults &

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

# happy hacking
xmodmap -e "keycode 102 = Super_L"
xmodmap -e "keycode 100 = Super_R"

feh --bg-scale ~/.wallpaper/2.jpg &
compton -b &
# urxvtd -f &
dwmstatus &

exec dwm


