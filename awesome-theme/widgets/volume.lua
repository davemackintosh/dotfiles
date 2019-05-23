local awful = require("awful")
local watch = awful.widget.watch
local wibox = require("wibox")
local markup = require("lain.util.markup")
local vars = require("vars")
local utils = require("utils")

local getVolumePercCmd = [===[
	pactl list sinks | grep '^[[:space:]]Volume:' | \
    head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,'
]===]
local getMutedCmd = 'pactl list sinks | grep "^[[:space:]]Mute:"'
local increaseVolumeCmd = 'pactl set-sink-volume @DEFAULT_SINK@ +5%'
local decreaseVolumeCmd = 'pactl set-sink-volume @DEFAULT_SINK@ -5%'
local toggleDeviceCmd = 'pactl set-sink-mute @DEFAULT_SINK@ toggle'

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
    volumeWidget:updateIcon()
  end)
end

function volumeWidget.decVolume()
  awful.spawn.easy_async_with_shell(decreaseVolumeCmd, function(stdout)
    volumeWidget:updateIcon()
  end)
end

function volumeWidget.toggleVolume()
  awful.spawn.easy_async_with_shell(toggleDeviceCmd, function(stdout)
    volumeWidget:updateIcon()
  end)
end

function volumeWidget:updateIcon()
  awful.spawn.easy_async_with_shell(getVolumePercCmd, function(volume)
		awful.spawn.easy_async_with_shell(getMutedCmd, function(muted)
    	self:checkIcon(self, tonumber(volume), muted)
		end)
  end)
end

function volumeWidget:checkIcon(widget, volume, muted)
  local muted = muted:match "Mute: (%D)"

  if volume == 0 or muted == "y" then
    volumeIcon:set_image(vars.icons.volumeOff)
    percWidget:set_markup(markup.font(vars.typography.mainFont, ""))
  else
    volumeIcon:set_image(vars.icons.volumeOn)
    percWidget:set_markup(markup.font(vars.typography.mainFont, volume .. "%"))
  end
end

volumeWidget.widget:connect_signal("button::press", function(_,_,_,button)
  if button == 1 then
      volumeWidget.toggleVolume()
  end
end)

volumeWidget:updateIcon() -- Do the initial draw

return volumeWidget

