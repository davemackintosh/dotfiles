-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
local lain = require("lain")
require("awful.autofocus")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
local wibox = require("wibox")

local tags = { " code ", " browser ", "  social ", " misc " }

local themePath = os.getenv("HOME") .. "/.config/awesome/themes/mim"

-- local mpdwidget = dofile(themePath .. "/widgets/mpd.lua")

local separators = lain.util.separators

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
    text = tostring(err) })
    in_error = false
  end)
end
-- }}}

-- {{{ Variable definitions
beautiful.init("~/.config/awesome/themes/vex/theme.lua")
local apply_shape = require("utils").apply_shape

-- This is used later as the default terminal and editor to run.
terminal = "termite -e 'tmux -u'"
editor = os.getenv("EDITOR") or "nvim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
  awful.layout.suit.fair,
  awful.layout.suit.tile,
  awful.layout.suit.fair.horizontal,
}
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

client.connect_signal("manage", function (c)
  c.shape = function(cr,w,h)
    gears.shape.rounded_rect(cr, w, h, 15)
  end
end)

clientbuttons = awful.util.table.join(
awful.button({ }, 1, function (c)
  if c.name ~= "Onboard" then
    client.focus = c;
    c:raise() 
  end
end)
)

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
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
  -- Wallpaper
  set_wallpaper(s)

  -- Each screen has its own tag table.
  s.tags = awful.tag(tags, s, awful.layout.layouts[1])

  -- Create an imagebox widget which will contain an icon indicating which layout we're using.
  -- We need one layoutbox per screen.
  s.mylayoutbox = awful.widget.layoutbox(s)
end)

-- Close the current tag and open the one
-- in our tags table at the index.
local function openTagByIndex(index)
  awful.tag.viewtoggle(awful.tag.selected())
  awful.tag.viewtoggle(awful.tag.find_by_name(awful.screen.focused(), tags[index]))
end

-- {{{ Key bindings
globalkeys = gears.table.join(
awful.key({ modkey }, "XF86AudioRaiseVolume", function () awful.spawn.easy_async_with_shell("onboard", function() end) end),
awful.key({  }, "XF86MonBrightnessUp", function () beautiful.brightnessWidget.incBrightness() end, { desription = "Increase LCD brightness", group = "client" }),
awful.key({  }, "XF86MonBrightnessDown", function () beautiful.brightnessWidget.decBrightness() end, { desription = "Decrease LCD brightness", group = "client" }),
awful.key({  }, "XF86AudioRaiseVolume", function () beautiful.volumeWidget.incVolume() end, { description = "Increase volume", group = "media" }),
awful.key({  }, "XF86AudioLowerVolume", function () beautiful.volumeWidget.decVolume() end, { description = "Increase volume", group = "media" }),
awful.key({  }, "XF86AudioMute", function () beautiful.volumeWidget.toggleVolume() end, { description = "Increase volume", group = "media" }),

awful.key({modkey, }, "1", function() openTagByIndex(1) end),
awful.key({modkey, }, "2", function() openTagByIndex(2) end),
awful.key({modkey, }, "3", function() openTagByIndex(3) end),
awful.key({modkey, }, "4", function() openTagByIndex(4) end),

awful.key({ "Mod1", "Control", "Shift" }, "4", function()
  awful.spawn.easy_async_with_shell([===[
  TMP="/tmp/$RANDOM.png"
  import $TMP &&
  xclip -selection clipboard -t image/png -i $TMP &&
  rm -rf $TMP
  ]===], function() end)
end),

awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
{description = "view previous", group = "tag"}),
awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
{description = "view next", group = "tag"}),

awful.key({ modkey }, "Tab",
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
awful.key({ modkey, "Shift"   }, "q", awesome.quit,
{description = "log out", group = "awesome"}),

awful.key({ modkey, "Shift"   }, "space", function () os.execute("rofimoji.py")                end,
{description = "Show emoji picker", group = "typography"}),

-- Prompt
awful.key({ modkey }, "r",     function ()
  local screen = awful.screen.focused()
  screen.mypromptbox:run()
end,
{description = "run prompt", group = "launcher"}
),

awful.key({ modkey }, "e",     function ()
  local screen = awful.screen.focused()
  awful.popup {
    widget = {
      {
        {
          forced_height = 30,
          forced_width  = 100,
          widget        = screen.mypromptbox.widget
        },
        layout = wibox.layout.fixed.vertical,
      },
      margins = 10,
      widget  = wibox.container.margin
    },
    --border_color = '#00ff00',
    --border_width = 5,
    placement    = awful.placement.centered,
    shape        = gears.shape.rounded_rect,
    visible      = true,
    ontop = true
  }
end,
{description = "run prompt", group = "launcher"}
)
)

local function moveClientToTagIndex(index)
  -- get current tag
  local t = client.focus and client.focus.first_tag or nil
  if t == nil then
      return
  end
  -- get previous tag (modulo 9 excluding 0 to wrap from 1 to 9)
  local tag = client.focus.screen.tags[index]
  awful.client.movetotag(tag)
end

clientkeys = gears.table.join(
  awful.key({ "Control" }, "q", function (c) c:kill() end, {description = "close", group = "client"}),
  awful.key({ modkey, }, "o", function (c) c:move_to_screen() end, {description = "move to screen", group = "client"}),
  awful.key({ modkey, "Control", "Shift" }, 1, function() moveClientToTagIndex(1) end, {description = "move client to previous tag", group = "layout"}),
  awful.key({ modkey, "Control", "Shift" }, 2, function() moveClientToTagIndex(2) end, {description = "move client to previous tag", group = "layout"}),
  awful.key({ modkey, "Control", "Shift" }, 3, function() moveClientToTagIndex(3) end, {description = "move client to previous tag", group = "layout"}),
  awful.key({ modkey, "Control", "Shift" }, 4, function() moveClientToTagIndex(4) end, {description = "move client to previous tag", group = "layout"})
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
  -- All clients will match this rule.
  { 
    rule = { },
    properties = { 
      border_width = beautiful.border_width,
      border_color = beautiful.border_normal,
      focus = awful.client.focus.filter,
      raise = true,
      keys = clientkeys,
      buttons = clientbuttons,
      screen = awful.screen.preferred,
      placement = awful.placement.no_overlap + awful.placement.no_offscreen,
    }
  },

  {
    rule = {
      class = "Onboard",
    },
    properties = {
      border_width = 0,
      focusable = false,
    },
  },

  -- Floating clients.
  { 
    rule_any = {
      instance = {
        "pinentry",
        "peek",
        "xvkbd",
      },
      class = {
        "Arandr",
      },
    }, 
    properties = { 
      floating = true 
    }
  },

  { 
    rule_any = {
      type = { 
        "normal", 
        "dialog" 
      }
    }, 
    properties = { 
      titlebars_enabled = false 
    }
  },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
  if awesome.startup
    and not c.size_hints.user_position
    and not c.size_hints.program_position then
    -- Prevent clients from being unreachable after screen count changes.
    awful.placement.no_offscreen(c)
  end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Run our compositor.
awful.spawn.easy_async_with_shell("compton --config ~/.config/compton/compton.conf", function() end)

-- Turn bluetooth on. This needs moving to xinitrc I think.
-- would be nice to have wireless mouse/keyboard in XDG/LightDM.
awful.spawn.easy_async_with_shell("bluetoothctl power on", function() end)
awful.spawn.easy_async_with_shell("touchegg", function() end)

-- Mount Google drive.
awful.spawn.easy_async_with_shell("google-drive-ocamlfuse ~/google-drive", function() end)

-- Set up touch gestures.
awful.spawn.easy_async_with_shell("touchegg", function() end)
awful.spawn.easy_async_with_shell("onboard", function() end)

-- Open a terminal
awful.spawn.easy_async_with_shell(terminal, function() end)
