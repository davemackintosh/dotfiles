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

local icons = {
  batteryCharging = theme.dir .. "icons/baseline_battery_charging_full_white_18dp.png",
  brightness = theme.dir .. "icons/baseline_brightness_high_white_18dp.png",
  wifiConnected = theme.dir .. "icons/baseline_signal_wifi_4_bar_white_18dp.png",
  volumeOn = theme.dir .. "icons/baseline_volume_up_white_18dp.png",
  volumeOff = theme.dir .. "icons/baseline_volume_off_white_18dp.png",
}

local colourPalette = {
  "#ECD078",
  "#D95B43",
  "#C02942",
  "#542437",
  "#53777A",
  "#222222"
}

local transparent = "00000000"

local typographyColours = {
  normal = colourPalette[6],
  light = colourPalette[1]
}


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
  -- Each screen has its own tag table.
  awful.tag({ "code", "social", "browser", "misc" }, s, awful.layout.layouts[1])

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

  local function wiBarFont(text)
    return markup.font(theme.font .. " 11", text)
  end

  local function wiBarMargin(widget)
    return wibox.container.margin(widget, dpi(5), dpi(5))
  end

  local batteryWidget = lain.widget.bat({
    settings = function()
      if bat_now.status and bat_now.status ~= "N/A" then
        if bat_now.ac_status == 1 then
            widget:set_markup(wiBarFont(bat_now.perc .. "% ⚡"))
        end

        widget:set_markup(wiBarFont(bat_now.perc .. "%"))
      else
        widget:set_markup(wiBarFont(bat_now.perc .. "%"))
      end
    end
  })

  local wifi_icon = wibox.widget.imagebox()
  local eth_icon = wibox.widget.imagebox()
  local net = lain.widget.net {
      notify = "off",
      wifi_state = "on",
      eth_state = "on",
      settings = function()
          local eth0 = net_now.devices.eth0
          if eth0 then
              if eth0.ethernet then
                  eth_icon:set_image(ethernet_icon_filename)
              else
                  eth_icon:set_image()
              end
          end

          local wlan0 = net_now.devices.wlp2s0
          -- print(inspect(wlan0), icons.wifiConnected)
          if wlan0 then
              if wlan0.wifi then
                  -- local signal = wlan0.signal
                  -- if signal < -83 then
                      -- wifi_icon:set_image(wifi_weak_filename)
                  -- elseif signal < -70 then
                      -- wifi_icon:set_image(wifi_mid_filename)
                  -- elseif signal < -53 then
                      -- wifi_icon:set_image(wifi_good_filename)
                  -- elseif signal >= -53 then
                      wifi_icon:set_image(icons.wifiConnected)
                  -- end
              else
                  wifi_icon:set_image()
              end
          end
      end
  }

  -- Add widgets to the wibox
  s.mywibox:setup {
      layout = wibox.layout.align.horizontal,
      { -- Tags on the left.
          layout = wibox.layout.fixed.horizontal,
          s.mytaglist,
          s.mypromptbox,
      },
      wibox.widget({}), -- Middle widget to space out the left and right widgets.
      { -- Meta info on the right.
          layout = wibox.layout.fixed.horizontal,
          separators.arrow_left("alpha", colourPalette[3]),
          wibox.container.background(wibox.widget.textclock(), colourPalette[3]),
          separators.arrow_left(colourPalette[3], colourPalette[4]),
          wibox.container.background(wiBarMargin(batteryWidget.widget), colourPalette[4]),
          wibox.container.background(wibox.container.margin(wibox.widget.imagebox(icons.batteryCharging), dpi(0), dpi(5)), colourPalette[4]),
          separators.arrow_left(colourPalette[4], colourPalette[5]),
          wibox.container.background(wiBarMargin(wifi_icon), colourPalette[5]),
      },
  }

end)

return theme

