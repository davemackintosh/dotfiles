local awful = require("awful")
local watch = awful.widget.watch
local wibox = require("wibox")
local markup = require("lain.util.markup")
local vars = require("vars")

local getBrightnessPercCmd = '/usr/bin/light'

-- Actual volume changes are handled by xbindkeys, see ~/.xbindkeysrc for more.

local percWidget = wibox.widget.textbox()

local brightnessWidget = wibox.widget {
  layout = wibox.layout.align.horizontal,
  {
    id = "perc",
    markup = markup.font(vars.typography.mainFont, "0%"),
    widget = percWidget,
    visible = true,
  },
  {
    id = "icon",
    image = vars.themeRoot .. "icons/baseline-brightness_high-24px.svg",
    widget = wibox.widget.imagebox,
  },
}

local function checkIcon(widget, brightnessRaw)
  local brightness = tonumber(brightnessRaw)
  percWidget:set_markup(markup.font(vars.typography.mainFont, brightness .. "%"))
end

watch(getBrightnessPercCmd, 60, checkIcon, brightnessWidget)

return brightnessWidget

