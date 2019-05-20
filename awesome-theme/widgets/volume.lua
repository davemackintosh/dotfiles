local awful = require("awful")
local watch = awful.widget.watch
local wibox = require("wibox")
local markup = require("lain.util.markup")
local vars = require("vars")

local getVolumePercCmd = 'amixer sget Master'

-- Actual volume changes are handled by xbindkeys, see ~/.xbindkeysrc for more.

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

  percWidget:set_markup(markup.font(vars.typography.mainFont, volume .. "%"))

  if volume == 0 then
    widget.image = vars.themeRoot .. "icons/baseline-volume_off-24px.svg"
  else
    widget.image = vars.themeRoot .. "icons/baseline-volume_up-24px.svg"
  end
end

watch(getVolumePercCmd, 1, checkIcon, volumeWidget)

return volumeWidget

