from canto.extra import *
import os

# Feeds
add("http://thiseternalrotation.blogspot.com/feeds/posts/default", tags=[None, "music"])
add("http://433rpm.blogspot.com/feeds/posts/default", tags=[None, "music"])
add("http://experimentaletc.blogspot.com/feeds/posts/default", tags=[None, "music"])

add("https://www.archlinux.org/feeds/news/", tags=[None, "linux"])

filters = [ None, with_tag_in("music"), with_tag_in("linux") ]

# Open links
if os.getenv("TERM") == "linux":
    link_handler("elinks \"%u\"", text=True)
    image_handler("fbi \"%u\"", text=True, fetch=True)
else:
    link_handler("firefox \"%u\"")
    image_handler("feh \"%u\"", fetch=True)

# Orientation
def resize_hook(cfg):
    cfg.reader_orientation = "right"
    cfg.reader_lines = cfg.width / 2
    cfg.columns = (cfg.width / 2) / 65

never_discard("unread")

keys['/'] = search_filter
keys['y'] = yank
