local lain = require("lain")
local utils = require("utils")
local wibox = require("wibox")
local inspect = require("inspect")
local vars = require("vars")

local icons = vars.icons

local box = wibox()
local batteryImage = wibox.widget.imagebox(icons.batteryFull)
local batteryWidget = lain.widget.bat({
  image = batteryImage,
  timeout = 5,
  settings = function()
    if bat_now.perc <= 20 then
      batteryImage:set_image(vars.icons.battery20)
    elseif bat_now.perc <= 50 then
      batteryImage:set_image(vars.icons.battery50)
    elseif bat_now.perc <= 90 then
      batteryImage:set_image(vars.icons.battery90)
    else
      batteryImage:set_image(vars.icons.batteryFull)
    end

    if bat_now.ac_status == 1 then
      batteryImage:set_image(icons.batteryCharging)
    end

    widget:set_markup(utils.wiBarFont(bat_now.perc .. "%"))
  end
})

box:setup {
  layout = wibox.layout.align.horizontal,
  batteryWidget,
  utils.iconMargin(batteryImage),
}

return box

