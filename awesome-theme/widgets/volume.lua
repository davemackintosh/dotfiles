local awful = require("awful")
local watch = awful.widget.watch
local wibox = require("wibox")
local markup = require("lain.util.markup")
local vars = require("vars")
local utils = require("utils")

local getVolumePercCmd = 'amixer -D pulse sget Master'
local increaseVolumeCmd = 'amixer -D pulse sset Master 5%+'
local decreaseVolumeCmd = 'amixer -D pulse sset Master 5%-'
local toggleDeviceCmd = 'amixer -D pulse sset Master toggle'

local percWidget = wibox.widget.textbox()

local volumeWidget = {}

local volumeIcon = wibox.widget.imagebox(vars.icons.volumeOff)

volumeWidget.widget = wibox.widget {
  layout = wibox.layout.align.horizontal,
  percWidget,
  utils.iconMargin(volumeIcon),
}

function volumeWidget.incVolume()
  awful.spawn.easy_async_with_shell(increaseVolumeCmd, function(stdout)
    volumeWidget:checkIcon(volumeWidget, stdout)
  end)
end

function volumeWidget.decVolume()
  awful.spawn.easy_async_with_shell(decreaseVolumeCmd, function(stdout)
    volumeWidget:checkIcon(volumeWidget, stdout)
  end)
end

function volumeWidget.toggleVolume()
  awful.spawn.easy_async_with_shell(toggleDeviceCmd, function(stdout)
    volumeWidget:checkIcon(volumeWidget, stdout)
  end)
end

function volumeWidget:updateIcon()
  awful.spawn.easy_async_with_shell(getVolumePercCmd, function(stdout)
    self:checkIcon(self, stdout)
  end)
end

function volumeWidget:checkIcon(widget, percOutput)
  local volume = tonumber(string.match(percOutput, "(%d?%d?%d)%%"))
  local muted = percOutput:match "%[(o%D%D?)%]+"

  if volume == 0 or muted == "on" then
    volumeIcon:set_image(vars.icons.volumeOff)
    percWidget:set_markup(markup.font(vars.typography.mainFont, ""))
  else
    volumeIcon:set_image(vars.icons.volumeOn)
  percWidget:set_markup(markup.font(vars.typography.mainFont, volume .. "%"))
  end
end

volumeWidget.widget:connect_signal("button::press", function(_,_,_,button)
  if button == 1 then
    awful.spawn.easy_async_with_shell(toggleDeviceCmd, function(stdout)
      volumeWidget:checkIcon(volumeWidget, stdout)
    end)
  end
end)

volumeWidget:updateIcon()

return volumeWidget

