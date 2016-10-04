#!/bin/bash
list=`xinput --list | grep -i 'mouse'`

if [ ${#list} -eq 0 ]; then
  exec  `synclient touchpadoff=0`
  notify-send "Touchpad on" "Mouse not present"
else
  exec `synclient touchpadoff=1`
  notify-send "Touchpad off" "Mouse present"
fi
