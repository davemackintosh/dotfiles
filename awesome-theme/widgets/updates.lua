local wibox = require("wibox")
local awful = require("awful")
local spawn = awful.spawn
local vars = require("vars")
local utils = require("utils")
local markup = require("lain.util.markup")

local updateWidget = {}

local getUpdateCountCmd = "pacman -Sup --noprogressbar | wc -l"

local updateIcon = wibox.widget.imagebox(vars.icons.systemUpdates)
local textWidget = wibox.widget.textbox()

local getAvailableUpdates

updateWidget.widget = wibox.widget {
  layout = wibox.layout.align.horizontal,
  textWidget,
  utils.iconMargin(updateIcon),
}

function updateWidget:update(count)
  if count ~= nil then
    textWidget:set_markup(markup.font(vars.typography.mainFont, count))
    updateIcon:set_image(vars.icons.systemUpdates)
  else
    textWidget:set_markup(markup.font(vars.typography.mainFont, ""))
    updateIcon:set_image()
  end
end

function updateWidget:getUpdates()
  spawn.easy_async_with_shell(getUpdateCountCmd, function(stdout) updateWidget:update(stdout) end)
end

updateWidget:getUpdates()

awful.widget.watch(getUpdateCountCmd, 3600, function(_, stdout) updateWidget:update(stdout) end)

return updateWidget
