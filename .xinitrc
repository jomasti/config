#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# Check whether the external monitor is connected
xrandr | grep VGA | grep " connected "

# 0 is returned on success
if [ $? -eq 0 ]; then
	xrandr --output LVDS1 --primary --mode 1280x800 --pos 0x0 --output VGA1 --mode 1024x768 --pos 1280x0
fi

xsetroot -cursor_name left_ptr

# start programs
#start-pulseaudio-x11 &
#wicd-client &
#obmixer &
#parcellite &
#thunar --daemon &
#xscreensaver -no-splash &

if [[ $1 == "awesome" ]]
then
  exec ck-launch-session dbus-launch awesome
elif [[ $1 == "i3" ]]
then
  exec ck-launch-session dbus-launch i3
elif [[ $1 == "xmonad" ]]
then
exec /usr/bin/trayer --edge top --align center --SetDockType true --SetPartialStrut true  --expand true --width 10 --transparent true --tint 0x000000 --alpha 0 --height 13 &
  exec ck-launch-session dbus-launch xmonad
elif [[ $1 == "scrotwm" ]]
then
  exec ck-launch-session dbus-launch scrotwm
elif [[ $1 == "subtle" ]]
then
  exec ck-launch-session dbus-launch subtle
elif [[ $1 == "ratpoison" ]]
then
  xrandr --output VGA1 --off
  ( sleep 1; trayer --align right --edge bottom --distance 0 --expand true --transparent true --alpha 128 --tint 0 --SetDockType true --SetPartialStrut true & ) &
  exec ck-launch-session dbus-launch ratpoison
elif [[ $1 == "openbox" ]]
then
  exec ck-launch-session dbus-launch openbox-session
elif [[ $1 == "catwm" ]]
then
  exec ck-launch-session dbus-launch catwm
elif [[ $1 == "dwm" ]]
then
  xrandr --output VGA1 --off
  exec ck-launch-session dbus-launch dwm
elif [[ $1 == "euclid" ]]
then
  exec ck-launch-session dbus-launch euclid-wm
elif [[ $1 == "stumpwm" ]]
then
  exec ck-launch-session dbus-launch stumpwm
else
  echo "Choose a window manager"
fi
