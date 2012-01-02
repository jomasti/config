if [ $# -ge 1 ]; then
  game="`which $1`"
  openbox="`which openbox`"
  tmpgame="/tmp/tmpgame.sh"
  DISPLAY=:1.0
  echo -e "${openbox} &\n${game}" > ${tmpgame}
  echo "starting ${game}"
  xinit ${tmpgame} -- :1 || exit 1
else
  echo "not a valid argument"
fi
