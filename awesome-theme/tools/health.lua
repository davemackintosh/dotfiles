local gears = require("gears")
local naughty = require("naughty")
local wibox = require("wibox")
local markup = require("lain.util.markup")
local vars = require("vars")
local notificationStyles = require("notification-style")

-- Water reminder.
local function waterReminder()
  gears.timer {
      timeout   = 3600,
      call_now  = false,
      autostart = true,
      callback  = function()
        naughty.notify({
          text = "It's important to stay hydrated, go grab some water. 🌊",
          title = "Be good to yourself!",
          shape = notificationStyles.notification_shape,
          bg = notificationStyles.notification_bg,
          fg = notificationStyles.notification_fg,
          margin = notificationStyles.notification_margin,
          font = notificationStyles.notification_font,
          notification_spacing = 10
        })
      end
  }
end

-- Take a walk reminder
local function walkReminder()
  gears.timer {
      timeout   = 7200,
      call_now  = false,
      autostart = true,
      callback  = function()
        naughty.notify({
          text = "Stay active, sitting isn't good for your back, eyes or your heart. \nTake a quick walk around the block.",
          title = "Be good to yourself!",
          shape = notificationStyles.notification_shape,
          bg = notificationStyles.notification_bg,
          fg = notificationStyles.notification_fg,
          margin = notificationStyles.notification_margin,
          font = notificationStyles.notification_font,
          notification_spacing = 10
        })
      end
  }
end

return {
  waterReminder = waterReminder,
  walkReminder = walkReminder
}

