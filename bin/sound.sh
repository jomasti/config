#!/bin/bash

[[ "$1" == "up" ]] && amixer set Master 5%+
[[ "$1" == "down" ]] && amixer set Master 5%-
[[ "$1" == "mute" ]] && amixer sset Master toggle

VOL=$(amixer get Master | grep Mono: | sed 's|[^[]*\[\([0-9]*\).*|\1|')
[[ $(amixer get Master | grep "\[off\]") ]] && volnoti-show -m $VOL && exit
volnoti-show $VOL
