#!/usr/bin/python2

import sys
import os

#from time import sleep
from mpdclient2 import *
from socket import error as SocketError

def mpdconnect():
	global connected
	global mpd
	try:
		mpd = connect()
		connected = True
	except SocketError:
		connected = False
		print "[not running]"
		#sleep(5)
		#mpdconnect()

def shellfm():
	if os.path.exists('/home/josh/.shell-fm/nowplaying'):
		f = open('/home/josh/.shell-fm/nowplaying', 'r')
		np = f.read()
		return np
	else:
		return pianobar()

def pianobar():
	if os.path.exists('/home/josh/.config/pianobar/nowplaying') and os.system("ps -ef | grep -v grep | grep pianobar") != 0:
		return "[nothing playing]"
	else:
		f = open('/home/josh/.config/pianobar/nowplaying', 'r')
		np = f.read()
		return np

mpdconnect()

#while connected == True:
if connected == True:
    # mpd info
    status = mpd.status()
    state = status.state
    if state == "stop":
		print shellfm()
#		print "[nothing playing]"
    else:
    	song_info = mpd.currentsong()
    	playing = song_info.artist + " - " + song_info.title

    	# print to dwm
    	print playing

    #sleep(5)
