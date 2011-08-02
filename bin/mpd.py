#!/usr/bin/python2

import sys

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

mpdconnect()

#while connected == True:
if connected == True:
    # mpd info
    status = mpd.status()
    state = status.state
    if state == "stop":
		print "[nothing playing]"
    else:
    	song_info = mpd.currentsong()
    	playing = song_info.artist + " - " + song_info.title

    	# print to dwm
    	print playing

    #sleep(5)
