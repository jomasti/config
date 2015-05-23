#!/bin/sh
#copy over /etc/X11/xinit/xserverrc for the session choosing to work correctly

export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_STYLE_OVERRIDE=gtk

xsetroot -cursor_name left_ptr

setxkbmap -option compose:ralt

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
	for f in /etc/X11/xinit/xinitrc.d/* ; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

#urxvtd -q -o -f &
#xrdb -merge ~/.Xresources
#volnoti &
#dunst &
#xss-lock -- i3lock -lock &
#pasystray &
#nm-applet &

session=${1:-i3}

case $session in
    awesome           ) 
      exec /usr/bin/awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr;;
    bspwm             ) exec bspwm;;
    dwm               ) exec ~/bin/startdwm;;
    gnome             ) exec gnome-session;;
    i3|i3wm           ) exec i3 -V >> ~/.config/i3/i3log-$(date +'%F-%k-%M-%S') 2>&1;;
    monster|monsterwm ) exec monsterwm;;
    notion            ) exec notion;;
    openbox           ) exec openbox-session;;
    subtle            ) exec subtle;;
    xfce              ) exec startxfce4;;
    xmonad            ) exec xmonad;;
    # No known session, try to run it as command
    *) exec $1;;
esac
