local wibox = require("wibox")
local awful = require("awful")
local timer = require("gears.timer")
local spawn = awful.spawn
local vars = require("vars")
local utils = require("utils")
local markup = require("lain.util.markup")

local updateWidget = {}

local getUpdateCountCmd = "pacman -Qu"

local updateIcon = wibox.widget.imagebox(vars.icons.systemUpdates)
local textWidget = wibox.widget.textbox()

local getAvailableUpdates

updateWidget.widget = wibox.widget {
  layout = wibox.layout.align.horizontal,
  textWidget,
  utils.iconMargin(updateIcon),
}

function trim(s)
   return s:gsub("^%s+", ""):gsub("%s+$", "")
end

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
  spawn.easy_async(getUpdateCountCmd, function(stdout) 
    local _, count = stdout:gsub('\n', '\n')
    updateWidget:update(count)
  end)
end

timer {
  timeout = 3600,
  call_now = true,
  autostart = true,
  callback = function() updateWidget:getUpdates() end,
}

return updateWidget
