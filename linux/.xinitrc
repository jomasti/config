#!/bin/sh
#copy over /etc/X11/xinit/xserverrc for the session choosing to work correctly

xsetroot -cursor_name left_ptr

setxkbmap -option compose:ralt

# Check how many monitors are connected
monitors=$(xrandr -d :0 -q | grep -c ' connected')

# If 3 monitors are connected, it's my desktop setup
if [ "$monitors" -eq 3 ]; then
  if lsmod | grep nouveau >/dev/null; then
    ~/.screenlayout/Desktop.sh
  else
    ~/.screenlayout/Desktop-nvidia.sh
  fi
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/* ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

[ -f ~/.fehbg ] && ~/.fehbg &

[ -f "${HOME}/.xprofile" ] && source "${HOME}/.xprofile"
source "${DOTFILES}/shell/x11.sh"

urxvtd -q -o -f &
pulseaudio --start
volnoti &
dunst &
xss-lock -- lockscreen &
pasystray &
sxhkd &

session=${1:-bspwm}

case $session in
  awesome           ) exec awesome;;
  bspwm             ) exec bspwm;;
  dwm               ) exec ~/bin/startdwm;;
  gnome             ) exec gnome-session;;
  herbstluftwm      ) exec herbstluftwm --locked;;
  i3|i3wm           ) exec i3;;
  monster|monsterwm ) exec monsterwm;;
  notion            ) exec notion;;
  openbox           ) exec openbox-session;;
  subtle            ) exec subtle;;
  xfce              ) exec startxfce4;;
  xmonad            ) exec xmonad;;
  # No known session, try to run it as command
  *) exec "$1";;
esac
