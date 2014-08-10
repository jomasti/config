# -*- coding: utf-8 -*-

from i3pystatus import Status
from i3pystatus.mail import maildir

status = Status(standalone=True)

# Displays clock like this:
# Tue 30 Jul 11:59:46 PM KW31
#                          ^-- calendar week
status.register("clock",
                format="%l:%M")

status.register("clock",
                format="%B %d")

status.register("mail",
                backends=[
                    maildir.MaildirMail(
                        directory="/home/josh/Mail/GMail/INBOX/new")],
                hide_if_null="False")

status.register("text",
                text="MAIL",
                color="#181818")

status.register("mem",
                format="{percent_used_mem}%")

status.register("text",
                text="MEM",
                color="#181818")

# My custom now playing script for MPD and pianobar
status.register("shell",
                command="mpd.py")

status.run()
