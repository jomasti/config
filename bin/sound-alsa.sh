#!/bin/bash

[[ "$1" == "up" ]] && amixer set Master 5%+
[[ "$1" == "down" ]] && amixer set Master 5%-
[[ "$1" == "mute" ]] && amixer set Master toggle

VOL=$(amixer get Master | grep 'Mono:' | cut -d ' ' -f 6 | sed -e 's/[^0-9]//g')
[[ $(amixer get Master | grep "\[off\]") ]] && volnoti-show -m $VOL && exit
volnoti-show $VOL
