#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Check whether the external monitor is connected
#xrandr | grep VGA | grep " connected "

# 0 is returned on success
#if [ $? -eq 0 ]; then
#	xrandr --output LVDS1 --primary --mode 1280x800 --pos 0x0 --output VGA1 --mode 1024x768 --pos 1280x0
#fi

xsetroot -cursor_name left_ptr

if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
	       eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

#bmpanel2 &
#obmixer &
#wicd-client &
#start-pulseaudio-x11 &
#(sleep 5 && pcmanfm -d) &
#anamnesis --start
#parcellite &
#xscreensaver -no-splash &
#osmo &
#urxvtd -q -o -f
#xset +fp /usr/share/fonts/local
#(sleep 2 && nitrogen --restore) &
#dropboxd &
#sh ~/.fehbg

if [[ $1 == "gnome" ]]
then
  exec ck-launch-session gnome-session
elif [[ $1 == "xfce4" ]]
then
  exec ck-launch-session startxfce4
elif [[ $1 == "awesome" ]]
then
  /home/josh/bin/xinit.sh
  exec ck-launch-session awesome
elif [[ $1 == "i3" ]]
then
  /home/josh/bin/xinit.sh
  exec ck-launch-session i3 -V >>/home/josh/.i3/i3log >&1
elif [[ $1 == "xmonad" ]]
then
  exec /usr/bin/trayer --edge top --align center --SetDockType true --SetPartialStrut true  --expand true --width 10 --transparent true --tint 0x000000 --alpha 0 --height 13 &
  exec ck-launch-session xmonad
elif [[ $1 == "scrotwm" ]]
then
  exec ck-launch-session scrotwm
elif [[ $1 == "subtle" ]]
then
  /home/josh/bin/xinit.sh
  exec ck-launch-session subtle
elif [[ $1 == "ratpoison" ]]
then
  #xrandr --output VGA1 --off
  ( sleep 1; trayer --align right --edge bottom --distance 0 --expand true --transparent true --alpha 128 --tint 0 --SetDockType true --SetPartialStrut true & ) &
  exec ck-launch-session ratpoison
elif [[ $1 == "openbox" ]]
then
  bmpanel2 &
  exec ck-launch-session openbox
elif [[ $1 == "catwm" ]]
then
  exec ck-launch-session catwm
elif [[ $1 == "dwm" ]]
then
  #xrandr --output VGA1 --off
  exec ck-launch-session ~/bin/startdwm
elif [[ $1 == "stumpwm" ]]
then
  /home/josh/bin/xinit.sh
  exec ck-launch-session stumpwm
elif [[ $1 == "wmfs" ]]
then
  exec ck-launch-session wmfs
elif [[ $1 == "musca" ]]
then
  exec ck-launch-session musca
else
  echo "Choose a window manager"
fi
