local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gears = require("gears")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local inspect = require("inspect")

local gfs = gears.filesystem
local dpi = xresources.apply_dpi
local themes_path = gfs.get_themes_dir()
local separators = lain.util.separators
local markup = lain.util.markup

local theme = {}
theme.name = string.gsub(debug.getinfo(1).short_src, "^(.+\\)[^\\]+$", "%1")
theme.dir = debug.getinfo( 1, "S" ).source:match( "/.*/" )

-- Update the package path so we can easily import our widgets
package.path = theme.dir .. '?.lua;' .. package.path

-- Import our widgets
local utils = require("utils")
local vars = require("vars")
local notificationStyles = require("notification-style")
local batteryWidget = require("widgets.battery")
local netWidget = require("widgets.net")
local clockWidget = require("widgets.clock")
local powerlineBarWidget = require(".widgets.powerline-widgets")
local taglistWidget = require("widgets.taglist")
local volumeWidget = require("widgets.volume")
local brightnessWidget = require("widgets.brightness")
local systemUpdatesWidget = require("widgets.updates")

-- Other stuff.
local healthTools = require("tools.health")

theme.volumeWidget = volumeWidget
theme.brightnessWidget = brightnessWidget

-- typography
theme.font          = vars.mainFont

-- colours
theme.bg_normal     = vars.colourPalette[6]
theme.bg_focus      = vars.colourPalette[5]
theme.bg_urgent     = vars.colourPalette[2]
theme.bg_minimize   = vars.colourPalette[1]
theme.bg_systray    = theme.bg_normal

theme.taglist_font = vars.typography.mainFont

theme.fg_normal     = vars.typographyColours.normal
theme.fg_focus      = vars.typographyColours.light
theme.fg_urgent     = vars.typographyColours.urgent
theme.fg_minimize   = vars.typographyColours.normal

theme.border_width  = dpi(4)
theme.border_normal = vars.colourPalette[6]
theme.border_focus  = vars.colourPalette[5]
theme.border_marked = vars.colourPalette[2]

-- Task list
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true

-- Pretty
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

-- Add the notification styles.
theme = gears.table.join(theme, notificationStyles)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = themes_path.."default/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

awful.screen.connect_for_each_screen(function(s)
  s.addPromptBox = false

  -- Create a taglist widget
  s.mytaglist = taglistWidget(s)

  s.mypromptbox = awful.widget.prompt()

  -- Create the wibox
  s.mywibox = awful.wibar({ 
    position = "top", 
    screen = s,
    opacity = 0,
    bg = "00000000"
  })

  -- Add widgets to the wibox
  s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      powerlineBarWidget({ s.mytaglist }, "arrow_right"), -- Left widgets
      wibox.container.margin(s.mypromptbox, 10), -- Centre widget
      powerlineBarWidget({ -- Right widgets
        clockWidget,
        batteryWidget.widget,
        brightnessWidget.widget,
        volumeWidget.widget,
        systemUpdatesWidget.widget,
        netWidget,
      })
  }

end)

-- These will send small notifications to 
-- remind you to be healthy while working at your computer.
healthTools.waterReminder()
healthTools.walkReminder()

return theme

