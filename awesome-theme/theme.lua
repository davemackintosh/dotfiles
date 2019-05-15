local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local gfs = require("gears.filesystem")
local lain = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")

local dpi = xresources.apply_dpi

local themes_path = gfs.get_themes_dir()

local colourPalette = {
  "#ECD078",
  "#D95B43",
  "#C02942",
  "#542437",
  "#53777A",
  "#222222"
}

local typographyColours = {
  normal = colourPalette[6],
  light = colourPalette[1]
}
local separators = lain.util.separators

local theme = {}

theme.name = string.gsub(debug.getinfo(1).short_src, "^(.+\\)[^\\]+$", "%1")
theme.dir = debug.getinfo( 1, "S" ).source:match( "/.*/" )

-- typography
theme.font          = "Fira Mono 11"

-- colours
theme.bg_normal     = colourPalette[6]
theme.bg_focus      = colourPalette[5]
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#CFCFCF"
theme.fg_focus      = "#32d6ff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = dpi(4)
theme.border_normal = "#000000"
theme.border_focus  = "#5b92fa"
theme.border_marked = "#91231c"
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon = true

theme.useless_gap = 7
theme.wallpaper = theme.dir .. "/wallpapers/80s.jpg"

-- Generate taglist squares:
local taglist_square_size = dpi(4)
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

-- You can use your own layout icons like this:
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

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
  end)
)

awful.screen.connect_for_each_screen(function(s)
  -- Create a taglist widget
  s.mytaglist = awful.widget.taglist {
      screen  = s,
      filter  = awful.widget.taglist.filter.all,
--      buttons = taglist_buttons
  }

  s.mypromptbox =  awful.widget.prompt()

  -- Create a tasklist widget
  s.mytasklist = awful.widget.tasklist {
      screen  = s,
      filter  = awful.widget.tasklist.filter.currenttags,
      buttons = tasklist_buttons,
      opacity = 0,
      visible = false
  }

  -- Create the wibox
  s.mywibox = awful.wibar({ 
    position = "top", 
    screen = s,
    opacity = 0,
    bg = "00000000"
  })

  local batteryWidget = lain.widget.bat({
    settings = function()
      if bat_now.status and bat_now.status ~= "N/A" then
          if bat_now.ac_status == 1 then
              widget:set_markup(lain.util.markup.font(theme.font, " " .. bat_now.perc .. "% ⚡ "))
          end

          widget:set_markup(lain.util.markup.font(theme.font, " " .. bat_now.perc .. "% "))
        end
    end
  })

  -- Add widgets to the wibox
  s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Left widgets
          layout = wibox.layout.fixed.horizontal,
          s.mytaglist,
          s.mypromptbox,
      },
      wibox.widget({}), -- Middle widget
      { -- Right widgets
          layout = wibox.layout.fixed.horizontal,
          separators.arrow_left(colourPalette[6], colourPalette[3]),
          wibox.container.background(wibox.widget.textclock(), colourPalette[3]),
          separators.arrow_left(colourPalette[3], colourPalette[4]),
          wibox.container.background(batteryWidget.widget, colourPalette[4]),
          separators.arrow_left(colourPalette[4], colourPalette[5]),
          wibox.container.background(wibox.container.margin(awful.widget.layoutbox(s), dpi(5)), colourPalette[5]),
      },
  }

end)

return theme

