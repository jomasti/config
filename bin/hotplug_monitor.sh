#! /usr/bin/bash
# Check if the monitor is connected
read STATUS < /sys/class/drm/card0-VGA-1/status
export DISPLAY=:0
export XAUTHORITY=/home/josh/.Xauthority
if [ "$STATUS" = "connected" ]; then
    xrandr --output VGA-0 --right-of LVDS --auto --screen 0 
    xrandr --output LVDS --primary
else
    xrandr --output VGA-0 --off --screen 0
    xrandr --output LVDS --primary
fi 
