define() { curl -s dict://dict.org/d:$1 | grep -v '^[0-9]' }

fu() { curl -s "http://www.commandlinefu.com/commands/matching/$@/$(echo -n $@ | openssl base64)/plaintext" | grep -v "^# commandlinefu" }

mdc() { mkdir -p "$1" && cd "$1" }

extract() {
  if [ -f $1 ] ; then
    case $1 in 
      *.tar.bz2)  tar xjvf $1   ;;
      *.tbz2)     tar xjvf $1   ;;
      *.tar.gz)   tar xzvf $1   ;;
      *.tgz)      tar xzvf $1   ;;
      *.tar.xz)   tar xJvf $1   ;;
      *.tar)      tar xvf $1    ;;
      *.bz2)      bunzip2 $1    ;;
      *.rar)      unrar x $1    ;;
      *.gz)       gunzip $1     ;;
      *.zip)      unzip $1      ;;
      *.ace)      unace $1      ;;
      *.Z)        uncompress $1 ;;
      *.7z)       7z x $1       ;;
      *)          echo "'$1' cannot be extracted."a ;;
    esac
  else
    echo "'$1' is not a valid file."
  fi
}

rename_mp3() {
    find . -type f -exec sh -c 'test $(file --brief --mime-type "$0") == "audio/mpeg"' {} \; -print | xargs -t -i mv {} {}.mp3
}

connect_monitor() {
	  xrandr --output LVDS --primary --mode 1600x900 --pos 0x0 --output VGA-0 --mode 1680x1050 --pos 1600x0  
}

