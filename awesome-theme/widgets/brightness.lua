local awful = require("awful")
local wibox = require("wibox")
local markup = require("lain.util.markup")
local vars = require("vars")
local utils = require("utils")

local getBrightnessPercCmd = '/usr/bin/light'
local increaseBrightnessCmd = '/usr/bin/light -A 5'
local decreaseBrightnessCmd = '/usr/bin/light -U 5'

local brightnessWidget = {}
local percWidget = wibox.widget.textbox()
local brightnessIcon = wibox.widget.imagebox(vars.icons.brightness)

brightnessWidget.widget = wibox.widget {
  layout = wibox.layout.align.horizontal,
  percWidget,
  utils.iconMargin(brightnessIcon),
}

function brightnessWidget.incBrightness()
  awful.spawn.easy_async_with_shell(increaseBrightnessCmd, function()
    brightnessWidget:updateIcon()
  end)
end

function brightnessWidget.decBrightness()
  awful.spawn.easy_async_with_shell(decreaseBrightnessCmd, function()
    brightnessWidget:updateIcon()
  end)
end

function brightnessWidget:updateIcon()
  awful.spawn.easy_async_with_shell(getBrightnessPercCmd, function(stdout)
    self:checkIcon(self, stdout)
  end)
end

function brightnessWidget:checkIcon(widget, brightnessRaw)
  local brightness = math.floor(tonumber(brightnessRaw))
  percWidget:set_markup(markup.font(vars.typography.mainFont, brightness .. "%"))
end

brightnessWidget:updateIcon()

return brightnessWidget

