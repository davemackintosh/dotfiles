local awful = require("awful")
local watch = awful.widget.watch
local wibox = require("wibox")
local markup = require("lain.util.markup")
local vars = require("vars")

local getVolumePercCmd = 'amixer -D pulse sget Master'
local increaseVolumeCmd = 'amixer -D pulse sset Master 5%+'
local decreaseVolumeCmd = 'amixer -D pulse sset Master 5%-'
local toggleDeviceCmd = 'amixer -D pulse sset Master toggle'

local percWidget = wibox.widget.textbox()

local volumeWidget = wibox.widget {
  layout = wibox.layout.align.horizontal,
  {
    id = "perc",
    markup = markup.font(vars.typography.mainFont, "0%"),
    widget = percWidget,
    visible = true,
  },
  {
    id = "icon",
    image = vars.themeRoot .. "icons/baseline-volume_up-24px.svg",
    widget = wibox.widget.imagebox,
  },
}

local function checkIcon(widget, percOutput)
  local volume = tonumber(string.match(percOutput, "(%d?%d?%d)%%"))
  local muted = percOutput:match "%[(o%D%D?)%]+"

  percWidget:set_markup(markup.font(vars.typography.mainFont, volume .. "%"))

  if volume == 0 or muted == "on" then
    widget.image = vars.themeRoot .. "icons/baseline-volume_off-24px.svg"
  else
    widget.image = vars.themeRoot .. "icons/baseline-volume_up-24px.svg"
  end
end

volumeWidget:connect_signal("button::press", function(_,_,_,button)
  if button == 1 then
    awful.spawn.easy_async_with_shell(toggleDeviceCmd, function(stdout)
      checkIcon(volumeWidget, stdout)
    end)
  end
end)

awful.spawn.easy_async_with_shell(getVolumePercCmd, function(stdout)
  checkIcon(volumeWidget, stdout)
end)

return volumeWidget

