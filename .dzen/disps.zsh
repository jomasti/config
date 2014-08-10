#!/bin/zsh

source .dzen/colors2.zsh

fweather() { 
    WEATHER=$(get-weather)
    TEMP=$(echo "$WEATHER" | awk '/^Temperature/' | cut -d' ' -f2)
    SKY=$(echo "$WEATHER" | awk '/^Sky/' |  cut -d' ' -f3- | tr -d '\n')
    SKYA=($SKY)
    echo "$TEMP // ${(C)SKYA}"
}

fmail() { cat ~/.mail/status }

fpacman() { pacman -Qu | wc -l }

fcpu() { awk '{print $1 " " $2 " " $3;}' /proc/loadavg }

fmem() {
    awk '/^MemTotal/ {t=sprintf("%0.f", $2)} /^MemFree/ {f=sprintf("%0.f", $2)} /^Cached/ {c=sprintf("%0.f", $2)} /^Buffers/ {b=sprintf("%0.f", $2)} END {print (t-(f+c+b)) " " t;}' /proc/meminfo | gdbar -h 8 -w 50 -s o -fg $BARFG -bg $BAROL
}

# FIX THeSE

fmemf() {
    awk '/^MemTotal/ {t=sprintf("%0.f", $2)} /^MemFree/ {f=sprintf("%0.f", $2)} /^Cached/ {c=sprintf("%0.f", $2)} /^Buffers/ {b=sprintf("%0.f", $2)} END {printf(t-(f+c+b))/1024"MB/"t/1024"MB";}' /proc/meminfo
}

fmemp() {
    awk '/^MemTotal/ {t=sprintf("%0.f", $2)} /^MemFree/ {f=sprintf("%0.f", $2)} /^Cached/ {c=sprintf("%0.f", $2)} /^Buffers/ {b=sprintf("%0.f", $2)} END { perc = ((t-(f+c+b))/t)*100; printf("%0.f", perc);}' /proc/meminfo
}

if [[ `hostname` == "hp-arch" ]]; then
    fdiskusage1() { df -h / | sed -ne 's/^.* \([0-9]*\)% .*/\1/p' | gdbar -h 8 -w 40 -fg $BARFG -bg $BARBG -ss 1 -sw 3 -nonl    };
    fdiskusagep1() { df -h / | awk '/sda3/ {print $5;}' };
    fdiskusagef1() { df -h / | awk '/sda3/ {print $3"/"$2;}' };
else
    fdiskusage1() { echo "" };
    fdiskusagep1() { echo "" };
    fdiskusagef1() { echo "" };
fi


fdate() { date "+%a, %-m/%-d/%y %I:%M:%S" }

fcmus() {
    if [[ -z `pgrep cmus` ]]; then
            echo "^fg($ICONCOL1)^i($ICONDIR/pause.xbm)"
    else
        ARTIST=$(cmus-remote --query | grep -m1 artist | awk '{$1=$2=""; print $0;}' | cut -c3-)
        TITLE=$(cmus-remote --query | grep -m1 title | awk '{$1=$2=""; print $0;}' | cut -c3-)
        ALBUM=$(cmus-remote --query | grep -m1 album | awk '{$1=$2=""; print $0;}' | cut -c3-)
        S=$(cmus-remote --query | grep playing)
        if [ -z $S ]; then
            ICON="^fg($ICONCOL1)^i($ICONDIR/pause.xbm)"
        else
            ICON="^fg($ICONCOL1)^i($ICONDIR/play.xbm)"
        fi
            echo "$ARTIST - $TITLE // $ALBUM $ICON"
    fi
}

fcmusbar() {
    DURATION=$(cmus-remote --query | grep duration | awk '{print $2;}')
    POSITION=$(cmus-remote --query | grep position | awk '{print $2;}')
    BAR=$(echo "$POSITION" | gdbar -h 10 -w 150 -fg $BARFG -bg $BAROL -s o -nonl -max $DURATION)
    echo "$BAR"
}

falsavol() {
    amixer get Master | tail -n 1 | awk '{print $5}' | tr -d \[\]%// | gdbar -h 8 -w 120 -fg $BARFG -bg $BAROL -ss 1 -sw 3 -s o -max 100
}

fcmusvol() {
    cmus-remote --query | grep vol_left | awk '{print $3;}' | gdbar -h 8 -w 120 -fg $BARFG -bg $BAROL -ss 1 -sw 3 -s o -max 100
}

fmpd() {
    if [[ -z `pgrep mpd` ]]; then
            echo "[nothing playing]"
    else
        ARTIST=$(mpc -f %artist% | head -n 1)
        TITLE=$(mpc -f %title% | head -n 1)
        ALBUM=$(mpc -f %album% | head -n 1)
        S=$(mpc | grep playing)
        if [ -z $S ]; then
            ICON="^fg($ICONCOL1)^i($ICONDIR/pause.xbm)"
            echo "[nothing playing]"
        else
            ICON="^fg($ICONCOL1)^i($ICONDIR/play.xbm)"
            echo "$ARTIST - $TITLE // $ALBUM $ICON"
        fi
    fi
}

fmpdbar() {
    PLAYING=$(mpc | grep playing)
    if [ -z $PLAYING ]; then
        echo ""
    else
        DURATION=$(echo $PLAYING | awk '{print $3;}' | cut -d/ -f1)
        DMINUTES=$(($(echo $DURATION | cut -d: -f1)*60))
        DSECONDS=$(echo $DURATION | cut -d: -f2)
        DBAR=$(($DMINUTES + $DSECONDS))
        POSITION=$(echo $PLAYING | awk '{print $3;}' | cut -d/ -f2)
        PMINUTES=$(($(echo $POSITION | cut -d: -f1)*60))
        PSECONDS=$(echo $POSITION | cut -d: -f2)
        PBAR=$(($PMINUTES + $PSECONDS))
        BAR=$(echo "$PBAR" | gdbar -h 10 -w 150 -fg $BARFG -bg $BAROL -s o -nonl -max 250)
        echo "$BAR"
    fi
}
    
    

#icon() {
#    echo "^fg($ICONCOL)^i(~/.dzen/dzenIcons/$1.xbm)^fg($FONTCOL)"
#}

