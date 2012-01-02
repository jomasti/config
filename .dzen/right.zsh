#!/bin/zsh
#
# dzen2 script - Scott Kidder 2010
#
# Dzen conf
source ~/.dzen/disps.zsh
source ~/.dzen/colors.zsh

while true; do
    SONG=$(fmpd)
    #BAR=$(fmpdbar)
    AVOL=$(falsavol)
    #MVOL=$(fmpdvol)
    #NET=$(cat ~/.network)
    PMPD="^fg($ICONCOL1)^i($ICONDIR/dzen_bitmaps/musicS.xbm)^fg($FONTCOL) $SONG ^fg($ICONCOL1)^i($ICONDIR/spkr_01.xbm) ^fg(#)$AVOL"

    print "$PMPD"

    sleep 1
done
