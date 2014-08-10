-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
-- Widget library
local vicious = require("vicious")
-- Expose effect
local revelation = require("revelation")
-- Run shell scripts
local bashets = require("bashets")
-- Window switching
local aweswt = require("aweswt")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init("/home/josh/.config/awesome/themes/custom/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "urxvtc"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
--    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier
}
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = { 
  settings = { names  = { "www", "term", "media", "file", "im", "misc" },
      layout = { layouts[8], layouts[2], layouts[8], layouts[8], layouts[1], layouts[1] } } }
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.settings.names, s, tags.settings.layout)
end
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   { "lock", "xscreensaver-command -lock"},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mypowermenu = {
   { "suspend", "ktsuss pm-suspend" },
   { "reboot", "ktsuss systemctl reboot" },
   { "poweroff", "ktsuss systemctl poweroff" }
}

mymainmenu = awful.menu({ 
          items = { 
                  { "awesome", myawesomemenu, beautiful.awesome_icon },
									{ "-------------", nil },
   							  { "&chromium", "chromium", "/usr/share/icons/hicolor/16x16/apps/chromium.png" },
   								{ "&thunar", "thunar", "/usr/share/icons/hicolor/16x16/apps/Thunar.png" },
									{ "-------------", nil },
                  { "open terminal", terminal },
									{ "power", mypowermenu }
          }
})

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
menubar.cache_entries = true
menubar.app_folders = "/usr/bin/"
menubar.show_categories = false
-- }}}

-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock()

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
statusbox= {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() then
                                                      awful.tag.viewonly(c:tags()[1])
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, function ()
                                              if instance then
                                                  instance:hide()
                                                  instance = nil
                                              else
                                                  instance = awful.menu.clients({ width=250 })
                                              end
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                              if client.focus then client.focus:raise() end
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                              if client.focus then client.focus:raise() end
                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylauncher)
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(mytextclock)
    right_layout:add(mylayoutbox[s])

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

	mywibox[s]:set_widget(layout)

	separator = wibox.widget.textbox()
	separator:set_text("  :: ")
	spacer 	  = wibox.widget.textbox()
	spacer:set_text(" ")

	-- Initialize widgets
	cpuwidget = wibox.widget.textbox()
	memwidget = wibox.widget.textbox()
	mpdwidget = wibox.widget.textbox()
	weawidget = wibox.widget.textbox()
	hddwidget = wibox.widget.textbox()
	pkgwidget = wibox.widget.textbox()
	gmlwidget = wibox.widget.textbox()
	-- Widget icons
	cpuicon = wibox.widget.imagebox()
	cpuicon:set_image(awful.util.getdir("config") .. "/icons/cpu.png")
	cpuicon.resize = false
	memicon = wibox.widget.imagebox()
	memicon:set_image(awful.util.getdir("config") .. "/icons/memory.png")
	memicon.resize = false
	mpdicon = wibox.widget.imagebox()
	mpdicon:set_image(awful.util.getdir("config") .. "/icons/note1.png")
	mpdicon.resize = false
	weaicon = wibox.widget.imagebox()
	weaicon:set_image(awful.util.getdir("config") .. "/icons/temp.png")
	weaicon.resize = false
	hddicon = wibox.widget.imagebox()
	hddicon:set_image(awful.util.getdir("config") .. "/icons/shelf.png")
	hddicon.resize = false
	pkgicon = wibox.widget.imagebox()
	pkgicon:set_image(awful.util.getdir("config") .. "/icons/pacman.png")
	pkgicon.resize = false
	gmlicon = wibox.widget.imagebox()
	gmlicon:set_image(awful.util.getdir("config") .. "/icons/mail.png")
	gmlicon.resize = false
	-- Register widgets
	vicious.register(cpuwidget, vicious.widgets.cpu, "$1% $2% $3% $4%")
	vicious.register(memwidget, vicious.widgets.mem, "$1% ($2MB/$3MB)", 13)
	vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == "Stop" then 
            return " - "
        else 
            return args["{Artist}"]..' - '.. args["{Title}"]
        end
    end, 10)
	vicious.register(weawidget, vicious.widgets.weather, "Glendale, AZ ${tempf}° ${sky}", 3600, "KGEU") 
	vicious.register(hddwidget, vicious.widgets.fs, "${/ used_gb} GB/${/ size_gb} GB", 3600)
	vicious.register(pkgwidget, vicious.widgets.pkg, "$1", 3600, "Arch")
	vicious.register(gmlwidget, vicious.widgets.gmail, "${count}", 300)

	statusbox[s] = awful.wibox({ position = "bottom", height = 14, screen = s })

	local left_widgets = wibox.layout.fixed.horizontal()
	left_widgets:add(cpuicon)
	left_widgets:add(cpuwidget)
	left_widgets:add(separator)
	left_widgets:add(memicon)
	left_widgets:add(memwidget)
	left_widgets:add(separator)
	left_widgets:add(hddicon)
	left_widgets:add(hddwidget)
	left_widgets:add(separator)
	left_widgets:add(pkgicon)
	left_widgets:add(pkgwidget)
	left_widgets:add(separator)
	left_widgets:add(weaicon)
	left_widgets:add(weawidget)
	left_widgets:add(separator)
	left_widgets:add(gmlicon)
	left_widgets:add(gmlwidget)
	
	local right_widgets = wibox.layout.fixed.horizontal()
	right_widgets:add(mpdicon)
	right_widgets:add(mpdwidget)
	
	local all_widgets = wibox.layout.align.horizontal()
	all_widgets:set_left(left_widgets)
	all_widgets:set_right(right_widgets)
	
	statusbox[s]:set_widget(all_widgets)
end
-- }}}

-- {{{ Cover art display
mpdwidget:connect_signal("mouse::enter", function()
	coverart_show()
end)

mpdwidget:connect_signal("mouse::leave", function()
	coverart_hide()
end)

local coverart_nf
function coverart_show()
    -- destroy old popup, needed when bound to a key
    coverart_hide()
    local img = awful.util.pread("/home/josh/bin/coverart.sh")
    local ico = img
    local txt = awful.util.pread("/home/josh/bin/musicinfo.sh")
    -- set desired position of popup during creation
    coverart_nf = naughty.notify({icon = ico, icon_size = 100, text = txt, position = "bottom_right"})
end

function coverart_hide()
    if coverart_nf ~= nil then
	    naughty.destroy(coverart_nf)
    end
end

ctitle = ""
function mpd_callback(data)
	if data[1] ~= ctitle then                     --here "1" may be "3" or "2", or any other number of your variable
		ctitle = data[1]
		coverart_show()                       
	end
end
--bashets.register("mpd.sh", {update_time = 1, separator = "|", callback = mpd_callback})
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run({ prompt = "Run Lua code: " },
                  mypromptbox[mouse.screen].widget,
                  awful.util.eval, nil,
                  awful.util.getdir("cache") .. "/history_eval")
              end),
	-- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),

	--awful.key({ modkey }, "v",				  function () awful.util.spawn("fehlstart --one-way") end)
	awful.key({ modkey }, "e", revelation),
	awful.key({ modkey }, "v", function () 
		awful.util.spawn("dmenu_run -i -p 'Run command:' -nb '" .. 
 				beautiful.bg_normal .. "' -nf '" .. beautiful.fg_normal .. 
				"' -sb '" .. beautiful.bg_focus .. 
				"' -sf '" .. beautiful.fg_focus .. "'") 
			end),
	awful.key({ }, "Print", function () awful.util.spawn("scrot -e 'mv $f ~/Pictures/Screenshots/ 2>/dev/null'") end),
	awful.key({ modkey,           }, "slash", function () coverart_show() end),
	awful.key({ modkey }, "a", aweswt.switch),
  awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("ncmpcpp toggle") end),
  awful.key({ }, "XF86AudioNext", function () awful.util.spawn("ncmpcpp next") end),
  awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("ncmpcpp prev") end),
  awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn_with_shell("~/bin/pa_vol up") end),
  awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn_with_shell("~/bin/pa_vol down") end),
  awful.key({ }, "XF86AudioMute", function () awful.util.spawn_with_shell("~/bin/pa_vol mute") end),
  awful.key({ modkey , "Control", "Shift" }, "l", function () awful.util.spawn("xscreensaver-command -lock") end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(9, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     maximized_vertical   = false,
                     maximized_horizontal = false,
					           size_hints_honor = false } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { tag = tags[1][3],
		  			 floating = true } },
    { rule = { class = "Thunar" },
      properties = { tag = tags[1][4] } },
	{ rule = { class = "Pcmanfm" },
	  properties = { tag = tags[1][4] } },
	{ rule = { class = "luakit" },
	  properties = { tag = tags[1][1] } },
	{ rule = { class = "dwb" },
	  properties = { tag = tags[1][1] } },
	{ rule = { class = "URxvt" },
	  properties = { tag = tags[1][2] } },
	{ rule = { class = "Firefox" },
	  properties = { tag = tags[1][1] } },
	{ rule = { class = "Viewnior" },
	  properties = { tag = tags[1][3] } },
 	{ rule = { class = "Smplayer" },
	  properties = { tag = tags[1][3],
	  				 floating = true } },
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Automatically give window a titlebar
    processfloating = function(c)
        if awful.client.floating.get(c) then
            awful.titlebar(c)
        else
            awful.titlebar(c, {size = 0})
        end
    end

    processfloating(c)
    c:connect_signal("property::floating", processfloating)
    
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local title = awful.titlebar.widget.titlewidget(c)
        title:buttons(awful.util.table.join(
                awful.button({ }, 1, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.move(c)
                end),
                awful.button({ }, 3, function()
                    client.focus = c
                    c:raise()
                    awful.mouse.client.resize(c)
                end)
                ))

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(title)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
