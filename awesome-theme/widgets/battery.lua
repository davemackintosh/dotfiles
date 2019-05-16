local lain = require("lain")
local utils = require("utils")
local wibox = require("wibox")
local inspect = require("inspect")
local vars = require("vars")

local icons = require("vars").icons

local box = wibox()
local batteryImage = wibox.widget.imagebox(icons.batteryFull)
local batteryWidget = lain.widget.bat({
  image = batteryImage,
  timeout = 5,
  settings = function()
    if bat_now.ac_status == 1 then
      batteryImage:set_image(icons.batteryCharging)
    end

    widget:set_markup(utils.wiBarFont(lain.util.markup.font(vars.mainFont, bat_now.perc .. "%")))
  end
})

box:setup {
  layout = wibox.layout.align.horizontal,
  batteryWidget,
  utils.iconMargin(batteryImage),
}

return box

