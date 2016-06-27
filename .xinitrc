#!/usr/bin/env sh
#
# ~/.xinitrc
#

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# xresources
#xrdb ~/.Xresources

# nvidia
#nvidia-settings -l

# repeat rate
xset r rate 300 40

# fonts
#xset +fp /usr/share/fonts/X11/PCF/ProFont/

# hotkeys
#sxhkd &

# redshift
#redshift &

# wallpaper
#feh --bg-tile "$HOME/bg.png" --no-fehbg
hsetroot -solid '#1a2028'

# compositor
compton -r 4 -o 0.75 -l -6 -t -6 -c -G -b -m 0.75

# slow down deathadder
xinput set-prop 8 "Device Accel Constant Deceleration" 3

# bar
#bar.sh | bar -g x24 -d -f -*-profont-*-*-*-*-12-*-*-*-*-*-*-* -B "#ff101820" -F "#ff687078" &

# mpd
#mpd

# vnc
#x11vnc -forever -rfbauth ~/.x11vnc/passwd &

# window manager
#exec spectrwm
