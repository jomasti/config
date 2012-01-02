#!/bin/zsh
#
# dzen2 script - Scott Kidder 2010
#
# Dzen colors and icons
#
source ~/.dzen/disps.zsh
source ~/.dzen/colors.zsh

# Configuration
DISKIVAL=360
WEATHERIVAL=720
BLINK=0

DISKCOUNTER=$DISKIVAL
WEATHERCOUNTER=$WEATHERIVAL

while true; do
    PDATE="$(fdate)"

    PMEM="^fg($ICONCOL1)^i($ICONDIR/mem.xbm)^fg($FONTCOL) $(fmem)"

    PCPU="^fg($ICONCOL1)^i($ICONDIR/cpu.xbm)^fg($FONTCOL) $(fcpu)"

    #MCOUNT=$(fmail)
    PCOUNT=$(fpacman)

    #if [[ $MCOUNT -ne 0 && $BLINK -ne 0 ]]; then
  #PMICON="^fg($ICONCOL2)^i($ICONDIR/mail.xbm)^fg($FONTCOL)"
   # else
# PMICON="^i($ICONDIR/mail.xbm)^fg($FONTCOL)"
  #PMICON=""
    #fi

    if [[ $PCOUNT -ne 0 && $BLINK -ne 0 ]]; then
  AICON="^fg($ICONCOL2)^i($ICONDIR/arch.xbm)^fg($FONTCOL)"
    else
  AICON="^i($ICONDIR/arch.xbm)"
    fi

    if [ $DISKCOUNTER -ge $DISKIVAL ]; then
        DISK1P=$(fdiskusagep1)
        DISK1F=$(fdiskusagef1)
        PDISK1="^fg($ICONCOL1)^i($ICONDIR/diskette.xbm) root^fg($FONTCOL) $DISK1P $DISK1F"
        DISKCOUNTER=0
    fi

    if [ $WEATHERCOUNTER -ge $WEATHERIVAL ]; then
        WEATHER=($(fweather))
        TEMP=${WEATHER[1]}
        SEP=${WEATHER[2]}
        SKY=${WEATHER[3,-1]}
        PWEATHER="^fg($FONTCOL) $TEMP ^fg($ICONCOL2) $SEP ^fg($FONTCOL) $SKY"
        WEATHERCOUNTER=0
    fi

    WICON="^fg($ICONCOL1)^i($ICONDIR/temp.xbm)"

    DISKCOUNTER=$((DISKCOUNTER+1))
    WEATHERCOUNTER=$((WEATHERCOUNTER+1))
    BLINK=$(($BLINK ^ 1))

    PSEP="^fg($ICONCOL1) | "
    print "$WICON $PWEATHER $PSEP $AICON $PCOUNT $PSEP $PCPU $PMEM $PDISK1 $PSEP $PDATE"

    sleep 1
done

