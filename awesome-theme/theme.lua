local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gfs = require("gears.filesystem")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local inspect = require("inspect")

local dpi = xresources.apply_dpi

local themes_path = gfs.get_themes_dir()
local separators = lain.util.separators
local markup = lain.util.markup

local theme = {}
theme.name = string.gsub(debug.getinfo(1).short_src, "^(.+\\)[^\\]+$", "%1")
theme.dir = debug.getinfo( 1, "S" ).source:match( "/.*/" )

package.path = theme.dir .. '?.lua;' .. package.path

local utils = require("utils")
local vars = require("vars")
local batteryWidget = require("widgets.battery")
local netWidget = require("widgets.net")
local powerlineBarWidget = require(".widgets.powerline-widgets")

local transparent = "00000000"

-- typography
theme.font          = "Fira Mono 11"

-- colours
theme.bg_normal     = vars.colourPalette[6]
theme.bg_focus      = vars.colourPalette[5]
theme.bg_urgent     = vars.colourPalette[2]
theme.bg_minimize   = vars.colourPalette[1]
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = vars.typographyColours.normal
theme.fg_focus      = vars.typographyColours.light
theme.fg_urgent     = vars.typographyColours.urgent
theme.fg_minimize   = vars.typographyColours.normal

theme.border_width  = dpi(4)
theme.border_normal = vars.colourPalette[6]
theme.border_focus  = vars.colourPalette[5]
theme.border_marked = vars.colourPalette[2]
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true

theme.useless_gap = 7
theme.wallpaper = theme.dir .. "/wallpapers/80s.jpg"

-- Generate taglist squares:
local taglist_square_size = dpi(0)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming notifications:
-- notification_font
-- notification_[bg|fg]
-- notification_[width|height|margin]
-- notification_[border_color|border_width|shape|opacity]

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

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

awful.screen.connect_for_each_screen(function(s)
  s.addPromptBox = false

  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
      screen  = s,
      filter  = awful.widget.taglist.filter.all,
  }

  s.mypromptbox =  awful.widget.prompt()

  -- Create the wibox
  s.mywibox = awful.wibar({ 
    position = "top", 
    screen = s,
    opacity = 0,
    bg = transparent
  })

  -- Add widgets to the wibox
  s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      powerlineBarWidget({ s.mytaglist }, "arrow_right"), -- Left widgets
      wibox.container.margin(s.mypromptbox, 5), -- Centre widget
      powerlineBarWidget({ -- Right widgets
        wibox.widget.textclock(),
        batteryWidget.widget,
        netWidget,
      })
  }

end)

return theme

