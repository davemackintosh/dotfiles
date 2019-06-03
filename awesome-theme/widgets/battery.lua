local lain = require("lain")
local utils = require("utils")
local gears = require("gears")
local wibox = require("wibox")
local vars = require("vars")
local notify = require("naughty").notify
local notificationStyles = require("notification-style")

local icons = vars.icons

local box = wibox()
local batteryImage = wibox.widget.imagebox(icons.batteryFull)
local batteryWidget = lain.widget.bat({
  image = batteryImage,
  timeout = 5,
  full_notify = "off",
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

    bat_notification_low_preset = gears.table.join(
      notificationStyles,
      {
        bg = vars.colourPalette[4],
        fg = vars.typographyColours.normal,
        title = "Battery low " .. bat_now.perc .. "%",
        text = "Plug in the charger soon to avoid a shutdown",
        timeout = 15
      }
    )

    bat_notification_critical_preset = gears.table.join(
      notificationStyles,
      {
        bg = vars.colourPalette[2],
        title = "Battery nearly dead.",
        text = "SAVE YOUR WORK. Go get a charger.",
        timeout = 15
      }
    )
  end
})

box:setup {
  layout = wibox.layout.align.horizontal,
  batteryWidget,
  utils.iconMargin(batteryImage),
}

return box

