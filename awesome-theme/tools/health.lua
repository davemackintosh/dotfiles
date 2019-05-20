local gears = require("gears")
local naughty = require("naughty")

-- Water reminder.
local function waterReminder()
  gears.timer {
      timeout   = 3600,
      call_now  = false,
      autostart = true,
      callback  = function()
        naughty.notify({
          text = "It's important to stay hydrated, go grab some water. 🌊",
          title = "Be good to yourself!"
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
          text = "Stay active, sitting isn't good for your back, eyes or your heart. Take a quick walk around the block.",
          title = "Be good to yourself!"
        })
      end
  }
end

return {
  waterReminder = waterReminder,
  walkReminder = walkReminder
}

