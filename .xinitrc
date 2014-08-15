#!/bin/sh

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_STYLE_OVERRIDE=gtk

# Check whether the external monitor is connected
xrandr | grep VGA | grep " connected "

# 0 is returned on success
if [ $? -eq 0 ]; then
	xrandr --output LVDS --primary --mode 1600x900 --pos 0x0 --output VGA-0 --mode 1680x1050 --pos 1600x0
fi

xsetroot -cursor_name left_ptr

setxkbmap -option compose:ralt

#synclient TouchpadOff=1
~/bin/touchpad.sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

anamnesis --start &
xscreensaver -no-splash &
urxvtd -q -o -f &
xset +fp /usr/share/fonts/local
xrdb -merge ~/.Xresources
dropboxd &
sh ~/.fehbg
volnoti &
start-pulseaudio-x11 &
mpd &
(sleep 2 && scrobby) &
dunst &
nm-applet &
cbatticon &
xss-lock -- i3lock -lock &
pasystray &

if [[ $1 == "gnome" ]]
then
  exec gnome-session
elif [[ $1 == "xfce4" ]]
then
  exec startxfce4
elif [[ $1 == "awesome" ]]
then
  exec awesome
elif [[ $1 == "i3" ]]
then
  exec i3 -V >>/home/josh/.i3/i3log >&1
elif [[ $1 == "xmonad" ]]
then
  #exec /usr/bin/trayer --edge top --align center --SetDockType true --SetPartialStrut true  --expand true --width 10 --transparent true --tint 0x000000 --alpha 0 --height 13 &
  exec xmonad
elif [[ $1 == "spectrwm" ]]
then
  exec spectrwm
elif [[ $1 == "subtle" ]]
then
  /home/josh/bin/xinit.sh
  exec subtle
elif [[ $1 == "ratpoison" ]]
then
  #xrandr --output VGA1 --off
  ( sleep 1; trayer --align right --edge bottom --distance 0 --expand true --transparent true --alpha 128 --tint 0 --SetDockType true --SetPartialStrut true & ) &
  exec ratpoison
elif [[ $1 == "openbox" ]]
then
  exec openbox-session
elif [[ $1 == "catwm" ]]
then
  exec catwm
elif [[ $1 == "dwm" ]]
then
  #xrandr --output VGA1 --off
  exec ~/bin/startdwm
elif [[ $1 == "stumpwm" ]]
then
  /home/josh/bin/xinit.sh
  exec stumpwm
elif [[ $1 == "wmfs" ]]
then
  exec wmfs
elif [[ $1 == "musca" ]]
then
  exec musca
elif [[ $1 == "herbstluftwm" ]]
then
  exec herbstluftwm
else
  echo "Choose a window manager"
fi


#(sleep 3; /usr/bin/trayer --edge top --align center --SetDockType true --SetPartialStrut true  --expand true --widthtype request --transparent true --tint 0x181818 --alpha 0 --height 20 & ) &
#exec /usr/bin/awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
exec i3 -V >> ~/.config/i3/i3log-$(date +'%F-%k-%M-%S') 2>&1
