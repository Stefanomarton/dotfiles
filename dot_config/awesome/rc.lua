------------------------------------------------ Module loading

 -- Error handling
require("main.error-handling")
pcall(require, "luarocks.loader")


local beautiful = require("beautiful")
local awesomebuttons = require("awesome-buttons.awesome-buttons")

-- Widgets
local volume_widget = require('awesome-wm-widgets.volume-widget.volume')
local cpu_widget = require("awesome-wm-widgets.cpu-widget.cpu-widget")
local ram_widget = require("awesome-wm-widgets.ram-widget.ram-widget")
local wibox = require("wibox")
local logout_popup = require("logout-popup-widget.logout-popup")

-- other configuration stuff here
beautiful.init("some_theme.lua")
local bling = require("bling")
beautiful.init("some_theme.lua")
local lain = require("lain")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
require("awful.hotkeys_popup.keys")

beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

----------------------------------------------- Variable definitions

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("nvim") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Layouts
-- Table of layouts to cover with awful.layout.inc, order matters.
 awful.layout.layouts = {
    lain.layout.centerwork,
    --bling.layout.centered,
    --awful.layout.suit.tile,
	-- bling.layout.centered,
    -- awful.layout.suit.tile.left,
    -- awful.layout.suit.tile.bottom,
    --awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    --awful.layout.suit.fair.horizontal,
    --awful.layout.suit.spiral,
    --awful.layout.suit.spiral.dwindle,
    --awful.layout.suit.max,
    --awful.layout.suit.magnifier,
    --awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
    --awful.layout.suit.max.fullscreen,
}

-- Default modkey
modkey = "Mod4"

------------------------------------------ Wallpaper settings

-- Wallpapersettings
local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
--screen.connect_signal("property::geometry", set_wallpaper)

---- When client get created
--client.connect_signal("manage", function(c)
--local t = awful.screen.focused().selected_tag
--    if #t:clients() == 1 then
--    local a = master_width_factor
--    else
--    local a = expand
--    end
--end)
--
---- When client get deleted
--client.connect_signal("unmanage", function(c)
-- local t = awful.screen.focused().selected_tag
--    if #t:clients() == 1 then
--    local a = master_width_factor
--    else
--    local a = expand
--    end
--end)
lain.layout.termfair.center.nmaster = 3
lain.layout.termfair.ncol    = 1
-------------------------------------------------------- Tag settigns

awful.tag.add("  ·  ", {
    layout             = lain.layout.centerwork,
    gap_single_client  = true,
    gap                = 15,
    screen             = 1,
    selected           = true,
})

awful.tag.add("  ·  ", {
    layout             = lain.layout.centerwork,
    gap_single_client  = true,
    gap                = 15,
    screen             = 1,
})

awful.tag.add("  ·  ", {
    layout             = lain.layout.centerwork,
    gap_single_client  = true,
    gap                = 15,
    screen             = 1,
})

awful.tag.add("  ·  ", {
    layout             = lain.layout.centerwork,
    gap_single_client  = true,
    gap                = 15,
    screen             = 1,
})


awful.tag.add("  ·  ", {
    layout             = awful.layout.suit.fair.horizontal,
    gap_single_client  = true,
    gap                = 15,
    screen             = 2,
    selected           = true,
})


awful.tag.add("  ·  ", {
    layout             = awful.layout.suit.fair.horizontal,
    gap_single_client  = true,
    gap                = 15,
    screen             = 2,
})


awful.tag.add("  ·  ", {
    layout             = awful.layout.suit.fair.horizontal,
    gap_single_client  = true,
    gap                = 15,
    screen             = 3,
    selected           = true,
})


awful.tag.add("  ·  ", {
    layout             = awful.layout.suit.fair.horizontal,
    gap_single_client  = true,
    gap                = 15,
    screen             = 3,
})

------------------------------------------- Wibar settings ------------------
awful.screen.connect_for_each_screen(function(s)

if s == screen.primary
    then

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()

local textclock_clr = wibox.widget.background()
textclock_clr:set_widget(mytextclock)
textclock_clr:set_fg("#ffffff")

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 250 } })
                                          end),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))
    -- Create a taglist widget
    s.mytaglist = wibox.container.place( awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons,
        style   = {
            shape = gears.shape.circle,
        },
        layout  = wibox.layout.fixed.horizontal
    })

    -- Create a tasklist widget
    s.mytasklist = wibox.container.place( awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style   ={
            shape = gears.shape.rounded_rect,
                    layout   = {
            valign = "center",
            halign = "center",
        },
        layout  = wibox.layout.align.horizontal

                    }
                } )

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, bg="#282a36", type="desktop", stretch = "false", opacity = 1})

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
        },
        s.mytasklist,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            ram_widget({ color_used='#ffffff',
            color_free='#ff79c6'
            }),
            cpu_widget({color = '#ff79c6'}),
            volume_widget{
            widget_type = "horizontal_bar",
            with_icon = true,
            mute_color = "#ff0000",
            main_color = "#50fa7b",
                            },
            textclock_clr,
            spacing = 10,
            wibox.widget.systray(),
        },
    }
end
end)
--------------------------------------------- Scratchpads ----------------

    -- Ranger
local term_scratch = bling.module.scratchpad {
    command = "kitty --class spad -e ranger GoogleDrive/Università",
    rule = { instance = "spad" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = {x=1100, y=280, height=900, width=1200},
   dont_focus_before_close  = true,
}

    -- Terminal
local term = bling.module.scratchpad {
    command = "kitty --class termscratch",
    rule = { instance = "termscratch" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = {x=1100, y=280, height=900, width=1200},
    dont_focus_before_close  = true,
}

    -- Mixer
local mixer = bling.module.scratchpad {
    command = "kitty --class mixer -e pulsemixer",
    rule = { instance = "termscratch" },
    sticky = true,
    autoclose = true,
    floating = true,
    geometry = {x=1100, y=280, height=900, width=1200},
    dont_focus_before_close  = true,
}

---------------------------------- Key bindings ----------------------

--- Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))


--- Key bindings

globalkeys = gears.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),
awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,"Shift"}, "q", function () logout_popup.launch ()end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulatior
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_bydirection("left") end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_bydirection("right") end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),
    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "s",     function ()
	awful.util.spawn("rofi -show drun -config ~/.config/rofi/rofidmenu.rasi") end,
              {description = "run prompt", group = "launcher"}),
    awful.key({ modkey,           }, "a", function () awful.spawn("firefox") end,
              {description = "open a terminal", group = "launcher"}),
    -- Scratchpads
    awful.key ( { modkey}, "w", function() term_scratch:turn_on() end),
    awful.key ( { modkey}, "t", function() term:turn_on() end),
    awful.key ( { modkey}, "m", function() mixer:turn_on() end),
   -- Menubar
    awful.key({ modkey }, "p", function() awful.util.spawn("dmenu_run -c -g 3 -o 0.2 -fn 'Droid Sans Mono-14' -l 10 -h 20 -bw 1") end,
              {description = "show the menubar", group = "launcher"}),
    awful.key({"Mod1", "Shift"}, "2", function() awful.spawn.with_shell ("flameshot gui")

 end, {description = "Window Switcher", group = "bling"})
 )

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, }, "q",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ "Mod1",}, "space", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "+",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.


for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),

        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ "Mod1",}, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"}))
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

------------------------------------------------- Rules -----------------
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = 3,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false }
    },

 { rule = { class = "discord" },
 properties = { screen = 2, tag = "1" } },

 { rule = { class = "spotify" },
 properties = { screen = 3, tag = "1" } },

 { rule = { class = "Microsoft Teams - Preview" },
 properties = { screen = 2, tag = "1" } },
   }

---------------------------------------- Signals ----------------------

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
     if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
      --
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
 client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
 end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}


---------------------------------- Autostart -----------

awful.spawn.with_shell("xset r rate 300 60")
awful.spawn("picom")
awful.spawn.with_shell("nm-applet")
awful.spawn("overgrive")
awful.spawn.with_shell("~/.screenlayout/monitor.sh")
awful.spawn.with_shell("xmodmap ~/.Xmodmap")
--awful.spawn.with_shell("python ~/.config/awesome/autohidewibox.py")

screen.connect_signal("property::geometry", set_wallpaper)
-- Wallpaper
beautiful.init("~/.config/awesome/theme.lua")
for s = 1, screen.count() do
	gears.wallpaper.maximized(beautiful.wallpaper, s, true)
end


beautiful.tasklist_disable_icon = "true"
bling.module.flash_focus.enable()
beautiful.notification_icon_size = 64
